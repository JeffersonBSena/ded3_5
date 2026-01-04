<div class="py-12">
    <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-6">
        <!-- Header Info -->
        <!-- Header Info -->
        <!-- Header Info -->
        <div class="flex flex-col sm:flex-row justify-between items-start bg-white dark:bg-zinc-900 p-6 rounded-xl border border-zinc-200 dark:border-zinc-700 space-y-4 sm:space-y-0">
            <div class="flex items-center w-full sm:w-auto">
                <div class="shrink-0" style="margin-right: 2rem;">
                     <img src="{{ $character->avatar_url }}" alt="{{ $character->character_name }}" class="w-16 h-16 min-w-[4rem] min-h-[4rem] max-w-[4rem] max-h-[4rem] rounded-full object-cover border-2 border-zinc-100 dark:border-zinc-800 shadow-sm block">
                </div>
                
                <div class="flex flex-col justify-center h-16 overflow-hidden">
                    <flux:heading size="lg" class="leading-tight truncate w-full">{{ $character->character_name ?? 'Personagem Sem Nome' }}</flux:heading>
                    <div class="text-sm font-medium leading-tight truncate w-full">{{ $character->race->name ?? 'Raça Desconhecida' }} • Nível {{ $character->classes->first()->pivot->level ?? 1 }}</div>
                    <div class="text-xs text-gray-500 leading-tight truncate w-full">Jogador: {{ $character->player_name }}</div>
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
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <!-- Ability Scores -->
            <div class="space-y-6">
                <div class="p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl">
                    <flux:heading size="lg" class="mb-4">Atributos</flux:heading>
                    
                    <div class="overflow-x-auto">
                        <table class="w-full text-left text-sm">
                            <thead>
                                <tr class="border-b dark:border-zinc-700">
                                    <th class="p-1 font-medium">Atributo</th>
                                    <th class="p-1 font-medium text-center">Valor</th>
                                    <th class="p-1 font-medium text-center">Modificador</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y dark:divide-zinc-700">
                                @foreach(['FOR', 'DES', 'CON', 'INT', 'SAB', 'CAR'] as $abbr)
                                    @php
                                        $data = $abilities[$abbr] ?? ['score' => 10, 'mod' => 0, 'name' => $abbr];
                                        $score = $data['score'];
                                        $mod = $data['mod'];
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
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Main Stats & Skills -->
            <div class="lg:col-span-2 space-y-6">
                <div class="p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl">
                    <flux:heading size="lg" class="mb-4">Combate</flux:heading>
                    <div class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-4">
                        <div class="p-4 border rounded-lg text-center dark:border-zinc-700">
                            <flux:label>CA</flux:label>
                            <div class="text-2xl font-bold">{{ $combatStats['ac'] }}</div>
                            <div class="text-xs text-gray-500">10 + DES</div>
                        </div>
                        <div class="p-4 border rounded-lg text-center dark:border-zinc-700">
                            <flux:label>Iniciativa</flux:label>
                            <div class="text-2xl font-bold">{{ $combatStats['initiative'] >= 0 ? '+' : '' }}{{ $combatStats['initiative'] }}</div>
                        </div>
                        <div class="p-4 border rounded-lg text-center dark:border-zinc-700">
                            <flux:label>BBA</flux:label>
                            <div class="text-2xl font-bold">{{ $combatStats['bab'] >= 0 ? '+' : '' }}{{ $combatStats['bab'] }}</div>
                        </div>
                        <div class="p-4 border rounded-lg text-center dark:border-zinc-700">
                            <flux:label>Corpo a corpo</flux:label>
                            <div class="text-2xl font-bold">{{ $combatStats['melee'] >= 0 ? '+' : '' }}{{ $combatStats['melee'] }}</div>
                            <div class="text-xs text-gray-500">BBA + FOR</div>
                        </div>
                         <div class="p-4 border rounded-lg text-center dark:border-zinc-700">
                            <flux:label>A distância</flux:label>
                            <div class="text-2xl font-bold">{{ $combatStats['ranged'] >= 0 ? '+' : '' }}{{ $combatStats['ranged'] }}</div>
                            <div class="text-xs text-gray-500">BBA + DES</div>
                        </div>
                         <div class="p-4 border rounded-lg text-center dark:border-zinc-700">
                            <flux:label>Oportunidade</flux:label>
                            <div class="text-2xl font-bold">{{ $combatStats['melee'] >= 0 ? '+' : '' }}{{ $combatStats['melee'] }}</div>
                        </div>
                         <div class="p-4 border rounded-lg text-center dark:border-zinc-700">
                            <flux:label>Toque</flux:label>
                            <div class="text-2xl font-bold">{{ $combatStats['touch'] }}</div>
                            <div class="text-xs text-gray-500">10 + DES</div>
                        </div>
                        <div class="p-4 border rounded-lg text-center dark:border-zinc-700">
                            <flux:label>Deslocamento</flux:label>
                            <div class="text-2xl font-bold">{{ $character->race->speed_meters ?? '9m' }}</div>
                        </div>
                    </div>
                </div>

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

                 <div class="p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl">
                    <flux:heading size="lg" class="mb-4">Características e Talentos</flux:heading>
                    <p class="text-gray-500 italic">Nenhuma característica registrada ainda.</p>
                </div>
            </div>
        </div>
    </div>
</div>
