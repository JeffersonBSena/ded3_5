<section class="w-full">
    @include('partials.settings-heading')

    <x-settings.layout :heading="__('Perfil')" :subheading="__('Atualize suas informações pessoais')">
        <form wire:submit="updateProfileInformation" class="my-6 w-full space-y-6">
            <flux:input wire:model="name" :label="__('Nome')" type="text" required autofocus autocomplete="name" />

            <flux:input wire:model="whatsapp" :label="__('WhatsApp')" type="tel" placeholder="(11) 99999-9999" autocomplete="tel" />

            <flux:input wire:model="birthdate" :label="__('Data de Nascimento')" type="text" placeholder="dd/mm/aaaa" />

            <div class="flex items-center gap-4">
                <div class="flex items-center justify-end">
                    <flux:button variant="primary" type="submit" class="w-full">{{ __('Salvar') }}</flux:button>
                </div>

                <x-action-message class="me-3" on="profile-updated">
                    {{ __('Salvo.') }}
                </x-action-message>
            </div>
        </form>

        <livewire:settings.delete-user-form />
    </x-settings.layout>

</section>
