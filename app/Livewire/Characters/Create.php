<?php

namespace App\Livewire\Characters;

use Livewire\Component;
use Livewire\Attributes\Layout;
use App\Models\Character;
use App\Models\Campaign;
use App\Models\CampaignUser;
use App\Models\Race;
use App\Models\CharacterClass;
use App\Models\Alignment;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

#[Layout('components.layouts.app')]
class Create extends Component
{
    public Campaign $campaign;
    public CampaignUser $enrollment;
    
    // Dados do personagem
    public $character_name = '';
    public $race_id = '';
    public $class_id = '';
    public $alignment_id = '';
    public $gender = '';
    public $age = '';
    public $height = '';
    public $weight = '';
    
    // Índice da raça selecionada no carrossel
    public int $selectedRaceIndex = 0;
    
    // Atributos (FOR, DES, CON, INT, SAB, CAR)
    public $characterAttributes = [
        1 => 10, // FOR
        2 => 10, // DES
        3 => 10, // CON
        4 => 10, // INT
        5 => 10, // SAB
        6 => 10, // CAR
    ];
    
    public function mount(Campaign $campaign)
    {
        // Verificar se usuário está aceito na campanha
        $this->enrollment = CampaignUser::where('campaign_id', $campaign->id)
            ->where('user_id', Auth::id())
            ->where('status', 'accepted')
            ->firstOrFail();
            
        // Verificar se já tem personagem
        if ($this->enrollment->character_id) {
            return redirect()->route('characters.show', $this->enrollment->character_id);
        }
        
        $this->campaign = $campaign;
        
        // Inicializar raça selecionada
        $restrictedRaces = $campaign->rules['allowed_races'] ?? [];
        $races = Race::all();
        
        if ($races->count() > 0) {
            // Se tiver restrições, tenta pegar uma que NÃO esteja na lista
            // Se restrictedRaces tem IDs, evitamos eles.
            $allowedRace = $races->first(function($race) use ($restrictedRaces) {
                return !in_array($race->id, $restrictedRaces);
            });
            
            $initialRace = $allowedRace ?? $races->first();

            $this->race_id = $initialRace->id;
            // Encontrar o índice da raça inicial na coleção completa
            $this->selectedRaceIndex = $races->search(function($race) use ($initialRace) {
                return $race->id === $initialRace->id;
            });
        }
    }
    
    public function getPointsUsedProperty()
    {
        $total = 0;
        foreach ($this->characterAttributes as $score) {
            $total += $this->getPointCost($score);
        }
        return $total;
    }
    
    public function getPointsAvailableProperty()
    {
        return $this->campaign->rules['points'] ?? 79;
    }

    public function getRaceModifiersProperty()
    {
        $race = Race::find($this->race_id);
        if (!$race) return [];
        
        return $race->abilities()->pluck('adjustment', 'ability_id')->toArray();
    }
    
    public function prevRace()
    {
        $races = Race::all();
        $count = $races->count();
        
        if ($count > 0) {
            $this->selectedRaceIndex = ($this->selectedRaceIndex - 1 + $count) % $count;
            $this->race_id = $races[$this->selectedRaceIndex]->id;
        }
    }
    
    public function nextRace()
    {
        $races = Race::all();
        $count = $races->count();
        
        if ($count > 0) {
            $this->selectedRaceIndex = ($this->selectedRaceIndex + 1) % $count;
            $this->race_id = $races[$this->selectedRaceIndex]->id;
        }
    }
    
    public function selectRaceByIndex($index)
    {
        $races = Race::all();
        
        if ($index >= 0 && $index < $races->count()) {
            $this->selectedRaceIndex = $index;
            $this->race_id = $races[$index]->id;
        }
    }
    
    public function create()
    {
        $this->validate([
            'character_name' => 'required|min:3|max:50',
            'race_id' => 'required|exists:races,id',
            'class_id' => 'required|exists:classes,id',
            'alignment_id' => 'required|exists:alignments,id',
            'gender' => 'nullable|string|max:20',
            'age' => 'nullable|integer|min:1',
            'height' => 'nullable|string|max:20',
            'weight' => 'nullable|string|max:20',
        ]);
        
        // Validar raça permitida (Logic Inverted: restricted_races whitelist -> blacklist)
        $restrictedRaces = $this->campaign->rules['allowed_races'] ?? [];
        if (!empty($restrictedRaces) && in_array($this->race_id, $restrictedRaces)) {
            $this->addError('race_id', 'Esta raça foi restringida pelo mestre nesta campanha.');
            return;
        }
        
        // Validar classe permitida (Blacklist)
        $restrictedClasses = $this->campaign->rules['allowed_classes'] ?? [];
        if (!empty($restrictedClasses) && in_array($this->class_id, $restrictedClasses)) {
            $this->addError('class_id', 'Esta classe foi restringida pelo mestre nesta campanha.');
            return;
        }
        
        // Validar atributos conforme sistema da campanha
        $this->validateAttributes();
        
        DB::transaction(function () {
            // Calcular Modificador de Constituição
            // 1 = STR, 2 = DEX, 3 = CON (ID assumed based on standard seed, but best to retrieve by abbreviation or name if strictly safe, assuming ID 3 is CON)
            // Actually, let's verify ID 3 is CON. In standard D&D seed: 1=STR, 2=DEX, 3=CON.
            
            $conScore = $this->characterAttributes[3] ?? 10;
            // Add Racial Bonus for CON
            $race = Race::find($this->race_id);
            $raceConMod = 0;
            if ($race) {
                 $raceConMod = $race->abilities()->where('ability_id', 3)->first()->pivot->adjustment ?? 0;
            }
            $finalCon = $conScore + $raceConMod;
            $conMod = floor(($finalCon - 10) / 2);
            
            // Get Class Hit Die
            $class = CharacterClass::with('hitDie')->find($this->class_id);
            $hitDieSides = $class->hitDie->sides ?? 6; // Default d6 if missing
            
            // Calculate HP (Max Die + Con Mod, min 1)
            $hp = max(1, $hitDieSides + $conMod);
            
            // Criar personagem
            $character = Character::create([
                'player_name' => Auth::user()->name,
                'character_name' => $this->character_name,
                'race_id' => $this->race_id,
                'alignment_id' => $this->alignment_id,
                'gender' => $this->gender,
                'age' => $this->age,
                'height' => $this->height,
                'weight' => $this->weight,
                'experience_points' => 0,
                'hp_current' => $hp,
                'hp_max' => $hp,
            ]);
            
            // Adicionar classe inicial (nível 1)
            $character->classes()->attach($this->class_id, ['level' => 1]);
            
            // Adicionar atributos
            foreach ($this->characterAttributes as $abilityId => $score) {
                DB::table('character_abilities')->insert([
                    'character_id' => $character->id,
                    'ability_id' => $abilityId,
                    'base_score' => $score,
                ]);
            }
            
            // Vincular personagem ao enrollment
            $this->enrollment->update(['character_id' => $character->id]);
            
            // Redirecionar para ficha
            $this->redirect(route('characters.show', $character), navigate: true);
        });
    }
    
    protected function validateAttributes()
    {
        $system = $this->campaign->rules['attribute_system'] ?? 'point_buy';
        
        if ($system === 'point_buy') {
            $totalPoints = $this->campaign->rules['points'] ?? 32;
            $usedPoints = $this->pointsUsed;
            
            if ($usedPoints > $totalPoints) {
                throw \Illuminate\Validation\ValidationException::withMessages([
                    'attributes' => "A soma dos atributos é {$usedPoints}, mas deve ser exatamente {$totalPoints}."
                ]);
            }
        }
        
        // Validar range de valores
        foreach ($this->characterAttributes as $score) {
            if ($score < 8 || $score > 18) {
                throw \Illuminate\Validation\ValidationException::withMessages([
                    'attributes' => 'Os atributos devem estar entre 8 e 18.'
                ]);
            }
        }
    }
    
    protected function getPointCost($score)
    {
        // Tabela de custos point buy (D&D 3.5)
        // Sistema de soma simples: custo é o próprio valor do atributo
        return $score;
    }
    
    public function render()
    {
        // Filtrar raças e classes permitidas
        $restrictedRaces = $this->campaign->rules['allowed_races'] ?? [];
        $restrictedClasses = $this->campaign->rules['allowed_classes'] ?? [];
        
        // Races: Show ALL (restrictions handled in frontend via grayscale)
        $races = Race::all();
            
        // Classes: Hide Restricted (Blacklist)
        $classes = empty($restrictedClasses)
            ? CharacterClass::all()
            : CharacterClass::whereNotIn('id', $restrictedClasses)->get();
        
        return view('livewire.characters.create', [
            'races' => $races,
            'restrictedRaces' => $restrictedRaces, // Pass restriction list (blacklist)
            'classes' => $classes,
            'alignments' => Alignment::all(),
            'abilities' => DB::table('abilities')->orderBy('id')->get(),
        ]);
    }
}
