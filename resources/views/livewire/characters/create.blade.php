<div class="py-12">
    {{-- Import Custom Font --}}
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Tagesschrift&display=swap');
        .font-tagesschrift {
            font-family: 'Tagesschrift', cursive;
        }
    </style>

    {{-- Increased global spacing to prevent overlap --}}
    <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-24 pb-24"> 
        
        <div class="mb-6">
            <flux:button href="{{ route('campaigns.show', $campaign) }}" variant="subtle" icon="arrow-left" class="!pl-0" wire:navigate>
                {{ __('Back to Campaign') }}
            </flux:button>
        </div>

        <form wire:submit="create">
            <div class="flex flex-col gap-24"> 
                
                {{-- SECTION 1: Race Selection (Single Image Mode + Flex Navigation) --}}
                <div class="space-y-6 pb-12 relative z-10">
                    <div class="text-center px-4">
                        <flux:heading size="xl">Escolha sua Raça</flux:heading>
                        <flux:subheading>Campanha: {{ $campaign->title }}</flux:subheading>
                    </div>

                    {{-- Carousel Container --}}
                    <div class="w-full min-h-[250px] sm:min-h-[350px] lg:min-h-[450px] flex flex-row items-center justify-center gap-4 sm:gap-8 lg:gap-16">
                        
                        {{-- Prev Button --}}
                        <button type="button" wire:click="prevRace" wire:loading.attr="disabled"
                            class="relative z-50 w-12 h-12 flex-shrink-0 flex items-center justify-center 
                                   bg-zinc-800/80 backdrop-blur rounded-full border border-amber-600/30 text-amber-400
                                   hover:bg-zinc-700 hover:border-amber-500 hover:scale-110 hover:shadow-amber-500/20 transition-all duration-300 shadow-lg cursor-pointer
                                   disabled:opacity-50 disabled:cursor-not-allowed">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                            </svg>
                        </button>

                        {{-- Characters Stage --}}
                        <div class="relative flex items-center justify-center py-4">
                            @php
                                $racesList = $races ?? collect([]); // Ensure $races is defined
                                $currentRace = $races->firstWhere('id', $race_id) ?? $races->first();
                                
                                $imgMap = [
                                    'humano' => 'humano.png',
                                    'elfo' => 'elfo.png',
                                    'anão' => 'anao.png',
                                    'gnomo' => 'gnomo.png',
                                    'meio-elfo' => 'meio-elfo.png',
                                    'meio-orc' => 'meio-orc.png',
                                    'halfling' => 'halfling.png',
                                ];
                                $img = $imgMap[strtolower($currentRace->name)] ?? 'humano.png';

                                // Debug:
                                // dump($allowedRaces, $currentRace->id);

                                // Logic: The array 'allowed_races' from DB (passed here as 'restrictedRaces') acts as a BLACKLIST.
                                // If ID is in the list -> Restricted.
                                // If List Empty -> No restrictions.
                                $restrictedIds = collect($restrictedRaces)->map(fn($id) => (string)$id)->toArray();
                                $currentId = (string)$currentRace->id;
                                
                                $isAllowed = empty($restrictedIds) || !in_array($currentId, $restrictedIds);
                            @endphp
                            
                            {{-- Active Race Render with Vertical Layout --}}
                            <div wire:key="race-{{ $currentRace->id }}"
                                 class="relative flex flex-col items-center justify-center gap-4 animate-in fade-in zoom-in-95 duration-500 ease-out">
                                
                                {{-- Character Container: MIDDLE GROUND SIZE --}}
                                <div class="w-24 h-36 sm:w-28 sm:h-42 lg:w-36 lg:h-54 relative flex items-center justify-center">
                                    <div class="w-full h-full relative">
                                        {{-- Image with Grayscale Filter if Restricted --}}
                                        <img src="/img/racas/{{ $img }}" 
                                             alt="{{ $currentRace->name }}"
                                             class="w-full h-full object-contain object-bottom drop-shadow-[0_10px_20px_rgba(0,0,0,0.5)] transition-all duration-300 {{ !$isAllowed ? 'opacity-50' : '' }}"
                                             style="display: block !important; width: 100% !important; height: 100% !important; {{ !$isAllowed ? 'filter: grayscale(100%);' : '' }}">
                                        
                                        @if(!$isAllowed)
                                            <div class="absolute inset-0 flex items-center justify-center">
                                                <div class="bg-black/70 text-white text-xs px-2 py-1 rounded border border-red-500 font-bold uppercase tracking-wider backdrop-blur-sm">
                                                    Restrito
                                                </div>
                                            </div>
                                        @endif
                                    </div>
                                </div>
                                
                                {{-- Race Name: Static Position Below --}}
                                <div class="text-center z-10 w-full">
                                    <span class="font-tagesschrift block {{ $isAllowed ? 'text-amber-500' : 'text-zinc-500' }} text-2xl sm:text-3xl lg:text-4xl tracking-wide drop-shadow-[0_2px_4px_rgba(0,0,0,1)] text-shadow-glow whitespace-nowrap">
                                        {{ $currentRace->name }}
                                        @if(!$isAllowed) <span class="text-red-500 text-lg ml-2">(✖)</span> @endif
                                    </span>
                                    
                                    <div class="mt-2 text-sm sm:text-base text-zinc-400 font-medium bg-black/60 px-3 py-1 rounded-full border border-zinc-700/50 backdrop-blur-sm inline-block">
                                        Deslocamento: <span class="text-amber-400">{{ $currentRace->speed_meters }}</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        {{-- Next Button --}}
                        <button type="button" wire:click="nextRace" wire:loading.attr="disabled"
                            class="relative z-50 w-12 h-12 flex-shrink-0 flex items-center justify-center 
                                   bg-zinc-800/80 backdrop-blur rounded-full border border-amber-600/30 text-amber-400
                                   hover:bg-zinc-700 hover:border-amber-500 hover:scale-110 hover:shadow-amber-500/20 transition-all duration-300 shadow-lg cursor-pointer
                                   disabled:opacity-50 disabled:cursor-not-allowed">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                            </svg>
                        </button>
                        
                        <input type="hidden" wire:model="race_id">
                    </div>
                    
                    @if(isset($isAllowed) && !$isAllowed)
                        <div class="text-center animate-pulse text-red-400 font-medium">
                            Esta raça não é permitida pelo mestre nesta campanha.
                        </div>
                    @endif
                </div>

                {{-- SECTION 2: Character Form --}}
                {{-- SECTION 2: Character Form --}}
                <div class="max-w-7xl mx-auto w-full space-y-6 px-4 sm:px-6 relative z-20"> 
                    
                    <flux:heading size="lg">Detalhes do Personagem</flux:heading>

                    {{-- Informações Básicas --}}
                    <div class="p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl space-y-4 shadow-sm">
                        <flux:heading size="md">Informações Básicas</flux:heading>
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                            <flux:input wire:model="character_name" label="Nome do Personagem" required />
                            
                            <flux:select wire:model="gender" label="Gênero" placeholder="Selecione">
                                <option value="M">Masculino</option>
                                <option value="F">Feminino</option>
                            </flux:select>
                        
                            <flux:select wire:model="class_id" label="Classe" placeholder="Selecione uma classe" required>
                                @foreach($classes as $class)
                                    <option value="{{ $class->id }}">{{ $class->name }}</option>
                                @endforeach
                            </flux:select>
                            
                            <flux:select wire:model="alignment_id" label="Tendência" placeholder="Selecione" required>
                                @foreach($alignments as $alignment)
                                    <option value="{{ $alignment->id }}">{{ $alignment->name }}</option>
                                @endforeach
                            </flux:select>
                        </div>
                        
                        {{-- Demographic Row --}}
                        <div class="grid grid-cols-1 sm:grid-cols-3 gap-6">
                            <flux:input wire:model="age" label="Idade" type="number" />
                            <flux:input wire:model="height" label="Altura" placeholder="1,75m" />
                            <flux:input wire:model="weight" label="Peso" placeholder="70kg" />
                        </div>
                    </div>

                    {{-- Atributos --}}
                    {{-- Updated to 3 columns per attribute --}}
                    <div class="p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl space-y-4 shadow-sm">
                        <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-2">
                            <div>
                                <flux:heading size="md">Atributos</flux:heading>
                                <flux:subheading>
                                    Sistema: {{ ucfirst(str_replace('_', ' ', $campaign->rules['attribute_system'] ?? 'Point Buy')) }}
                                </flux:subheading>
                            </div>
                            
                            @if(($campaign->rules['attribute_system'] ?? '') === 'point_buy')
                                <div class="text-left sm:text-right w-full sm:w-auto">
                                    <div class="text-sm text-zinc-500 dark:text-zinc-400">Soma Total</div>
                                    <div class="text-2xl font-bold {{ $this->pointsUsed > $this->pointsAvailable ? 'text-red-600' : 'text-green-600' }}">
                                        {{ $this->pointsUsed }} / {{ $this->pointsAvailable }}
                                    </div>
                                </div>
                            @endif
                        </div>
                        
                        {{-- Header Row --}}
                        {{-- Header Row (Hidden on Mobile, Adapted for 2-col layout on Desktop) --}}
                        <div class="hidden sm:grid grid-cols-3 lg:grid-cols-2 gap-4 mb-2 px-2 text-sm font-medium text-zinc-500">
                             {{-- Left Block Header --}}
                             <div class="grid grid-cols-3 gap-4">
                                <div>Base</div>
                                <div class="text-center">Raça</div>
                                <div class="text-center">Final</div>
                             </div>
                             {{-- Right Block Header (Visible only on LG) --}}
                             <div class="hidden lg:grid grid-cols-3 gap-4">
                                <div>Base</div>
                                <div class="text-center">Raça</div>
                                <div class="text-center">Final</div>
                             </div>
                        </div>

                        {{-- Attributes Grid --}}
                        {{-- Attributes Grid: 1 col mobile, 2 cols desktop --}}
                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-x-12 gap-y-4">
                            @foreach($abilities as $ability)
                                @php
                                    $baseScore = $characterAttributes[$ability->id] ?? 10;
                                    $raceMod = $this->raceModifiers[$ability->id] ?? 0;
                                    $finalScore = $baseScore + $raceMod;
                                    $modifier = floor(($finalScore - 10) / 2);
                                    $modSign = $modifier >= 0 ? '+' : '';
                                    $raceModSign = $raceMod > 0 ? '+' : '';
                                @endphp
                                
                                <div class="grid grid-cols-1 sm:grid-cols-3 gap-2 sm:gap-4 items-center bg-zinc-50 dark:bg-zinc-800 p-3 rounded-lg border border-zinc-200 dark:border-zinc-700">
                                    {{-- Col 1: Input (Base) --}}
                                    <div>
                                        <flux:input 
                                            wire:model.live="characterAttributes.{{ $ability->id }}" 
                                            label="{{ $ability->name }}"
                                            type="number"
                                            min="8"
                                            max="18"
                                        />
                                    </div>

                                    {{-- Col 2: Race Mod --}}
                                    <div class="flex items-center justify-between sm:justify-center">
                                        <span class="text-sm text-zinc-500 sm:hidden">Raça:</span>
                                        <div class="font-bold {{ $raceMod > 0 ? 'text-green-600' : ($raceMod < 0 ? 'text-red-600' : 'text-zinc-400') }}">
                                            {{ $raceMod != 0 ? $raceModSign.$raceMod : '-' }}
                                        </div>
                                    </div>

                                    {{-- Col 3: Final Score (Mod) --}}
                                    <div class="flex items-center justify-between sm:justify-center">
                                        <span class="text-sm text-zinc-500 sm:hidden">Total:</span>
                                        <div class="text-lg font-bold">
                                            {{ $finalScore }} 
                                            <span class="text-zinc-500 text-sm ml-1">({{ $modSign }}{{ $modifier }})</span>
                                        </div>
                                    </div>
                                </div>
                            @endforeach
                        </div>
                        
                        @error('attributes')
                            <div class="text-red-600 text-sm mt-2">{{ $message }}</div>
                        @enderror
                    </div>

                    {{-- Action Buttons --}}
                    <div class="flex flex-col-reverse sm:flex-row justify-end gap-3 pt-6">
                        <flux:button href="{{ route('campaigns.show', $campaign) }}" variant="ghost" wire:navigate class="w-full sm:w-auto">
                            Cancelar
                        </flux:button>
                        <flux:button type="submit" variant="primary" class="w-full sm:w-auto">
                            Criar Personagem
                        </flux:button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
