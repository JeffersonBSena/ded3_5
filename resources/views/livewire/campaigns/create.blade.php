<div class="py-12">
    <div class="max-w-4xl mx-auto sm:px-6 lg:px-8 space-y-6">
        <flux:heading size="xl">{{ __('Create New Campaign') }}</flux:heading>

        <form wire:submit="create" class="space-y-6">
            <div class="space-y-6 p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl">
                <flux:heading size="lg">{{ __('Basic Info') }}</flux:heading>
                
                <flux:input wire:model="title" label="{{ __('Campaign Title') }}" placeholder="The Caverns of Chaos" required />
                
                <flux:textarea wire:model="description" label="{{ __('Description') }}" placeholder="A short description of the campaign setting and premise..." />
                
                <flux:input wire:model="max_players" type="number" label="{{ __('Max Players') }}" min="1" max="20" />

                <flux:input type="file" wire:model="banner" label="{{ __('Campaign Banner') }}" accept="image/*" />
            </div>

            <div class="space-y-6 p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl">
                <flux:heading size="lg">{{ __('Rules & Settings') }}</flux:heading>
                
                <flux:select wire:model.live="attribute_system" label="{{ __('Attribute Generation System') }}">
                    <option value="point_buy">{{ __('Point Buy') }}</option>
                    <option value="roll">{{ __('Dice Roll') }}</option>
                    <option value="standard_array">{{ __('Standard Array') }}</option>
                </flux:select>

                <!-- Dynamic Rule Settings -->
                @if($attribute_system === 'point_buy')
                    <flux:input wire:model="attribute_points" type="number" label="{{ __('Total Points') }}" description="Standard high fantasy is usually 32 points." />
                @elseif($attribute_system === 'roll')
                    <div class="grid grid-cols-2 gap-4">
                        <flux:input wire:model="dice_string" label="{{ __('Dice Formula') }}" placeholder="4d6" />
                        <flux:checkbox wire:model="drop_lowest" label="{{ __('Drop Lowest Die?') }}" />
                    </div>
                @endif
            </div>

            <div class="space-y-6 p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl">
                <flux:heading size="lg">{{ __('Restrições (Opcional)') }}</flux:heading>
                <flux:subheading>{{ __('Selecione itens para BLOQUEAR. Deixe vazio para permitir todos.') }}</flux:subheading>

                <div>
                    <flux:label>{{ __('Raças Restritas (Bloqueadas)') }}</flux:label>
                    <div class="grid grid-cols-2 md:grid-cols-3 gap-2 mt-2">
                        @foreach($races as $race)
                            <flux:checkbox wire:model="allowed_races" value="{{ $race->id }}" label="{{ $race->name }}" />
                        @endforeach
                    </div>
                </div>

                <div class="mt-4">
                    <flux:label>{{ __('Classes Restritas (Bloqueadas)') }}</flux:label>
                    <div class="grid grid-cols-2 md:grid-cols-3 gap-2 mt-2">
                        @foreach($classes as $class)
                            <flux:checkbox wire:model="allowed_classes" value="{{ $class->id }}" label="{{ $class->name }}" />
                        @endforeach
                    </div>
                </div>
            </div>

            <div class="flex justify-end gap-2">
                <flux:button href="{{ route('campaigns.index') }}" variant="subtle" wire:navigate>{{ __('Cancel') }}</flux:button>
                <flux:button type="submit" variant="primary">{{ __('Create Campaign') }}</flux:button>
            </div>
        </form>
    </div>
</div>
