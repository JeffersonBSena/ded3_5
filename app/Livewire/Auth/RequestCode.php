<?php

namespace App\Livewire\Auth;

use App\Services\AuthService;
use Illuminate\View\View;
use Livewire\Attributes\Layout;
use Livewire\Attributes\Validate;
use Livewire\Component;

#[Layout('components.layouts.auth')]
class RequestCode extends Component
{
    #[Validate('required|string|min:10|max:15')]
    public string $phone = '';

    public string $error = '';
    public bool $loading = false;

    public function requestCode(): void
    {
        $this->error = '';
        $this->loading = true;

        $this->validate();

        try {
            $authService = app(AuthService::class);
            $authService->requestVerificationCode($this->phone);

            // Store phone in session and redirect to verify page
            session(['auth_phone' => $this->phone]);
            
            $this->redirect(route('verify'), navigate: true);
        } catch (\Exception $e) {
            $this->error = $e->getMessage();
        } finally {
            $this->loading = false;
        }
    }

    public function render(): View
    {
        return view('livewire.auth.request-code');
    }
}
