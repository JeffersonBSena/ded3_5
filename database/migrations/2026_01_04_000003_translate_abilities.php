<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        $translations = [
            'Strength' => ['name' => 'Força', 'abbreviation' => 'FOR'],
            'Dexterity' => ['name' => 'Destreza', 'abbreviation' => 'DES'],
            'Constitution' => ['name' => 'Constituição', 'abbreviation' => 'CON'],
            'Intelligence' => ['name' => 'Inteligência', 'abbreviation' => 'INT'],
            'Wisdom' => ['name' => 'Sabedoria', 'abbreviation' => 'SAB'],
            'Charisma' => ['name' => 'Carisma', 'abbreviation' => 'CAR'],
        ];

        foreach ($translations as $english => $pt) {
            DB::table('abilities')
                ->where('name', $english)
                ->orWhere('name', $pt['name']) // In case already translated partially
                ->update([
                    'name' => $pt['name'],
                    'abbreviation' => $pt['abbreviation']
                ]);
        }
    }

    public function down(): void
    {
        // One could revert, but usually translations are permanent upgrades.
        // For strictness:
        $revert = [
            'FOR' => ['name' => 'Strength', 'abbreviation' => 'Str'],
            'DES' => ['name' => 'Dexterity', 'abbreviation' => 'Dex'],
            'CON' => ['name' => 'Constitution', 'abbreviation' => 'Con'],
            'INT' => ['name' => 'Intelligence', 'abbreviation' => 'Int'],
            'SAB' => ['name' => 'Wisdom', 'abbreviation' => 'Wis'],
            'CAR' => ['name' => 'Charisma', 'abbreviation' => 'Cha'],
        ];

        foreach ($revert as $pt => $en) {
             DB::table('abilities')
                ->where('abbreviation', $pt)
                ->update([
                    'name' => $en['name'],
                    'abbreviation' => $en['abbreviation']
                ]);
        }
    }
};
