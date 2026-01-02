<?php

namespace App\Services;

use App\Models\User;
use App\Models\VerificationToken;
use App\Services\Contracts\WhatsAppServiceInterface;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\RateLimiter;

class AuthService
{
    /**
     * Maximum verification code requests per hour
     */
    protected const MAX_REQUESTS_PER_HOUR = 5;

    public function __construct(
        protected WhatsAppServiceInterface $whatsApp
    ) {}

    /**
     * Request a verification code for a phone number
     * 
     * @throws \Exception if rate limited or WhatsApp service fails
     */
    public function requestVerificationCode(string $phone): VerificationToken
    {
        // Normalize phone
        $phone = $this->normalizePhone($phone);

        // Check rate limit
        $this->checkRateLimit($phone);

        // Create new token
        $token = VerificationToken::createForPhone($phone);

        // Build message
        $message = $this->buildVerificationMessage($token->token);

        // Send via WhatsApp
        $sent = $this->whatsApp->sendMessage($phone, $message);

        if (!$sent) {
            // Delete the token if message failed
            $token->delete();
            throw new \Exception('Não foi possível enviar a mensagem. Tente novamente.');
        }

        // Increment rate limiter
        $this->incrementRateLimit($phone);

        return $token;
    }

    /**
     * Verify a code and authenticate the user
     * 
     * @throws \Exception if verification fails
     */
    public function verifyCode(string $phone, string $code): User
    {
        $phone = $this->normalizePhone($phone);

        // Find valid token
        $token = VerificationToken::findValidForPhone($phone);

        if (!$token) {
            throw new \Exception('Código expirado ou inválido. Solicite um novo código.');
        }

        // Increment attempts before checking
        $token->incrementAttempts();

        // Verify the code
        if (!$token->verify($code)) {
            $remaining = VerificationToken::MAX_ATTEMPTS - $token->attempts;
            
            if ($remaining <= 0) {
                $token->delete();
                throw new \Exception('Número máximo de tentativas excedido. Solicite um novo código.');
            }
            
            throw new \Exception("Código incorreto. Você tem {$remaining} tentativa(s) restante(s).");
        }

        // Code is valid - delete the token
        $token->delete();

        // Find or create user
        $user = User::findOrCreateByPhone($phone);

        // Mark phone as verified
        if (!$user->hasVerifiedPhone()) {
            $user->markPhoneAsVerified();
        }

        // Login the user
        Auth::login($user, remember: true);

        return $user;
    }

    /**
     * Normalize phone number to international format
     */
    public function normalizePhone(string $phone): string
    {
        // Remove all non-digits
        $phone = preg_replace('/\D/', '', $phone);

        // Add Brazil country code if not present
        if (strlen($phone) === 11 || strlen($phone) === 10) {
            $phone = '55' . $phone;
        }

        return $phone;
    }

    /**
     * Check if the phone is rate limited
     */
    protected function checkRateLimit(string $phone): void
    {
        $key = 'verification-request:' . $phone;

        if (RateLimiter::tooManyAttempts($key, self::MAX_REQUESTS_PER_HOUR)) {
            $seconds = RateLimiter::availableIn($key);
            $minutes = ceil($seconds / 60);
            
            throw new \Exception("Muitas tentativas. Aguarde {$minutes} minuto(s) para solicitar novo código.");
        }
    }

    /**
     * Increment rate limiter
     */
    protected function incrementRateLimit(string $phone): void
    {
        $key = 'verification-request:' . $phone;
        RateLimiter::hit($key, 3600); // 1 hour
    }

    /**
     * Build the verification message
     */
    protected function buildVerificationMessage(string $code): string
    {
        $appName = config('app.name', 'App');
        
        return "🔐 *{$appName}*\n\n"
             . "Seu código de verificação é:\n\n"
             . "*{$code}*\n\n"
             . "⏱️ Este código expira em 5 minutos.\n\n"
             . "Se você não solicitou este código, ignore esta mensagem.";
    }
}
