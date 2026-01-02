<?php

namespace App\Livewire\Auth;

use App\Services\AuthService;
use Illuminate\View\View;
use Livewire\Attributes\Layout;
use Livewire\Component;

#[Layout('components.layouts.auth')]
class VerifyCode extends Component
{
    public string $phone = '';
    public string $code = '';
    public string $error = '';
    public bool $loading = false;
    public int $resendCountdown = 0;

    public function mount(): void
    {
        $this->phone = session('auth_phone', '');

        if (empty($this->phone)) {
            $this->redirect(route('login'), navigate: true);
            return;
        }

        // Start countdown for resend
        $this->resendCountdown = 60;
    }

    #[\Livewire\Attributes\On('verify-code-submitted')]
    public function verifyCode(string $code = ''): void
    {
        if (!empty($code)) {
            $this->code = $code;
        }

        $this->error = '';
        
        if (strlen($this->code) !== 6) {
            $this->error = 'Digite o código de 6 dígitos.';
            return;
        }

        $this->loading = true;

        try {
            $authService = app(AuthService::class);
            $authService->verifyCode($this->phone, $this->code);

            // Clear session phone
            session()->forget('auth_phone');
            
            // Redirect to dashboard
            $this->redirect(route('dashboard'), navigate: true);
        } catch (\Exception $e) {
            $this->error = $e->getMessage();
            $this->code = ''; // Clear code on error
        } finally {
            $this->loading = false;
        }
    }

    public function resendCode(): void
    {
        if ($this->resendCountdown > 0) {
            return;
        }

        $this->error = '';
        $this->loading = true;

        try {
            $authService = app(AuthService::class);
            $authService->requestVerificationCode($this->phone);
            
            $this->resendCountdown = 60;
            $this->code = '';
        } catch (\Exception $e) {
            $this->error = $e->getMessage();
        } finally {
            $this->loading = false;
        }
    }

    public function decrementCountdown(): void
    {
        if ($this->resendCountdown > 0) {
            $this->resendCountdown--;
        }
    }

    public function getMaskedPhone(): string
    {
        $phone = preg_replace('/\D/', '', $this->phone);
        
        if (strlen($phone) < 8) {
            return $phone;
        }

        return substr($phone, 0, 4) . ' ****-' . substr($phone, -2);
    }

    public function render(): View
    {
        return view('livewire.auth.verify-code');
    }
}
