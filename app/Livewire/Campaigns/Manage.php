<?php

namespace App\Livewire\Campaigns;

use Livewire\Component;
use Livewire\Attributes\Layout;
use App\Models\Campaign;
use App\Models\CampaignUser;
use Illuminate\Support\Facades\Auth;

#[Layout('components.layouts.app')]
class Manage extends Component
{
    public Campaign $campaign;

    public function mount(Campaign $campaign)
    {
        // Authorization check
        if ($campaign->user_id !== Auth::id()) {
            abort(403);
        }
        $this->campaign = $campaign;
    }

    public function accept($enrollmentId)
    {
        $enrollment = CampaignUser::findOrFail($enrollmentId);
        if ($enrollment->campaign_id === $this->campaign->id) {
            $enrollment->update(['status' => 'accepted']);
        }
    }

    public function reject($enrollmentId)
    {
        $enrollment = CampaignUser::findOrFail($enrollmentId);
        if ($enrollment->campaign_id === $this->campaign->id) {
            $enrollment->update(['status' => 'rejected']);
        }
    }

    public function updateStatus($status)
    {
        if (in_array($status, ['open', 'closed', 'active', 'finished'])) {
            $this->campaign->update(['status' => $status]);
        }
    }

    public function render()
    {
        return view('livewire.campaigns.manage', [
            'enrollments' => $this->campaign->enrollments()->with('user')->get(),
        ]);
    }
}
