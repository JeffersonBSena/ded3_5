<?php

namespace App\Livewire\Campaigns;

use Livewire\Component;
use Livewire\Attributes\Layout;
use App\Models\Campaign;
use App\Models\Race;
use App\Models\CharacterClass;
use Illuminate\Support\Facades\Auth;

#[Layout('components.layouts.app')]
class Create extends Component
{
    public $title = '';
    public $description = '';
    public $max_players = 4;
    
    // Rules
    public $attribute_system = 'point_buy'; // point_buy, roll, standard_array
    public $attribute_points = 32; // Used for point_buy
    public $dice_string = '4d6'; // Used for roll (e.g., 4d6 drop lowest)
    public $drop_lowest = true;
    
    public $allowed_races = [];
    public $allowed_classes = [];

    public function mount()
    {
        // Pre-select all races/classes by default? Or let empty mean "all"?
        // For now, let's just initialize.
    }

    public function create()
    {
        $this->validate([
            'title' => 'required|min:3|max:255',
            'max_players' => 'required|integer|min:1|max:20',
            'attribute_system' => 'required|in:point_buy,roll,standard_array',
        ]);

        $rules = [
            'attribute_system' => $this->attribute_system,
        ];

        if ($this->attribute_system === 'point_buy') {
            $rules['points'] = $this->attribute_points;
        } elseif ($this->attribute_system === 'roll') {
            $rules['dice'] = $this->dice_string;
            $rules['drop_lowest'] = $this->drop_lowest;
        }

        if (!empty($this->allowed_races)) {
            $rules['allowed_races'] = $this->allowed_races;
        }
        
        if (!empty($this->allowed_classes)) {
            $rules['allowed_classes'] = $this->allowed_classes;
        }

        $campaign = Campaign::create([
            'user_id' => Auth::id(),
            'title' => $this->title,
            'description' => $this->description,
            'status' => 'open',
            'max_players' => $this->max_players,
            'rules' => $rules,
        ]);

        $this->redirect(route('campaigns.show', $campaign), navigate: true);
    }

    public function render()
    {
        return view('livewire.campaigns.create', [
            'races' => Race::all(),
            'classes' => CharacterClass::all(), // Make sure to import CharacterClass
        ]);
    }
}
