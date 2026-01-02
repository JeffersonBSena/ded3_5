<?php

namespace App\Services\Contracts;

interface WhatsAppServiceInterface
{
    /**
     * Send a text message to a WhatsApp number
     *
     * @param string $phone Phone number in international format (e.g., 5511999999999)
     * @param string $message Message content
     * @return bool Success status
     */
    public function sendMessage(string $phone, string $message): bool;

    /**
     * Check if the WhatsApp service is available
     *
     * @return bool
     */
    public function isAvailable(): bool;
}
