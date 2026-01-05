<?php

namespace App\Livewire\Characters;

use Livewire\Component;
use App\Models\Character;
use App\Models\Skill;
use Livewire\Attributes\Layout;

#[Layout('components.layouts.app')]
class Sheet extends Component
{
    public Character $character;
    public $abilities = [];
    public $combatStats = [];
    public $savingThrows = [];

    // Skills
    public $showSkillsModal = false;
    public $allSkills = [];
    public $skillIncreases = []; // [skill_id => ranks_added]
    public $availableSkillPoints = 0;
    public $canEditSkills = true;
    public $spentPoints = 0;
    public $classSkillIds = [];

    // Feats
    public $showFeatsModal = false;
    public $featCategories = []; // [type_name => [feats]]
    public $selectedFeats = []; // [feat_id => true/false or notes]
    public $featOptions = []; // [feat_id => option_value]
    public $lockedFeatIds = []; // IDs of feats that are already saved and cannot be removed
    public $availableFeatSlots = 0;
    
    public $totalSkillPoints = 0;
    
    public $weaponOptions = [
        'Adaga', 'Alabarda', 'Arco Curto', 'Arco Longo', 'Ataque Desarmado', 
        'Besta Leve', 'Besta Pesada', 'Cimitarra', 'Clava', 'Comoposto', 
        'Espada Bastarda', 'Espada Curta', 'Espada Larga', 'Espada Longa', 
        'Machado de Batalha', 'Machado de Guerra', 'Machado Grande', 
        'Maça Leve', 'Maça Pesada', 'Martelo de Guerra', 'Rapieira', 'Tridente'
    ];
    
    public $featsRequiringOptions = [
        'Acuidade com Arma', 
        'Foco em Arma', 
        'Especialização em Arma', 
        'Crítico Aprimorado',
        'Talento Marcial', 
        'Usar Arma Exótica'
    ];

    public function isClassSkill($skillId)
    {
        return in_array($skillId, $this->classSkillIds);
    }

    public function mount(Character $character)
    {
        $this->character = $character;
        
        // Load attributes
        $this->abilities = [];
        foreach ($this->character->attributes_with_modifiers as $attr) {
             // Store using abbreviation as key (FOR, DES...)
             $this->abilities[$attr->abbreviation] = [
                 'score' => $attr->final_score,
                 'mod' => $attr->modifier,
                 'name' => $attr->name,
                 'magic' => $attr->magic_mod ?? 0,
                 'misc' => $attr->misc_mod ?? 0,
                 'base' => $attr->pivot->base_score,
                 'race' => $attr->race_mod ?? 0
             ];
        }
        
        $this->calculateSkillPoints();
        $this->calculateFeatSlots(); // Initialize feats

        $this->calculateCombatStats();
    }

    public function calculateFeatSlots()
    {
        // Total slots available to the character
        $totalSlots = $this->character->feat_slots;
        
        // Slots already spent (count of feats)
        $spentSlots = $this->character->feats()->count();
        
        $this->availableFeatSlots = max(0, $totalSlots - $spentSlots);
    }

    // ... (calculateSkillPoints, etc)

    public function saveSkills()
    {
        // Calculate Total Level
        $currentLevel = $this->character->classes->sum('pivot.level') ?: 1;
        
        // Security check
        if (($this->character->skills_finalized_at_level ?? 0) >= $currentLevel) {
            // Already finalized for this level or higher
            return;
        }

        foreach ($this->skillIncreases as $skillId => $ranks) {
            $ranks = (float)$ranks;
            if ($ranks > 0) {
                $this->character->skills()->syncWithoutDetaching([
                    $skillId => ['ranks' => $ranks]
                ]);
            } else {
                $this->character->skills()->detach($skillId);
            }
        }
        
        // Lock skills for this level
        $this->character->update(['skills_finalized_at_level' => $currentLevel]);

        $this->showSkillsModal = false;
        $this->character->refresh(); 
    }

    public function openFeatsModal()
    {
        $this->calculateFeatSlots(); 
        
        // 1. Get Class Feats (Always marked)
        $classFeatIds = $this->getClassFeats();
        
        // 2. Load and Filter Feats
        $allFeats = \App\Models\Feat::with('type')->orderBy('name')->get();

        // Load Options
        $this->featOptions = [];
        $dbFeats = $this->character->feats;
        $dbFeatIds = $dbFeats->pluck('id')->toArray();
        $this->lockedFeatIds = $dbFeatIds; // Lock currently saved feats
        
        foreach ($dbFeats as $f) {
            $this->featOptions[$f->id] = $f->pivot->notes; 
        }
        
        $allSelectedIds = array_unique(array_merge($dbFeatIds, $classFeatIds));
        
        $this->selectedFeats = [];
        foreach ($allSelectedIds as $id) {
            $this->selectedFeats[$id] = true;
        }

        // Filter: Keep if meets prereq OR is already selected
        $filteredFeats = $allFeats->filter(function($feat) use ($allSelectedIds) {
            if (in_array($feat->id, $allSelectedIds)) return true;
            return $this->checkPrerequisites($feat);
        });

        // 3. Group
        $categories = $filteredFeats->groupBy(function($feat) {
            return $feat->type ? $feat->type->name : 'Outros';
        });
        
        // Sort categories: Geral first
        $geral = $categories->pull('Geral');
        if ($geral) {
            $categories = $categories->prepend($geral, 'Geral');
        }
        
        $this->featCategories = $categories->toArray();
        $this->showFeatsModal = true;
    }

    public function saveFeats()
    {
        // 1. Enforce Locks
        foreach ($this->lockedFeatIds as $id) {
            $this->selectedFeats[$id] = true; 
        }

        // 2. Validate Limit
        $classFeatIds = $this->getClassFeats();
        $usedSlots = 0;
        
        foreach ($this->selectedFeats as $featId => $isSelected) {
            if ($isSelected && !in_array($featId, $classFeatIds)) {
                $usedSlots++;
            }
        }
        
        if ($usedSlots > $this->availableFeatSlots) {
             return; 
        }

        $syncData = [];
        foreach ($this->selectedFeats as $featId => $isSelected) {
            if ($isSelected) {
                $syncData[$featId] = [
                    'notes' => $this->featOptions[$featId] ?? null
                ];
            }
        }
        
        $this->character->feats()->sync($syncData);
        $this->showFeatsModal = false;
        $this->character->refresh();
    }

    public function calculateCombatStats()
    {
        $bab = 0;
        $baseFort = 0;
        $baseRef = 0;
        $baseWill = 0;

        foreach ($this->character->classes as $class) {
            $level = $class->pivot->level;
            
            // BAB
            $babProgression = $class->bab_progression_type;
            $bab += match($babProgression) {
                'good' => $level,
                'medium' => floor($level * 0.75),
                'poor' => floor($level * 0.5),
                default => floor($level * 0.5),
            };

            // Saves
            $baseFort += $this->calculateSave($level, $class->fort_save_progression);
            $baseRef += $this->calculateSave($level, $class->ref_save_progression);
            $baseWill += $this->calculateSave($level, $class->will_save_progression);
        }

        $dexMod = $this->abilities['DES']['mod'] ?? 0;
        $strMod = $this->abilities['FOR']['mod'] ?? 0;
        $conMod = $this->abilities['CON']['mod'] ?? 0;
        $wisMod = $this->abilities['SAB']['mod'] ?? 0;

        $this->combatStats = [
            'ac' => 10 + $dexMod,
            'initiative' => $dexMod, 
            'bab' => $bab,
            'melee' => $bab + $strMod,
            'ranged' => $bab + $dexMod,
            'touch' => 10 + $dexMod,
        ];

        $this->savingThrows = [
            'fort' => [
                'name' => 'Fortitude',
                'attr' => 'CON',
                'base' => $baseFort,
                'ability_mod' => $conMod,
                'magic_mod' => 0,
                'misc_mod' => 0,
                'total' => $baseFort + $conMod
            ],
            'ref' => [
                'name' => 'Reflexos',
                'attr' => 'DES',
                'base' => $baseRef,
                'ability_mod' => $dexMod,
                'magic_mod' => 0,
                'misc_mod' => 0,
                'total' => $baseRef + $dexMod
            ],
            'will' => [
                'name' => 'Vontade',
                'attr' => 'SAB',
                'base' => $baseWill,
                'ability_mod' => $wisMod,
                'magic_mod' => 0,
                'misc_mod' => 0,
                'total' => $baseWill + $wisMod
            ],
        ];
    }

    public function updatedSkillIncreases($value, $key)
    {
        if (!$this->canEditSkills) return;
        
        // $key is the skill ID
        $skillId = $key;
        $ranks = (float)$value;

        // Validation 1: Max Ranks
        // Standard 3.5: Max ranks = Level + 3. 
        // Cross-class: Max ranks = (Level + 3) / 2.
        
        $totalLevel = 0;
        foreach ($this->character->classes as $class) {
            $totalLevel += $class->pivot->level;
        }
        if ($totalLevel == 0) $totalLevel = 1;

        $maxClassRanks = $totalLevel + 3;
        
        $isClassSkill = in_array($skillId, $this->classSkillIds);
        $rankLimit = $isClassSkill ? $maxClassRanks : ($maxClassRanks / 2);

        if ($ranks > $rankLimit) {
            $ranks = $rankLimit; // Cap immediately
            $this->skillIncreases[$key] = $ranks;
        }
        
        if ($ranks < 0) {
            $ranks = 0;
            $this->skillIncreases[$key] = 0;
        }

        // Validation 2: Budget Check
        // Calculate cost of THIS change + existing costs of OTHERS
        $currentSpent = 0;
        // Iterate current state. Note: $this->skillIncreases already has the *current* change if Livewire synced it,
        // but since we might have modified it above ($ranks=...), we should ensure we calculate correctly.
        // Actually, $this->skillIncreases IS the source of truth now.
        
        foreach ($this->skillIncreases as $sId => $r) {
            $r = (float)$r;
            $isClass = in_array($sId, $this->classSkillIds ?? []);
            $costPerRank = $isClass ? 1 : 2;
            $currentSpent += $r * $costPerRank;
        }

        // Check if over budget
        // We need total points. ensure calculated.
        if ($this->totalSkillPoints == 0) {
            // Fallback if not set (should be set by mount/open)
            $this->calculateSkillPoints(); 
        }

        if ($currentSpent > $this->totalSkillPoints) {
            // Over budget!
            // Revert or cap.
            // Calculate how much we exceeded:
            $excess = $currentSpent - $this->totalSkillPoints;
            
            // We reduce the ranks of the CURRENT skill to fit.
            // Cost of current skill is $costPerRank.
            $isClass = in_array($skillId, $this->classSkillIds ?? []);
            $cost = $isClass ? 1 : 2;
            
            // Points to recover = $excess.
            // Ranks to remove = ceil($excess / $cost);
            $ranksToRemove = ceil($excess / $cost);
            
            $newRanks = max(0, $ranks - $ranksToRemove);
            
            $this->skillIncreases[$key] = $newRanks;
            
            // Notify user? Livewire doesn't do alerts easily. The input just snaps back.
        }
        
        $this->calculateSkillPoints();
    }
    public function openSkillsModal()
    {
        $this->character->refresh(); 
        $this->allSkills = Skill::orderBy('name')->get();
        
        // Calculate Lock Status
        $currentLevel = $this->character->classes->sum('pivot.level') ?: 1;
        // If saved level < current level, can edit.
        // If saved level == current level, locked.
        $finalized = $this->character->skills_finalized_at_level;
        $this->canEditSkills = is_null($finalized) || $finalized < $currentLevel;
        
        // Identify class skills
        $this->classSkillIds = [];
        foreach ($this->character->classes as $class) {
            $this->classSkillIds = array_merge(
                $this->classSkillIds, 
                $class->skills()->pluck('skills.id')->toArray()
            );
        }
        $this->classSkillIds = array_unique($this->classSkillIds);
        
        $this->skillIncreases = [];
        foreach ($this->allSkills as $skill) {
            $charSkill = $this->character->skills->find($skill->id);
            $this->skillIncreases[$skill->id] = $charSkill ? (int)$charSkill->pivot->ranks : 0;
        }
        
        $this->calculateSkillPoints();

        $this->showSkillsModal = true;
    }

    public function calculateSkillPoints()
    {
        $intMod = $this->abilities['INT']['mod'] ?? 0;
        $totalPoints = 0;
        
        $isFirstLevel = true;
        foreach ($this->character->classes as $class) {
            $base = 4; // Default if not in DB
            // Fighter: 2, Wizard: 2, rogue: 8... need DB column 'skill_points'. 
            // Assuming 4 as placeholder or fetching relation?
            // The pivot table doesn't have skill_points. the Class model might.
            // For now keeping existing logic (base 4).
            
            $points = max(1, $base + $intMod);
            if ($isFirstLevel) {
                // First level gets x4
                $totalPoints += ($points * 4);
                // Remaining levels in this class
                if ($class->pivot->level > 1) {
                    $totalPoints += ($points * ($class->pivot->level - 1));
                }
                $isFirstLevel = false;
            } else {
                $totalPoints += ($points * $class->pivot->level);
            }
        }
        
        $this->totalSkillPoints = $totalPoints; // Store total for validation
        
        // Subtract Spent Points
        $spent = 0;
        if (!empty($this->skillIncreases)) {
            foreach ($this->skillIncreases as $skillId => $ranks) {
                $isClass = in_array($skillId, $this->classSkillIds ?? []);
                // Cost: Class=1, Cross=2 (standard 3.5)
                $cost = $isClass ? 1 : 2; 
                $spent += $ranks * $cost;
            }
        }

        $this->availableSkillPoints = max(0, $totalPoints - $spent);
    }





    private function checkPrerequisites($feat)
    {
        if (empty($feat->prerequisites_text) || $feat->prerequisites_text === 'NULL') {
            return true;
        }
        
        $text = $feat->prerequisites_text;
        $meets = true;

        // Check Attributes: For 13, Des 15, etc.
        $attrMap = [
            'For' => 'FOR', 'Des' => 'DES', 'Con' => 'CON', 
            'Int' => 'INT', 'Sab' => 'SAB', 'Car' => 'CAR'
        ];
        
        foreach ($attrMap as $name => $key) {
            if (preg_match("/$name (\d+)/", $text, $matches)) {
                $req = (int)$matches[1];
                // Use final score (with mods)
                $score = $this->abilities[$key]['score'] ?? 0;
                if ($score < $req) $meets = false;
            }
        }

        // Check BAB: BBA +1
        if (preg_match("/(?:BBA|Bônus base de ataque) \+(\d+)/i", $text, $matches)) {
            $req = (int)$matches[1];
            $bab = $this->combatStats['bab'] ?? 0;
            if ($bab < $req) $meets = false;
        }
        
        // Caster Level / Character Level check could go here
        
        // Feat Prerequisites (Check against selected)
        // This is tricky because we might need to check feat names.
        // Simple string match against loaded feats?
        // Ideally we'd parse specific feat names, but text is unstructured.
        // For now, assume True for unparsed conditions to be permissive.

        return $meets;
    }

    private function getClassFeats()
    {
        $classNames = $this->character->classes->pluck('name')->toArray();
        $featsToGrant = [];

        // Common Proficiencies
        $simpleWeapons = 'Usar Armas Simples';
        $martialWeapons = 'Usar Armas Marciais';
        $lightArmor = 'Usar Armaduras Leves';
        $mediumArmor = 'Usar Armaduras Médias';
        $heavyArmor = 'Usar Armaduras Pesadas';
        $shields = 'Usar Escudos';
        
        foreach ($classNames as $name) {
            switch ($name) {
                case 'Guerreiro':
                case 'Paladino':
                    $featsToGrant[] = $simpleWeapons;
                    $featsToGrant[] = $martialWeapons;
                    $featsToGrant[] = $lightArmor;
                    $featsToGrant[] = $mediumArmor;
                    $featsToGrant[] = $heavyArmor;
                    $featsToGrant[] = $shields;
                    break;
                case 'Bárbaro':
                case 'Ranger':
                case 'Clérigo': // Cleric limited shields/weapons? 3.5 Cleric has heavy armor? No, usually heavy.
                    // Simplified for 3.5 defaults
                    $featsToGrant[] = $simpleWeapons;
                    $featsToGrant[] = $martialWeapons;
                    $featsToGrant[] = $lightArmor;
                    $featsToGrant[] = $mediumArmor;
                    $featsToGrant[] = $shields;
                    break;
                case 'Bardo':
                case 'Ladino':
                    $featsToGrant[] = $simpleWeapons;
                    $featsToGrant[] = $lightArmor;
                    break;
                case 'Druida':
                    $featsToGrant[] = $simpleWeapons;
                    $featsToGrant[] = $lightArmor;
                    $featsToGrant[] = $mediumArmor;
                    $featsToGrant[] = $shields;
                    $featsToGrant[] = 'Senso da Natureza';
                    break;
                case 'Mago':
                case 'Feiticeiro':
                    $featsToGrant[] = $simpleWeapons;
                    break;
                case 'Monge':
                    $featsToGrant[] = 'Ataque Desarmado Aprimorado';
                    // Monge has specifics.
                    break;
            }
        }
        
        if (empty($featsToGrant)) return [];

        return \App\Models\Feat::whereIn('name', array_unique($featsToGrant))->pluck('id')->toArray();
    }

    private function calculateSave($level, $progression)
    {
        return match($progression) {
            'good' => 2 + floor($level / 2),
            'poor' => floor($level / 3),
            default => floor($level / 3),
        };
    }

    public function calculateModifier($score)
    {
        return floor(((int)$score - 10) / 2);
    }

    public function render()
    {
        return view('livewire.characters.sheet');
    }
}
