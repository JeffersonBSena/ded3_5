<div class="py-12">
    <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-6">
        <div class="mb-6">
            <flux:button href="{{ route('campaigns.index') }}" variant="subtle" icon="arrow-left" class="!pl-0" wire:navigate>{{ __('Back to Campaigns') }}</flux:button>
        </div>

        <!-- Header -->
        <div class="flex justify-between items-start">
            <div>
                <flux:heading size="xl">{{ $campaign->title }}</flux:heading>
                <flux:subheading>DM: {{ $campaign->user->name }}</flux:subheading>
            </div>
            
            <div class="flex gap-2">
                @if($isDm)
                    <flux:button href="{{ route('campaigns.manage', $campaign) }}" icon="cog-6-tooth" wire:navigate>
                        {{ __('Manage Campaign') }}
                    </flux:button>
                @else
                    @if(!$enrollment)
                        <flux:button wire:click="join" variant="primary">{{ __('Join Campaign') }}</flux:button>
                    @elseif($enrollment->status === 'pending')
                        <flux:badge color="yellow">{{ __('Request Pending') }}</flux:badge>
                    @elseif($enrollment->status === 'accepted')
                        <flux:button variant="primary">{{ __('Play Now') }}</flux:button>
                    @else
                        <flux:badge color="red">{{ __('Request Rejected') }}</flux:badge>
                    @endif
                @endif
            </div>
        </div>

        @if($campaign->image_path)
            <div class="w-full h-64 md:h-80 overflow-hidden rounded-xl border border-zinc-200 dark:border-zinc-700 shadow-sm">
                <img src="{{ Storage::url($campaign->image_path) }}" alt="{{ $campaign->title }}" class="w-full h-full object-cover">
            </div>
        @endif

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <!-- Main Content -->
            <div class="lg:col-span-2 space-y-6">
                @if($isDm)
                    <div class="p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl space-y-4">
                        <flux:heading size="lg">{{ __('DM Actions') }}</flux:heading>
                        <flux:button href="{{ route('campaigns.manage', $campaign) }}" variant="primary" class="w-full" wire:navigate>
                            {{ __('Manage Campaign') }}
                        </flux:button>
                    </div>
                @elseif($enrollment)
                    <div class="p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl space-y-4">
                        <flux:heading size="lg">{{ __('My Status') }}</flux:heading>
                        <div class="flex items-center justify-between">
                            <span>Status:</span>
                            <flux:badge color="{{ match($enrollment->status) { 'accepted' => 'green', 'pending' => 'yellow', 'rejected' => 'red', default => 'zinc' } }}">{{ ucfirst($enrollment->status) }}</flux:badge>
                        </div>
                        
                        @if($enrollment->status === 'accepted')
                             @if($enrollment->character_id)
                                <flux:button href="{{ route('characters.show', $enrollment->character_id) }}" variant="primary" class="w-full" wire:navigate>
                                    {{ __('My Character Sheet') }}
                                </flux:button>
                             @else
                                <flux:button variant="primary" class="w-full" disabled>
                                    {{ __('Create Character (Coming Soon)') }}
                                </flux:button>
                             @endif
                        @endif
                    </div>
                @endif
                <div class="p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl">
                    <flux:heading size="lg" class="mb-4">{{ __('Description') }}</flux:heading>
                    <div class="prose dark:prose-invert">
                        {{ $campaign->description }}
                    </div>
                </div>

                <div class="p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl">
                    <flux:heading size="lg" class="mb-4">{{ __('Players') }}</flux:heading>
                    
                    @if($campaign->users->where('pivot.status', 'accepted')->isEmpty())
                        <p class="text-gray-500">{{ __('No players have joined yet.') }}</p>
                    @else
                        <div class="space-y-2">
                            @foreach($campaign->users as $user)
                                @if($user->pivot->status === 'accepted')
                                    <div class="flex items-center gap-3">
                                        <div class="h-8 w-8 rounded-full bg-gray-200 flex items-center justify-center">
                                            {{ $user->initials() }}
                                        </div>
                                        <span>{{ $user->name }}</span>
                                    </div>
                                @endif
                            @endforeach
                        </div>
                    @endif
                </div>
            </div>

            <!-- Sidebar Rules -->
            <div class="space-y-6">
                <div class="p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl">
                    <div class="space-y-4">
                        <flux:heading size="lg">{{ __('Campaign Rules') }}</flux:heading>
                        
                        <div>
                            <flux:label>{{ __('Attribute System') }}</flux:label>
                            <p class="font-medium">
                                {{ ucfirst(str_replace('_', ' ', $campaign->rules['attribute_system'] ?? 'Standard')) }}
                            </p>
                            
                            @if(($campaign->rules['attribute_system'] ?? '') === 'point_buy')
                                <p class="text-sm text-gray-500">{{ $campaign->rules['points'] ?? 32 }} Points</p>
                            @elseif(($campaign->rules['attribute_system'] ?? '') === 'roll')
                                <p class="text-sm text-gray-500">Roll: {{ $campaign->rules['dice'] ?? '4d6' }}</p>
                            @endif
                        </div>

                        <flux:separator />

                        <div>
                            <flux:label>{{ __('Status') }}</flux:label>
                            <flux:badge color="{{ $campaign->status === 'open' ? 'green' : 'zinc' }}">
                                {{ ucfirst($campaign->status) }}
                            </flux:badge>
                        </div>

                        <div>
                            <flux:label>{{ __('Max Players') }}</flux:label>
                            <p>{{ $campaign->max_players }}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
