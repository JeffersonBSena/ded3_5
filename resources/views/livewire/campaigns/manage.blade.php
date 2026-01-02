<div class="py-12">
    <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-6">
        <div class="flex justify-between items-center">
            <flux:heading size="xl">{{ __('Manage Campaign') }}: {{ $campaign->title }}</flux:heading>
            <flux:button href="{{ route('campaigns.show', $campaign) }}" icon="arrow-left" variant="subtle" wire:navigate>
                {{ __('Back to Campaign') }}
            </flux:button>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <!-- Applications List -->
            <div class="lg:col-span-2 space-y-6">
                <div class="p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl">
                    <!-- Pending Applications -->
                    @if($pendingEnrollments->isNotEmpty())
                        <div class="space-y-4 mb-8">
                            <flux:subheading>{{ __('Pending Applications') }}</flux:subheading>
                            @foreach($pendingEnrollments as $enrollment)
                                <div class="flex items-center justify-between p-4 border rounded-lg dark:border-zinc-700 bg-yellow-50 dark:bg-yellow-900/10 border-yellow-200 dark:border-yellow-800">
                                    <div class="flex items-center gap-3">
                                        <div class="h-10 w-10 rounded-full bg-yellow-200 flex items-center justify-center font-bold text-yellow-800">
                                            {{ $enrollment->user->initials() }}
                                        </div>
                                        <div>
                                            <p class="font-semibold text-gray-900 dark:text-gray-100">{{ $enrollment->user->name }}</p>
                                            <p class="text-xs text-gray-500">{{ $enrollment->created_at->diffForHumans() }}</p>
                                        </div>
                                    </div>
                                    
                                    <div class="flex items-center gap-2">
                                        <flux:button wire:click="accept({{ $enrollment->id }})" size="sm" icon="check" variant="primary" />
                                        <flux:button wire:click="reject({{ $enrollment->id }})" size="sm" icon="x-mark" variant="danger" />
                                    </div>
                                </div>
                            @endforeach
                        </div>
                    @endif

                    <!-- Accepted Players -->
                    <div class="space-y-4">
                        <flux:subheading>{{ __('Accepted Players') }}</flux:subheading>
                        @forelse($acceptedEnrollments as $enrollment)
                            <div class="flex items-center justify-between p-4 border rounded-lg dark:border-zinc-700">
                                <div class="flex items-center gap-3">
                                    <div class="h-10 w-10 rounded-full bg-green-200 flex items-center justify-center font-bold text-green-800">
                                        {{ $enrollment->user->initials() }}
                                    </div>
                                    <div>
                                        <p class="font-semibold text-gray-900 dark:text-gray-100">{{ $enrollment->user->name }}</p>
                                        <p class="text-xs text-gray-500">
                                            @if($enrollment->character_id)
                                                <span class="text-green-600 dark:text-green-400 font-medium">Character Ready</span>
                                            @else
                                                <span class="text-gray-400 italic">Pending Character Sheet</span>
                                            @endif
                                        </p>
                                    </div>
                                </div>

                                <div>
                                    @if($enrollment->character_id)
                                        <flux:button href="{{ route('characters.show', $enrollment->character_id) }}" size="sm" icon="document-text" variant="subtle" wire:navigate>View Sheet</flux:button>
                                    @else
                                        <flux:badge color="zinc">No Sheet</flux:badge>
                                    @endif
                                </div>
                            </div>
                        @empty
                            <p class="text-gray-500 italic">{{ __('No active players yet.') }}</p>
                        @endforelse
                    </div>

                    @if($rejectedEnrollments->isNotEmpty())
                        <div class="mt-8 space-y-4 opacity-50">
                            <flux:subheading>{{ __('Rejected') }}</flux:subheading>
                            @foreach($rejectedEnrollments as $enrollment)
                                <div class="flex items-center justify-between p-3 border rounded-lg dark:border-zinc-700 bg-gray-50 dark:bg-zinc-800">
                                    <span class="text-gray-500">{{ $enrollment->user->name }}</span>
                                    <flux:badge color="red">{{ __('Rejected') }}</flux:badge>
                                </div>
                            @endforeach
                        </div>
                    @endif
                </div>
            </div>

            <!-- Campaign Settings -->
            <div class="space-y-6">
                <div class="p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl">
                    <flux:heading size="lg" class="mb-4">{{ __('Status Settings') }}</flux:heading>
                    
                    <flux:radio.group wire:model="campaign.status" label="Current Status" wire:change="updateStatus($event.target.value)">
                        <flux:radio value="open" label="Open (Accepting Players)" />
                        <flux:radio value="closed" label="Closed (Full)" />
                        <flux:radio value="active" label="Active (Playing)" />
                        <flux:radio value="finished" label="Finished" />
                    </flux:radio.group>
                </div>
                
                <div class="p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl">
                     <flux:heading size="lg" class="mb-4">{{ __('Quick Actions') }}</flux:heading>
                     <flux:button class="w-full" href="{{ route('campaigns.create') }}">Edit Rules (Coming Soon)</flux:button>
                </div>
            </div>
        </div>
    </div>
</div>
