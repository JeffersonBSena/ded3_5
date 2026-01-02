<?php

namespace App\Providers;

use App\Services\AuthService;
use App\Services\Contracts\WhatsAppServiceInterface;
use App\Services\Drivers\EvolutionApiDriver;
use Illuminate\Support\ServiceProvider;

class WhatsAppServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     */
    public function register(): void
    {
        // Bind the WhatsApp interface to the configured driver
        $this->app->singleton(WhatsAppServiceInterface::class, function ($app) {
            $driver = config('whatsapp.driver', 'evolution');

            return match ($driver) {
                'evolution' => new EvolutionApiDriver(),
                default => new EvolutionApiDriver(),
            };
        });

        // Register AuthService
        $this->app->singleton(AuthService::class, function ($app) {
            return new AuthService(
                $app->make(WhatsAppServiceInterface::class)
            );
        });
    }

    /**
     * Bootstrap services.
     */
    public function boot(): void
    {
        //
    }
}
