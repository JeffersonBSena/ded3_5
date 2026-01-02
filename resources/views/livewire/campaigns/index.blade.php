<div class="py-12">
    <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-6">
        <div class="flex justify-between items-center">
            <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
                {{ __('Active Campaigns') }}
            </h2>
            <flux:button href="{{ route('campaigns.create') }}" icon="plus" variant="primary" wire:navigate>
                {{ __('Create Campaign') }}
            </flux:button>
        </div>

        @if($campaigns->isEmpty())
            <div class="bg-white dark:bg-zinc-800 overflow-hidden shadow-sm sm:rounded-lg p-6 text-center text-gray-500">
                {{ __('No open campaigns found. Be the first to start one!') }}
            </div>
        @else
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                @foreach($campaigns as $campaign)
                    <div class="space-y-4 p-6 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl">
                        <div class="flex justify-between items-start">
                            <div>
                                <flux:heading size="lg">{{ $campaign->title }}</flux:heading>
                                <flux:subheading>DM: {{ $campaign->user->name }}</flux:subheading>
                            </div>
                            <flux:badge color="green">{{ ucfirst($campaign->status) }}</flux:badge>
                        </div>

                        <p class="text-sm text-gray-600 dark:text-gray-400 line-clamp-3">
                            {{ $campaign->description }}
                        </p>

                        <div class="flex gap-2 text-xs text-gray-500">
                            <flux:icon name="users" class="w-4 h-4" />
                            <span>
                                {{ $campaign->users()->count() }} 
                                @if($campaign->max_players)
                                    / {{ $campaign->max_players }}
                                @endif
                                Players
                            </span>
                        </div>

                        <div class="flex justify-end">
                            <flux:button href="{{ route('campaigns.show', $campaign) }}" size="sm" wire:navigate>
                                {{ __('View Details') }}
                            </flux:button>
                        </div>
                    </div>
                @endforeach
            </div>

            <div class="mt-4">
                {{ $campaigns->links() }}
            </div>
        @endif
    </div>
</div>
