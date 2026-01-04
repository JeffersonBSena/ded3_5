<?php

namespace App\Livewire\Campaigns;

use Livewire\Component;
use Livewire\Attributes\Layout;
use App\Models\Campaign;
use Illuminate\Support\Facades\Auth;

#[Layout('components.layouts.app')]
class Show extends Component
{
    public Campaign $campaign;

    public function mount(Campaign $campaign)
    {
        $this->campaign = $campaign;
    }

    public function join(\App\Services\Contracts\WhatsAppServiceInterface $whatsappService)
    {
        if ($this->campaign->enrollments()->where('user_id', Auth::id())->exists()) {
            return;
        }

        $this->campaign->enrollments()->create([
            'user_id' => Auth::id(),
            'status' => 'pending',
        ]);

        // Notify Campaign Master
        $owner = $this->campaign->user;
        if ($owner->phone) {
            $user = Auth::user();
            $message = "O usuário {$user->name} solicitou entrar na sua campanha {$this->campaign->title}.";
            $whatsappService->sendMessage($owner->phone, $message);
        }

        $this->dispatch('campaign-applied'); // Optional: show toast
    }

    public function render()
    {
        return view('livewire.campaigns.show', [
            'isDm' => $this->campaign->user_id === Auth::id(),
            'enrollment' => $this->campaign->enrollments()->where('user_id', Auth::id())->first(),
        ]);
    }
}
