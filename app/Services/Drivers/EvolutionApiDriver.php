<?php

namespace App\Services\Drivers;

use App\Services\Contracts\WhatsAppServiceInterface;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class EvolutionApiDriver implements WhatsAppServiceInterface
{
    protected string $baseUrl;
    protected string $apiKey;
    protected string $instance;

    public function __construct()
    {
        $this->baseUrl = rtrim(config('whatsapp.api_url', ''), '/');
        $this->apiKey = config('whatsapp.api_key', '');
        $this->instance = config('whatsapp.instance', '');
    }

    /**
     * Send a text message to a WhatsApp number
     */
    public function sendMessage(string $phone, string $message): bool
    {
        // Normalize phone number (remove non-digits)
        $phone = preg_replace('/\D/', '', $phone);

        try {
            $response = Http::withHeaders([
                'apikey' => $this->apiKey,
                'Content-Type' => 'application/json',
            ])->post("{$this->baseUrl}/message/sendText/{$this->instance}", [
                'number' => $phone,
                'text' => $message,
            ]);

            if ($response->successful()) {
                Log::info('WhatsApp message sent', [
                    'phone' => $this->maskPhone($phone),
                    'status' => 'success',
                ]);
                return true;
            }

            Log::error('WhatsApp message failed', [
                'phone' => $this->maskPhone($phone),
                'status' => $response->status(),
                'response' => $response->json(),
            ]);

            return false;
        } catch (\Exception $e) {
            Log::error('WhatsApp service error', [
                'phone' => $this->maskPhone($phone),
                'error' => $e->getMessage(),
            ]);

            return false;
        }
    }

    /**
     * Check if the WhatsApp service is available
     */
    public function isAvailable(): bool
    {
        if (empty($this->baseUrl) || empty($this->apiKey) || empty($this->instance)) {
            return false;
        }

        try {
            $response = Http::withHeaders([
                'apikey' => $this->apiKey,
            ])->get("{$this->baseUrl}/instance/connectionState/{$this->instance}");

            return $response->successful() && 
                   ($response->json('instance.state') ?? '') === 'open';
        } catch (\Exception $e) {
            return false;
        }
    }

    /**
     * Mask phone number for logging (privacy)
     */
    protected function maskPhone(string $phone): string
    {
        if (strlen($phone) <= 6) {
            return '***';
        }
        return substr($phone, 0, 4) . '****' . substr($phone, -2);
    }
}
