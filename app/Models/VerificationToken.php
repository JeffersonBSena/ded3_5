<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class VerificationToken extends Model
{
    public $timestamps = false;

    protected $fillable = [
        'phone',
        'token',
        'attempts',
        'expires_at',
    ];

    protected function casts(): array
    {
        return [
            'expires_at' => 'datetime',
            'created_at' => 'datetime',
        ];
    }

    /**
     * Maximum allowed verification attempts
     */
    public const MAX_ATTEMPTS = 3;

    /**
     * Token expiration time in minutes
     */
    public const EXPIRATION_MINUTES = 5;

    /**
     * Check if the token is still valid (not expired and attempts remaining)
     */
    public function isValid(): bool
    {
        return !$this->isExpired() && !$this->hasExceededAttempts();
    }

    /**
     * Check if the token has expired
     */
    public function isExpired(): bool
    {
        return $this->expires_at->isPast();
    }

    /**
     * Check if maximum attempts exceeded
     */
    public function hasExceededAttempts(): bool
    {
        return $this->attempts >= self::MAX_ATTEMPTS;
    }

    /**
     * Increment the number of verification attempts
     */
    public function incrementAttempts(): void
    {
        $this->increment('attempts');
    }

    /**
     * Verify if the provided code matches
     */
    public function verify(string $code): bool
    {
        return hash_equals($this->token, $code);
    }

    /**
     * Generate a new 6-digit verification token
     */
    public static function generateToken(): string
    {
        return str_pad((string) random_int(0, 999999), 6, '0', STR_PAD_LEFT);
    }

    /**
     * Create a new verification token for a phone number
     */
    public static function createForPhone(string $phone): self
    {
        // Delete any existing tokens for this phone
        self::where('phone', $phone)->delete();

        return self::create([
            'phone' => $phone,
            'token' => self::generateToken(),
            'expires_at' => Carbon::now()->addMinutes(self::EXPIRATION_MINUTES),
        ]);
    }

    /**
     * Find a valid token for a phone number
     */
    public static function findValidForPhone(string $phone): ?self
    {
        return self::where('phone', $phone)
            ->where('expires_at', '>', Carbon::now())
            ->where('attempts', '<', self::MAX_ATTEMPTS)
            ->first();
    }
}
