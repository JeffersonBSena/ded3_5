<?php

namespace App\Livewire\Characters;

use Livewire\Component;
use App\Models\Character;
use Livewire\Attributes\Layout;

#[Layout('components.layouts.app')]
class Sheet extends Component
{
    public Character $character;
    public $abilities = [];
    public $combatStats = [];
    public $savingThrows = [];

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
                 'name' => $attr->name
             ];
        }

        $this->calculateCombatStats();
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
