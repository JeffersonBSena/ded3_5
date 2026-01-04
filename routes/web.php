<?php

use App\Livewire\Auth\RequestCode;
use App\Livewire\Auth\VerifyCode;
use App\Livewire\Settings\Appearance;
use App\Livewire\Settings\Password;
use App\Livewire\Settings\Profile;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
})->name('home');

Route::view('dashboard', 'dashboard')
    ->middleware(['auth'])
    ->name('dashboard');

// WhatsApp Authentication Routes
Route::middleware('guest')->group(function () {
    Route::get('login', RequestCode::class)->name('login');
    Route::get('verify', VerifyCode::class)->name('verify');
});

// Logout
Route::post('logout', function () {
    auth()->logout();
    request()->session()->invalidate();
    request()->session()->regenerateToken();
    return redirect('/');
})->middleware('auth')->name('logout');

// Settings Routes
Route::middleware(['auth'])->group(function () {
    Route::redirect('settings', 'settings/profile');
    Route::get('settings/profile', Profile::class)->name('profile.edit');
    Route::get('settings/password', Password::class)->name('user-password.edit');
    Route::get('settings/appearance', Appearance::class)->name('appearance.edit');

    // Campaign Routes
    Route::get('campaigns', App\Livewire\Campaigns\Index::class)->name('campaigns.index');
    Route::get('campaigns/create', App\Livewire\Campaigns\Create::class)->name('campaigns.create');
    Route::get('campaigns/{campaign}', App\Livewire\Campaigns\Show::class)->name('campaigns.show');
    Route::get('/campaigns/{campaign}/manage', \App\Livewire\Campaigns\Manage::class)->name('campaigns.manage');

    Route::get('/campaigns/{campaign}/characters/create', \App\Livewire\Characters\Create::class)->name('characters.create');
    Route::get('/characters/{character}', \App\Livewire\Characters\Sheet::class)->name('characters.show');
});
