<div class="py-12">
    <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-6">
        <!-- Header Info -->
        <div class="flex justify-between items-start bg-white dark:bg-zinc-900 p-6 rounded-xl border border-zinc-200 dark:border-zinc-700">
            <div>
                <flux:heading size="xl">{{ $character->character_name ?? 'Unnamed Character' }}</flux:heading>
                <flux:subheading>{{ $character->race->name ?? 'Unknown Race' }} • Level {{ $character->classes->first()->pivot->level ?? 1 }}</flux:subheading>
                <div class="text-sm text-gray-500 mt-1">Player: {{ $character->player_name }}</div>
            </div>
            
            <div class="text-right">
                <flux:badge color="zinc">HP: {{ $character->hp_current }} / {{ $character->hp_max }}</flux:badge>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <!-- Ability Scores -->
            <div class="space-y-6">
                <div class="p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl">
                    <flux:heading size="lg" class="mb-4">Ability Scores</flux:heading>
                    
                    <div class="space-y-4">
                        <!-- Loop for Abilities -->
                        @foreach(['Strength', 'Dexterity', 'Constitution', 'Intelligence', 'Wisdom', 'Charisma'] as $ability)
                            @php
                                $key = strtolower($ability);
                                $score = $abilities[$key] ?? 10;
                                $mod = $this->calculateModifier($score);
                                $sign = $mod >= 0 ? '+' : '';
                            @endphp
                            <div class="flex items-center justify-between">
                                <flux:label>{{ $ability }}</flux:label>
                                <div class="flex items-center gap-2">
                                    <flux:input type="number" wire:model.live="abilities.{{ $key }}" class="w-16 text-center" />
                                    <div class="w-12 h-10 flex items-center justify-center bg-zinc-100 dark:bg-zinc-800 rounded font-bold text-lg border border-zinc-200 dark:border-zinc-700">
                                        {{ $sign }}{{ $mod }}
                                    </div>
                                </div>
                            </div>
                        @endforeach
                    </div>
                </div>
            </div>

            <!-- Main Stats & Skills -->
            <div class="lg:col-span-2 space-y-6">
                <div class="p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl">
                    <flux:heading size="lg" class="mb-4">Combat Stats</flux:heading>
                    <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                        <div class="p-4 border rounded-lg text-center dark:border-zinc-700">
                            <flux:label>AC</flux:label>
                            <div class="text-2xl font-bold">10</div>
                        </div>
                        <div class="p-4 border rounded-lg text-center dark:border-zinc-700">
                            <flux:label>Initiative</flux:label>
                            <div class="text-2xl font-bold">+0</div>
                        </div>
                        <div class="p-4 border rounded-lg text-center dark:border-zinc-700">
                            <flux:label>Speed</flux:label>
                            <div class="text-2xl font-bold">30 ft.</div>
                        </div>
                         <div class="p-4 border rounded-lg text-center dark:border-zinc-700">
                            <flux:label>Proficiency</flux:label>
                            <div class="text-2xl font-bold">+2</div>
                        </div>
                    </div>
                </div>

                 <div class="p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl">
                    <flux:heading size="lg" class="mb-4">Features & Traits</flux:heading>
                    <p class="text-gray-500 italic">No features recorded yet.</p>
                </div>
            </div>
        </div>
    </div>
</div>
