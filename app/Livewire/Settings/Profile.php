<?php

namespace App\Livewire\Settings;

use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Livewire\Component;
use Carbon\Carbon;

class Profile extends Component
{
    public ?string $name = '';
    public ?string $whatsapp = '';
    public ?string $birthdate = '';

    /**
     * Mount the component.
     */
    public function mount(): void
    {
        $user = Auth::user();
        $this->name = $user->name ?? '';
        $this->whatsapp = $user->whatsapp ?? $user->phone ?? '';
        $this->birthdate = $user->birthdate ? $user->birthdate->format('d/m/Y') : '';
    }

    /**
     * Update the profile information for the currently authenticated user.
     */
    public function updateProfileInformation(): void
    {
        $user = Auth::user();

        $validated = $this->validate([
            'name' => ['required', 'string', 'max:255'],
            'whatsapp' => ['nullable', 'string', 'max:20'],
            'birthdate' => ['nullable', 'string', 'regex:/^\d{2}\/\d{2}\/\d{4}$/'],
        ]);

        $user->name = $validated['name'];
        $user->whatsapp = $validated['whatsapp'];
        
        if (!empty($validated['birthdate'])) {
            $user->birthdate = Carbon::createFromFormat('d/m/Y', $validated['birthdate'])->format('Y-m-d');
        } else {
            $user->birthdate = null;
        }
        
        $user->save();

        $this->dispatch('profile-updated', name: $user->name);
    }
}
