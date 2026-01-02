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

    public function mount(Character $character)
    {
        $this->character = $character;
        
        // Initialize with defaults or fetch from DB
        // For now, defaulting to 10 if not present
        $defaults = ['strength' => 10, 'dexterity' => 10, 'constitution' => 10, 'intelligence' => 10, 'wisdom' => 10, 'charisma' => 10];
        $this->abilities = $defaults; 
        
        // In a real implementation:
        // foreach ($character->abilities as $ability) {
        //    $this->abilities[strtolower($ability->name)] = $ability->pivot->base_score;
        // }
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
