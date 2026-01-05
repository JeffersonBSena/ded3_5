<div class="py-12">
    <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-6">
        <!-- Header Info -->
        <!-- Header Info -->
        <!-- Header Info -->
        <div class="flex flex-col sm:flex-row justify-between items-center bg-white dark:bg-zinc-900 p-6 rounded-xl border border-zinc-200 dark:border-zinc-700 space-y-4 sm:space-y-0">
            <div class="flex items-center w-full sm:w-auto">
                <div class="shrink-0" style="margin-right: 2rem;">
                     <img src="{{ $character->avatar_url }}" alt="{{ $character->character_name }}" class="w-16 h-16 min-w-[4rem] min-h-[4rem] max-w-[4rem] max-h-[4rem] rounded-full object-cover border-2 border-zinc-100 dark:border-zinc-800 shadow-sm block">
                </div>
                
                <div class="flex flex-col justify-center h-16 overflow-hidden">
                    <flux:heading size="lg" class="leading-tight truncate w-full">{{ $character->character_name ?? 'Personagem Sem Nome' }}</flux:heading>
                    <div class="text-sm font-medium leading-tight truncate w-full">{{ $character->race->name ?? 'Raça Desconhecida' }} • Nível {{ $character->classes->first()->pivot->level ?? 1 }}</div>
                    <div class="text-xs text-gray-500 leading-tight truncate w-full">Jogador: {{ $character->player_name }}</div>
                    <div class="text-xs text-gray-500 leading-tight truncate w-full mt-0.5">
                        {{ $character->age ? $character->age . ' anos' : 'Idade N/A' }} • 
                        {{ $character->height ? $character->height . 'm' : 'Altura N/A' }} • 
                        {{ $character->weight ? $character->weight . 'kg' : 'Peso N/A' }}
                    </div>
                </div>
            </div>
            
            <div class="w-full sm:w-64 text-left sm:text-right">
                @php
                    $percent = $character->hp_max > 0 ? ($character->hp_current / $character->hp_max) * 100 : 0;
                    $percent = min(100, max(0, $percent)); // Clamp between 0 and 100
                @endphp
                
                <div class="relative w-full h-6 bg-zinc-200 dark:bg-zinc-700 rounded-full overflow-hidden shadow-inner border border-zinc-300 dark:border-zinc-600">
                    <div class="absolute top-0 left-0 h-full bg-green-500 transition-all duration-500 ease-out" style="width: {{ $percent }}%"></div>
                    <div class="absolute inset-0 flex items-center justify-center text-xs font-bold text-zinc-900 dark:text-zinc-100 drop-shadow-md">
                        PV: {{ $character->hp_current }} / {{ $character->hp_max }}
                    </div>
                </div>

                <!-- Action Icons (Feats, Skills, Equip) -->
                <!-- Action Icons (Feats, Skills, Equip) pills -->
                <div class="flex flex-wrap justify-end gap-2 mt-4">
                    <!-- Feats -->
                    <div class="relative group cursor-pointer" wire:click="openFeatsModal">
                        <button class="px-3 py-1 bg-white dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-full text-xs font-bold text-zinc-600 dark:text-zinc-300 hover:border-yellow-500 hover:text-yellow-500 transition-colors shadow-sm">
                            Talentos
                        </button>
                        @if($availableFeatSlots > 0)
                            <span class="absolute -top-1 -right-1 flex h-2.5 w-2.5">
                                <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-red-400 opacity-75"></span>
                                <span class="relative inline-flex rounded-full h-2.5 w-2.5 bg-red-500"></span>
                            </span>
                        @endif
                        <!-- Tooltip -->
                        <div class="absolute right-0 top-full mt-2 w-48 p-3 bg-zinc-800 text-white text-xs rounded-lg opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none z-50 shadow-lg border border-zinc-700">
                            <strong>Talentos</strong><br>
                            {{ $character->feats->count() }} adquiridos<br>
                            @if($availableFeatSlots > 0) <span class="text-yellow-400">{{ $availableFeatSlots }} disponível(is)</span> @endif
                        </div>
                    </div>

                    <!-- Skills -->
                    <div class="relative group cursor-pointer" wire:click="openSkillsModal">
                         <button class="px-3 py-1 bg-white dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-full text-xs font-bold text-zinc-600 dark:text-zinc-300 hover:border-blue-500 hover:text-blue-500 transition-colors shadow-sm">
                            Perícias
                        </button>
                         @if($availableSkillPoints > 0)
                            <span class="absolute -top-1 -right-1 flex h-2.5 w-2.5">
                                <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-red-400 opacity-75"></span>
                                <span class="relative inline-flex rounded-full h-2.5 w-2.5 bg-red-500"></span>
                            </span>
                        @endif
                        <!-- Tooltip -->
                         <div class="absolute right-0 top-full mt-2 w-48 p-3 bg-zinc-800 text-white text-xs rounded-lg opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none z-50 shadow-lg border border-zinc-700">
                            <strong>Perícias</strong><br>
                             {{ $character->skills->count() }} treinadas<br>
                             @if($availableSkillPoints > 0) <span class="text-yellow-400">{{ $availableSkillPoints }} ponto(s) disponível(is)</span> @endif
                        </div>
                    </div>

                    <!-- Equipment -->
                    <div class="relative group cursor-pointer">
                        <button class="px-3 py-1 bg-white dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-full text-xs font-bold text-zinc-600 dark:text-zinc-300 hover:border-green-500 hover:text-green-500 transition-colors shadow-sm">
                            Equipamentos
                        </button>
                        <!-- Tooltip -->
                        <div class="absolute right-0 top-full mt-2 w-48 p-3 bg-zinc-800 text-white text-xs rounded-lg opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none z-50 shadow-lg border border-zinc-700">
                             <strong>Equipamentos</strong><br>
                             <span class="italic text-gray-400">Necessário atualização</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <!-- Left Column: Attributes & Saving Throws -->
            <div class="space-y-6">
                <!-- Attributes -->
                <div class="p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl">
                    <flux:heading size="lg" class="mb-4">Atributos</flux:heading>
                    
                    <div class="overflow-x-auto">
                        <table class="w-full text-left text-sm">
                            <thead>
                                <tr class="border-b dark:border-zinc-700">
                                    <th class="p-1 font-medium">Atributo</th>
                                    <th class="p-1 font-medium text-center">Valor</th>
                                    <th class="p-1 font-medium text-center">Mod.</th>
                                    <th class="p-1 font-medium text-center text-blue-500">Magia</th>
                                    <th class="p-1 font-medium text-center text-yellow-500">Outros</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y dark:divide-zinc-700">
                                @foreach(['FOR', 'DES', 'CON', 'INT', 'SAB', 'CAR'] as $abbr)
                                    @php
                                        $data = $abilities[$abbr] ?? ['score' => 10, 'mod' => 0, 'name' => $abbr, 'magic' => 0, 'misc' => 0];
                                        $score = $data['score'];
                                        $mod = $data['mod'];
                                        $magic = $data['magic'] ?? 0;
                                        $misc = $data['misc'] ?? 0;
                                        $sign = $mod >= 0 ? '+' : '';
                                        
                                        $nameMap = [
                                            'FOR' => 'Força', 'DES' => 'Destreza', 'CON' => 'Constituição',
                                            'INT' => 'Inteligência', 'SAB' => 'Sabedoria', 'CAR' => 'Carisma'
                                        ];
                                        $fullName = $nameMap[$abbr] ?? $abbr;
                                    @endphp
                                    <tr title="{{ $fullName }}">
                                        <td class="p-1 font-medium">
                                            <span class="font-mono text-lg font-bold">{{ $abbr }}</span>
                                        </td>
                                        <td class="p-1 text-center">
                                            <div class="inline-block px-3 py-1 text-lg font-medium border border-zinc-200 dark:border-zinc-700 rounded">
                                                {{ $score }}
                                            </div>
                                        </td>
                                        <td class="p-1 text-center">
                                            <div class="inline-flex items-center justify-center w-10 h-8 bg-zinc-100 dark:bg-zinc-800 rounded font-bold text-lg border border-zinc-200 dark:border-zinc-700">
                                                {{ $sign }}{{ $mod }}
                                            </div>
                                        </td>
                                        <td class="p-1 text-center text-blue-500 font-medium">
                                            {{ $magic != 0 ? ($magic > 0 ? '+' : '').$magic : '-' }}
                                        </td>
                                        <td class="p-1 text-center text-yellow-500 font-medium">
                                            {{ $misc != 0 ? ($misc > 0 ? '+' : '').$misc : '-' }}
                                        </td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Saving Throws (Moved here) -->
                <div class="p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl">
                    <flux:heading size="lg" class="mb-4">Testes de Resistência</flux:heading>
                    
                    <div class="overflow-x-auto">
                        <table class="w-full text-left text-sm">
                            <thead>
                                <tr class="border-b dark:border-zinc-700">
                                    <th class="p-2 font-medium">Teste</th>
                                    <th class="p-2 font-medium text-center">Total</th>
                                    <th class="p-2 text-center text-gray-400">=</th>
                                    <th class="p-2 font-medium text-center">Base</th>
                                    <th class="p-2 font-medium text-center">Atributo</th>
                                    <th class="p-2 font-medium text-center">Magia</th>
                                    <th class="p-2 font-medium text-center">Outros</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y dark:divide-zinc-700">
                                @foreach($savingThrows as $key => $save)
                                    <tr>
                                        <td class="p-2 font-medium">
                                            {{ $save['name'] }} <span class="text-xs text-gray-500 font-normal">({{ $save['attr'] }})</span>
                                        </td>
                                        <td class="p-2 text-center">
                                            <div class="inline-flex items-center justify-center w-10 h-8 bg-zinc-100 dark:bg-zinc-800 rounded font-bold border border-zinc-200 dark:border-zinc-700">
                                                {{ $save['total'] >= 0 ? '+' : '' }}{{ $save['total'] }}
                                            </div>
                                        </td>
                                        <td class="p-2 text-center text-gray-400">=</td>
                                        <td class="p-2 text-center">{{ $save['base'] >= 0 ? '+' : '' }}{{ $save['base'] }}</td>
                                        <td class="p-2 text-center">{{ $save['ability_mod'] >= 0 ? '+' : '' }}{{ $save['ability_mod'] }}</td>
                                        <td class="p-2 text-center">{{ $save['magic_mod'] >= 0 ? '+' : '' }}{{ $save['magic_mod'] }}</td>
                                        <td class="p-2 text-center">{{ $save['misc_mod'] >= 0 ? '+' : '' }}{{ $save['misc_mod'] }}</td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Acquired Feats -->
                @if($character->feats->count() > 0)
                <div class="p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl">
                    <flux:heading size="lg" class="mb-4">Talentos Adquiridos</flux:heading>
                    <div class="overflow-x-auto">
                        <table class="w-full text-left text-sm">
                            <thead>
                                <tr class="border-b dark:border-zinc-700">
                                    <th class="p-2 font-medium w-1/3">Talento</th>
                                    <th class="p-2 font-medium">Benefício</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y dark:divide-zinc-700">
                                @foreach($character->feats as $feat)
                                    <tr>
                                        <td class="p-2 align-top">
                                            <div class="font-medium">{{ $feat->name }}</div>
                                            @if($feat->pivot->notes)
                                                <span class="inline-block mt-1 px-2 py-0.5 rounded text-[10px] font-bold bg-green-200 text-green-800 dark:bg-green-500/10 dark:text-green-300 border border-green-200 dark:border-green-800">
                                                    {{ $feat->pivot->notes }}
                                                </span>
                                            @endif
                                        </td>
                                        <td class="p-2 text-gray-500 text-xs align-top">
                                            {{ $feat->benefit }}
                                        </td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
                @endif
            </div>

            <!-- Right Column: Combat & Features -->
            <div class="space-y-6">
                <!-- Combat -->
                 <div class="p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl">
                    <flux:heading size="lg" class="mb-4">Combate</flux:heading>
                    <!-- Top Row: Stats (AC, Init, BBA, Speed) -->
                    <div class="grid grid-cols-2 gap-4 mb-6">
                         <!-- CA -->
                         <div class="flex flex-col items-center justify-center p-4 border rounded-lg text-center border-zinc-200 dark:border-zinc-700 bg-zinc-50 dark:bg-zinc-800">
                            <flux:label>CA</flux:label>
                            <div class="text-3xl font-bold text-zinc-900 dark:text-zinc-100 my-1">{{ $combatStats['ac'] }}</div>
                            <div class="text-xs text-gray-400">
                                Toque: {{ 10 + ($abilities['DES']['mod'] ?? 0) }} | Surpresa: {{ 10 }}
                            </div>
                        </div>
                        <!-- Initiative -->
                        <div class="flex flex-col items-center justify-center p-4 border rounded-lg text-center border-zinc-200 dark:border-zinc-700 bg-zinc-50 dark:bg-zinc-800">
                            <flux:label>Iniciativa</flux:label>
                            <div class="text-3xl font-bold text-zinc-900 dark:text-zinc-100 my-1">{{ $combatStats['initiative'] >= 0 ? '+' : '' }}{{ $combatStats['initiative'] }}</div>
                             <div class="text-xs text-gray-400">DES</div>
                        </div>
                        <!-- BBA -->
                        <div class="flex flex-col items-center justify-center p-4 border rounded-lg text-center border-zinc-200 dark:border-zinc-700 bg-zinc-50 dark:bg-zinc-800">
                           <flux:label>BBA</flux:label>
                           <div class="text-3xl font-bold text-zinc-900 dark:text-zinc-100 my-1">{{ $combatStats['bab'] >= 0 ? '+' : '' }}{{ $combatStats['bab'] }}</div>
                            <div class="text-xs text-gray-400">Base</div>
                       </div>
                         <!-- Speed -->
                         <div class="flex flex-col items-center justify-center p-4 border rounded-lg text-center border-zinc-200 dark:border-zinc-700 bg-zinc-50 dark:bg-zinc-800">
                            <flux:label>Deslocamento</flux:label>
                            <div class="text-3xl font-bold text-zinc-900 dark:text-zinc-100 my-1">{{ $character->race->speed_meters ?? '9m' }}</div>
                             <div class="text-xs text-gray-400">Base</div>
                        </div>
                    </div>

                    <!-- Attacks Table -->
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm text-left">
                            <thead>
                                <tr class="border-b dark:border-zinc-700">
                                    <th class="p-1 font-medium">Ataque</th>
                                    <th class="p-1 font-medium text-center">Total</th>
                                    <th class="p-1 font-medium text-center text-gray-500">BBA</th>
                                    <th class="p-1 font-medium text-center text-gray-500">Atributo</th>
                                    <th class="p-1 font-medium text-center text-gray-500">Tamanho</th>
                                    <th class="p-1 font-medium text-center text-gray-500">Outros</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y dark:divide-zinc-700">
                                @php
                                    $bab = $combatStats['bab'];
                                    $str = $abilities['FOR']['mod'] ?? 0;
                                    $dex = $abilities['DES']['mod'] ?? 0;
                                    $size = 0; // Future dynamic
                                    $misc = 0;
                                    
                                    $rows = [
                                        ['name' => 'Corpo a Corpo', 'total' => $bab + $str + $size + $misc, 'attr_val' => $str, 'attr_name' => 'FOR'],
                                        ['name' => 'A Distância', 'total' => $bab + $dex + $size + $misc, 'attr_val' => $dex, 'attr_name' => 'DES'],
                                        ['name' => 'Agarrar', 'total' => $bab + $str + $size + $misc, 'attr_val' => $str, 'attr_name' => 'FOR'],
                                    ];
                                @endphp
                                @foreach($rows as $row)
                                    <tr>
                                        <td class="p-1 font-medium">{{ $row['name'] }}</td>
                                        <td class="p-1 text-center">
                                            <div class="inline-block px-3 py-1 text-lg font-bold border border-zinc-200 dark:border-zinc-700 rounded">
                                                {{ $row['total'] >= 0 ? '+' : '' }}{{ $row['total'] }}
                                            </div>
                                        </td>
                                        <td class="p-1 text-center text-gray-500">{{ $bab >= 0 ? '+' : '' }}{{ $bab }}</td>
                                        <td class="p-1 text-center text-gray-500" title="{{ $row['attr_name'] }}">{{ $row['attr_val'] >= 0 ? '+' : '' }}{{ $row['attr_val'] }}</td>
                                        <td class="p-1 text-center text-gray-500">{{ $size }}</td>
                                        <td class="p-1 text-center text-gray-500">{{ $misc }}</td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Features Removed (Moved to Header) -->

                <!-- Skills Display Section (Below Attributes) -->
                @if($character->skills->count() > 0)
                <div class="mt-6 bg-white dark:bg-zinc-900 p-6 rounded-xl border border-zinc-200 dark:border-zinc-700">
                    <flux:heading size="lg" class="mb-4">Perícias Treinadas</flux:heading>
                    <div class="overflow-x-auto">
                        <table class="min-w-full w-full text-sm table-auto">
                            <thead>
                                <tr class="border-b dark:border-zinc-700 text-left">
                                    <th class="py-2 font-medium">Perícia</th>
                                    <th class="py-2 font-medium">Atributo</th>
                                    <th class="py-2 font-medium text-center">Total</th>
                                    <th class="py-2 font-medium text-center">Grad.</th>
                                    <th class="py-2 font-medium text-center">Mod.</th>
                                    <th class="py-2 font-medium text-center">Outros</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y dark:divide-zinc-700">
                                @foreach($character->skills as $skill)
                                    @php
                                        // Ensure attribute key exists in abilities array
                                        $attrKey = $skill->attribute; 
                                        
                                        $attrMod = $abilities[$attrKey]['mod'] ?? 0;
                                        $total = $skill->pivot->ranks + $attrMod + $skill->pivot->misc_mod;
                                    @endphp
                                    <tr>
                                        <td class="py-1">{{ $skill->name }}</td>
                                        <td class="py-1 text-gray-500">{{ $attrKey }}</td>
                                        <td class="py-1 font-bold text-center">{{ $total >= 0 ? '+' : '' }}{{ $total }}</td>
                                        <td class="py-1 text-center text-gray-500">{{ (int)$skill->pivot->ranks }}</td>
                                        <td class="py-1 text-center text-gray-500">{{ $attrMod }}</td>
                                        <td class="py-1 text-center text-gray-500">{{ $skill->pivot->misc_mod }}</td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
                @endif
            </div>
        </div>

        <!-- Skills Display Section (Below Attributes) -->

    </div>
    
    <!-- Skills Modal -->
    <flux:modal wire:model="showSkillsModal" class="min-w-[50rem]">
        <div class="p-6">
            <div class="flex justify-between items-center mb-6">
                <div>
                    <flux:heading size="lg">Gerenciar Perícias</flux:heading>
                    <div class="text-sm text-gray-500 mt-1">
                        Pontos Disponíveis: <span class="font-bold text-zinc-900 dark:text-zinc-100">{{ $availableSkillPoints }}</span>
                    </div>
                </div>
            </div>

            <div class="max-h-[60vh] overflow-y-auto pr-2">
                <table class="w-full text-sm">
                    <thead class="sticky top-0 bg-white dark:bg-zinc-900 z-10">
                        <tr class="border-b dark:border-zinc-700 text-left">
                            <th class="py-2 font-medium">Perícia</th>
                            <th class="py-2 font-medium">Classe?</th>
                            <th class="py-2 font-medium">Custo</th>
                            <th class="py-2 font-medium text-center">Graduação</th>
                        </tr>
                    </thead>
                            <tbody class="divide-y dark:divide-zinc-700">
                                @php $totalLevel = $character->classes->sum('pivot.level') ?: 1; @endphp
                        @foreach($allSkills as $skill)
                            @php
                                $isClass = $this->isClassSkill($skill->id);
                                $cost = $isClass ? 1 : 2;
                                $maxRanks = $isClass ? ($totalLevel + 3) : (($totalLevel + 3) / 2);
                            @endphp
                            <tr>
                                <td class="py-2">
                                    <div class="font-medium">{{ $skill->name }} <span class="text-xs text-gray-400">({{ $skill->attribute }})</span></div>
                                    @if($skill->trained_only)<div class="text-[10px] text-red-500">Treinada Apenas</div>@endif
                                </td>
                                <td class="py-2">
                                    @if($isClass)
                                        <flux:badge size="sm" color="green" inset="top bottom">Classe</flux:badge>
                                    @else
                                        <flux:badge size="sm" color="zinc" inset="top bottom">Outra</flux:badge>
                                    @endif
                                </td>
                                <td class="py-2">
                                    {{ $cost }} pt/grad
                                </td>
                                <td class="py-2 text-center">
                                    <flux:input type="number" inputmode="numeric" wire:model.live="skillIncreases.{{ $skill->id }}" min="0" max="{{ $maxRanks }}" step="1" class="w-20 text-center" disabled="{{ !$canEditSkills }}" />
                                </td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>

            <div class="mt-6 flex justify-between items-center bg-white dark:bg-zinc-900 p-4 rounded-xl border border-zinc-200 dark:border-zinc-700">
                @if($canEditSkills)
                    <div class="flex items-start gap-3">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="text-red-600 w-5 h-5 mt-0.5">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126ZM12 15.75h.007v.008H12v-.008Z" />
                        </svg>
                        <div class="text-sm text-red-600 dark:text-red-400">
                            <strong>Atenção:</strong> Ao salvar, você confirma a distribuição dos pontos. A edição das perícias só será permitida novamente ao passar de nível.
                        </div>
                    </div>
                @else
                     <div class="flex items-start gap-3">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="text-zinc-500 w-5 h-5 mt-0.5">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M16.5 10.5V6.75a4.5 4.5 0 10-9 0v3.75m-.75 11.25h10.5a2.25 2.25 0 002.25-2.25v-6.75a2.25 2.25 0 00-2.25-2.25H6.75a2.25 2.25 0 00-2.25 2.25v6.75a2.25 2.25 0 002.25 2.25z" />
                        </svg>
                        <div class="text-sm text-zinc-500">
                            <strong>Bloqueado:</strong> A distribuição de perícias já foi finalizada para este nível. Suba de nível para editar novamente.
                        </div>
                    </div>
                @endif
                
                <div class="flex gap-2">
                    <flux:button variant="ghost" wire:click="$set('showSkillsModal', false)">
                        {{ $canEditSkills ? 'Cancelar' : 'Fechar' }}
                    </flux:button>
                    
                    @if($canEditSkills)
                        <flux:button variant="primary" wire:click="saveSkills">Confirmar e Salvar</flux:button>
                    @else
                        <flux:button variant="filled" disabled>Finalizado</flux:button>
                    @endif
                </div>
            </div>
        </div>
    </flux:modal>

    <!-- Feats Modal -->
    <flux:modal wire:model="showFeatsModal" class="min-w-[50rem]">
        <div class="p-6">
            <div class="flex justify-between items-center mb-6">
                <div>
                    <flux:heading size="lg">Gerenciar Talentos</flux:heading>
                    <div class="text-sm text-gray-500 mt-1">
                        Slots Disponíveis: <span class="font-bold text-zinc-900 dark:text-zinc-100">{{ $availableFeatSlots }}</span>
                    </div>
                </div>
            </div>

            <div class="max-h-[60vh] overflow-y-auto pr-2 space-y-6">
                @foreach($featCategories as $categoryName => $feats)
                    <div>
                        <flux:heading size="base" class="mb-3 sticky top-0 bg-white dark:bg-zinc-900 z-10 py-2 border-b">{{ $categoryName }}</flux:heading>
                        <div class="grid grid-cols-1 gap-4">
                            @foreach($feats as $feat)
                                @php
                                    $isLocked = in_array($feat['id'], $lockedFeatIds);
                                @endphp
                                <label class="flex flex-col items-start p-3 rounded-lg border border-zinc-200 dark:border-zinc-700 bg-white dark:bg-zinc-900 transition-colors shadow-sm group {{ $isLocked ? 'opacity-60 cursor-not-allowed bg-zinc-50 dark:bg-zinc-800' : 'cursor-pointer hover:bg-sky-50 dark:hover:bg-sky-500/10' }}">
                                    <div class="flex items-start gap-3 w-full">
                                        <flux:checkbox wire:model="selectedFeats.{{ $feat['id'] }}" class="mt-0.5" disabled="{{ $isLocked }}" />
                                        <div class="flex-1">
                                            <div class="flex justify-between">
                                                <div class="font-medium text-sm text-zinc-900 dark:text-zinc-100 {{ $isLocked ? '' : 'group-hover:text-indigo-600 dark:group-hover:text-zinc-400' }} transition-colors">
                                                    {{ $feat['name'] }}
                                                    @if($isLocked) <span class="text-xs text-zinc-400 ml-2">(Bloqueado)</span> @endif
                                                </div>
                                                @if($feat['prerequisites_text'])
                                                    <div class="text-xs text-red-500 text-right max-w-[40%] truncate" title="{{ $feat['prerequisites_text'] }}">Prereq: {{ $feat['prerequisites_text'] }}</div>
                                                @endif
                                            </div>
                                            <div class="text-xs text-gray-500 mt-1">{{ $feat['benefit'] }}</div>
                                            @if($feat['normal'])
                                                <div class="text-[10px] text-gray-400 mt-1 italic">Normal: {{ $feat['normal'] }}</div>
                                            @endif
                                        </div>
                                    </div>
                                    
                                    @if(in_array($feat['name'], $this->featsRequiringOptions) && ($selectedFeats[$feat['id']] ?? false))
                                        <div class="mt-2 w-full" x-on:click.prevent>
                                            <select wire:model="featOptions.{{ $feat['id'] }}" 
                                                    class="w-full text-sm rounded-md border-zinc-200 dark:border-zinc-700 bg-zinc-50 dark:bg-zinc-800 text-zinc-900 dark:text-zinc-100 focus:ring-0 focus:border-indigo-500 {{ $isLocked ? 'opacity-50 cursor-not-allowed pointer-events-none' : '' }}"
                                                    {{ $isLocked ? 'disabled' : '' }}>
                                                <option value="">Selecione uma arma...</option>
                                                @foreach($this->weaponOptions as $weapon)
                                                    <option value="{{ $weapon }}">{{ $weapon }}</option>
                                                @endforeach
                                            </select>
                                        </div>
                                    @endif
                                </label>
                            @endforeach
                        </div>
                    </div>
                @endforeach
            </div>

            <div class="mt-6 flex justify-between items-center bg-white dark:bg-zinc-900 p-4 rounded-xl border border-zinc-200 dark:border-zinc-700">
                <div class="flex items-start gap-3">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="text-red-600 w-5 h-5 mt-0.5">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126ZM12 15.75h.007v.008H12v-.008Z" />
                    </svg>
                    <div class="text-sm text-red-600 dark:text-red-400">
                         <strong>Atenção:</strong> Ao salvar, você confirma a escolha dos talentos.
                    </div>
                </div>
                <div class="flex gap-2">
                    <flux:button variant="ghost" wire:click="$set('showFeatsModal', false)">Cancelar</flux:button>
                    <flux:button variant="primary" wire:click="saveFeats">Confirmar e Salvar</flux:button>
                </div>
            </div>
        </div>
    </flux:modal>
</div>
