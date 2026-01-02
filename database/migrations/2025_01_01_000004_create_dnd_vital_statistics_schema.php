<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Vital Statistics Tables from Chapter 6
        
        Schema::create('race_aging', function (Blueprint $table) {
            $table->id();
            $table->foreignId('race_id')->constrained('races');
            $table->integer('adulthood');
            $table->integer('middle_age');
            $table->integer('old_age');
            $table->integer('venerable');
            $table->string('max_age_dice', 20);
        });

        Schema::create('random_height_weight', function (Blueprint $table) {
            $table->id();
            $table->foreignId('race_id')->constrained('races');
            $table->enum('gender', ['Male', 'Female']);
            $table->integer('base_height_cm');
            $table->string('height_modifier_dice', 20);
            $table->float('height_multiplier_cm')->default(2.5);
            $table->integer('base_weight_kg');
            $table->string('weight_modifier_dice', 20);
            $table->float('weight_multiplier_kg')->default(0.5);
        });

        Schema::create('class_starting_ages', function (Blueprint $table) {
            $table->id();
            $table->foreignId('class_id')->constrained('classes');
            $table->string('dice_roll', 20);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('class_starting_ages');
        Schema::dropIfExists('random_height_weight');
        Schema::dropIfExists('race_aging');
    }
};
