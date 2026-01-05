<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('character_abilities', function (Blueprint $table) {
            $table->integer('magic_modifier')->default(0)->after('temp_score');
            $table->integer('misc_modifier')->default(0)->after('magic_modifier');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('character_abilities', function (Blueprint $table) {
            $table->dropColumn(['magic_modifier', 'misc_modifier']);
        });
    }
};
