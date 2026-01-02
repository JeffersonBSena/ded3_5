<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $users = [
            ['name' => 'Jefferson Sena', 'phone' => '5592985668008'],
            ['name' => 'Israel Pinheiro', 'phone' => '5592984325710'],
            ['name' => 'Washington Alencar', 'phone' => '5592991335101'],
        ];

        foreach ($users as $userData) {
            User::firstOrCreate(
                ['phone' => $userData['phone']],
                [
                    'name' => $userData['name'],
                    'phone_verified_at' => now(),
                ]
            );
        }

        $this->command->info('Users seeded successfully!');
    }
}
