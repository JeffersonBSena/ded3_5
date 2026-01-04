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
            <!-- Horizontal Carousel Container -->
            <div class="flex gap-6 overflow-x-auto pb-8 snap-x snap-mandatory lg:no-scrollbar">
                @foreach($campaigns as $campaign)
                    <!-- Vertical Card with Fixed Width -->
                    <div class="min-w-[20rem] max-w-[20rem] snap-center group flex flex-col bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-700 rounded-xl overflow-hidden transition duration-200 hover:shadow-lg dark:hover:shadow-black/50 hover:border-zinc-300 dark:hover:border-zinc-600">
                        <!-- Card Image & Status -->
                        <div class="relative h-64 w-full bg-zinc-100 dark:bg-zinc-800 overflow-hidden">
                        @if($campaign->image_path)
                                <img src="{{ asset($campaign->image_path) }}" 
                                     alt="{{ $campaign->title }}" 
                                     class="w-full h-full object-cover transition duration-500 group-hover:scale-105">
                            @else
                                <img src="{{ asset('banners/bannerDefault.png') }}" 
                                     alt="{{ $campaign->title }}" 
                                     class="w-full h-full object-cover transition duration-500 group-hover:scale-105">
                            @endif

                            <div class="absolute top-3 right-3">
                                <flux:badge color="{{ $campaign->status === 'open' ? 'green' : 'zinc' }}" inset="top right">
                                    {{ ucfirst($campaign->status) }}
                                </flux:badge>
                            </div>
                        </div>

                        <!-- Card Content -->
                        <div class="flex flex-col flex-1 p-5 space-y-4">
                            <!-- Header -->
                            <div>
                                <h3 class="text-xl font-bold text-gray-900 dark:text-white leading-tight">
                                    {{ $campaign->title }}
                                </h3>
                                <p class="text-sm text-zinc-500 dark:text-zinc-400 mt-1">
                                    DM: <span class="font-medium text-zinc-700 dark:text-zinc-300">{{ $campaign->user->name }}</span>
                                </p>
                            </div>

                            <!-- Description -->
                            <p class="text-gray-600 dark:text-gray-400 text-sm leading-relaxed flex-1 break-words line-clamp-4">
                                {{ $campaign->description }}
                            </p>

                            <!-- Footer Metrics & Action -->
                            <div class="pt-4 mt-auto border-t border-zinc-100 dark:border-zinc-800 flex items-center justify-between">
                                <div class="flex items-center gap-2 text-sm text-zinc-500 dark:text-zinc-400" title="{{ __('Players') }}">
                                    <flux:icon name="users" variant="mini" class="w-4 h-4 text-zinc-400" />
                                    <span class="font-medium">
                                        {{ $campaign->users()->count() }}
                                        @if($campaign->max_players)
                                            <span class="text-zinc-400">/</span> {{ $campaign->max_players }}
                                        @endif
                                    </span>
                                </div>

                                <flux:button href="{{ route('campaigns.show', $campaign) }}" size="sm" variant="primary" wire:navigate>
                                    {{ __('View Details') }}
                                </flux:button>
                            </div>
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
