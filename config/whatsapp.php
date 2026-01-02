<?php

return [
    /*
    |--------------------------------------------------------------------------
    | WhatsApp API Configuration
    |--------------------------------------------------------------------------
    |
    | Configure your WhatsApp API credentials here. Default driver is Evolution API.
    |
    */

    'driver' => env('WHATSAPP_DRIVER', 'evolution'),

    /*
    |--------------------------------------------------------------------------
    | Evolution API Settings
    |--------------------------------------------------------------------------
    */
    'api_url' => env('WHATSAPP_API_URL', 'http://localhost:8080'),
    
    'api_key' => env('WHATSAPP_API_KEY', ''),
    
    'instance' => env('WHATSAPP_INSTANCE', 'default'),

    /*
    |--------------------------------------------------------------------------
    | Message Templates
    |--------------------------------------------------------------------------
    */
    'templates' => [
        'verification' => env('WHATSAPP_VERIFICATION_TEMPLATE', null),
    ],
];
