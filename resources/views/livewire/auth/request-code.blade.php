
    <div class="flex flex-col gap-6">
        <x-auth-header 
            :title="__('Entrar com WhatsApp')" 
            :description="__('Digite seu número de WhatsApp para receber o código de verificação')" 
        />

        <!-- Error Message -->
        @if($error)
            <div class="p-3 text-sm text-red-600 bg-red-50 rounded-lg dark:bg-red-900/20 dark:text-red-400">
                {{ $error }}
            </div>
        @endif

        <form wire:submit="requestCode" class="flex flex-col gap-6">
            <!-- Phone Number -->
            <flux:input
                wire:model="phone"
                label="Número do WhatsApp"
                type="tel"
                required
                autofocus
                autocomplete="tel"
                placeholder="(11) 99999-9999"
                :disabled="$loading"
            />

            <p class="text-xs text-zinc-500 dark:text-zinc-400">
                Enviaremos um código de 6 dígitos para este número.
            </p>

            <div class="flex items-center justify-end">
                <flux:button 
                    variant="primary" 
                    type="submit" 
                    class="w-full"
                    :loading="$loading"
                >
                    <span wire:loading.remove wire:target="requestCode">
                        Receber código
                    </span>
                    <span wire:loading wire:target="requestCode">
                        Enviando...
                    </span>
                </flux:button>
            </div>
        </form>
    </div>

