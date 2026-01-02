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
                    <flux:heading size="lg" class="mb-4">{{ __('Player Applications') }}</flux:heading>

                    <div class="space-y-4">
                        @forelse($enrollments as $enrollment)
                            <div class="flex items-center justify-between p-4 border rounded-lg dark:border-zinc-700">
                                <div class="flex items-center gap-3">
                                    <div class="h-10 w-10 rounded-full bg-gray-200 flex items-center justify-center font-bold">
                                        {{ $enrollment->user->initials() }}
                                    </div>
                                    <div>
                                        <p class="font-semibold">{{ $enrollment->user->name }}</p>
                                        <p class="text-xs text-gray-500">{{ $enrollment->created_at->diffForHumans() }}</p>
                                    </div>
                                </div>
                                
                                <div class="flex items-center gap-2">
                                    <flux:badge color="{{ match($enrollment->status) {
                                        'accepted' => 'green',
                                        'rejected' => 'red',
                                        'left' => 'zinc',
                                        default => 'yellow' 
                                    } }}">{{ ucfirst($enrollment->status) }}</flux:badge>
                                    
                                    @if($enrollment->status === 'pending')
                                        <flux:button wire:click="accept({{ $enrollment->id }})" size="sm" icon="check" />
                                        <flux:button wire:click="reject({{ $enrollment->id }})" size="sm" icon="x-mark" variant="danger" />
                                    @endif
                                </div>
                            </div>
                        @empty
                            <p class="text-gray-500">{{ __('No applications found.') }}</p>
                        @endforelse
                    </div>
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
