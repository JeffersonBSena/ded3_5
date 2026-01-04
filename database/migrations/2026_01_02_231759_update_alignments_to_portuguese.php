<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Update alignment names to Portuguese
        $translations = [
            'Lawful Good' => 'Leal e Bom',
            'Neutral Good' => 'Neutro e Bom',
            'Chaotic Good' => 'Caótico e Bom',
            'Lawful Neutral' => 'Leal e Neutro',
            'True Neutral' => 'Neutro',
            'Chaotic Neutral' => 'Caótico e Neutro',
            'Lawful Evil' => 'Leal e Mau',
            'Neutral Evil' => 'Neutro e Mau',
            'Chaotic Evil' => 'Caótico e Mau',
        ];

        foreach ($translations as $english => $portuguese) {
            DB::table('alignments')
                ->where('name', $english)
                ->update(['name' => $portuguese]);
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Revert to English
        $translations = [
            'Leal e Bom' => 'Lawful Good',
            'Neutro e Bom' => 'Neutral Good',
            'Caótico e Bom' => 'Chaotic Good',
            'Leal e Neutro' => 'Lawful Neutral',
            'Neutro' => 'True Neutral',
            'Caótico e Neutro' => 'Chaotic Neutral',
            'Leal e Mau' => 'Lawful Evil',
            'Neutro e Mau' => 'Neutral Evil',
            'Caótico e Mau' => 'Chaotic Evil',
        ];

        foreach ($translations as $portuguese => $english) {
            DB::table('alignments')
                ->where('name', $portuguese)
                ->update(['name' => $english]);
        }
    }
};
