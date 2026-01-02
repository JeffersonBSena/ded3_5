<?php

namespace App\Livewire\Campaigns;

use Livewire\Component;
use Livewire\Attributes\Layout;
use App\Models\Campaign;

#[Layout('components.layouts.app')]
class Index extends Component
{
    public function render()
    {
        return view('livewire.campaigns.index', [
            'campaigns' => Campaign::where('status', 'open')
                ->latest()
                ->paginate(12),
        ]);
    }
}
