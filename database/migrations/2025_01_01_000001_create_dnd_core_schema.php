<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // 0. Sources
        Schema::create('sources', function (Blueprint $table) {
            $table->id();
            $table->string('name', 100);
            $table->string('abbreviation', 20);
            $table->string('publisher', 50)->default('Wizards of the Coast')->nullable();
            $table->date('publication_date')->nullable();
        });

        // 1. Core Rules
        Schema::create('sizes', function (Blueprint $table) {
            $table->id();
            $table->string('name', 20);
            $table->integer('modifier');
            $table->integer('grapple_modifier');
            $table->integer('hide_modifier');
            $table->float('carrying_capacity_multiplier')->default(1.0);
            $table->foreignId('source_id')->nullable()->constrained('sources');
        });

        Schema::create('alignments', function (Blueprint $table) {
            $table->id();
            $table->string('name', 30);
            $table->string('abbreviation', 2);
            $table->text('description')->nullable();
        });

        Schema::create('abilities', function (Blueprint $table) {
            $table->id();
            $table->string('name', 20);
            $table->string('abbreviation', 3);
            $table->text('description')->nullable();
        });

        Schema::create('dice_types', function (Blueprint $table) {
            $table->id();
            $table->string('name', 4);
            $table->integer('sides');
        });

        Schema::create('damage_types', function (Blueprint $table) {
            $table->id();
            $table->string('name', 30);
            $table->text('description')->nullable();
        });

        Schema::create('languages', function (Blueprint $table) {
            $table->id();
            $table->string('name', 50);
            $table->string('alphabet', 30)->nullable();
            $table->text('description')->nullable();
        });

        Schema::create('currencies', function (Blueprint $table) {
            $table->id();
            $table->string('name', 20);
            $table->string('abbreviation', 2);
            $table->decimal('gold_value', 10, 4);
        });

        // 2. Races
        Schema::create('races', function (Blueprint $table) {
            $table->id();
            $table->string('name', 50);
            $table->foreignId('size_id')->constrained('sizes');
            $table->integer('base_speed');
            $table->integer('level_adjustment')->default(0);
            $table->integer('favored_class_id')->nullable(); // Can be null for "Any" or linked to class later
            $table->text('description')->nullable();
            $table->foreignId('source_id')->nullable()->constrained('sources');
            $table->integer('page_number')->nullable();
        });

        Schema::create('race_ability_adjustments', function (Blueprint $table) {
            $table->foreignId('race_id')->constrained('races');
            $table->foreignId('ability_id')->constrained('abilities');
            $table->integer('adjustment');
            $table->primary(['race_id', 'ability_id']);
        });

        Schema::create('race_languages', function (Blueprint $table) {
            $table->foreignId('race_id')->constrained('races');
            $table->foreignId('language_id')->constrained('languages');
            $table->boolean('is_automatic')->default(true);
            $table->primary(['race_id', 'language_id']);
        });

        Schema::create('racial_traits', function (Blueprint $table) {
            $table->id();
            $table->foreignId('race_id')->constrained('races');
            $table->string('name', 100);
            $table->text('description');
        });

        // 3. Classes
        Schema::create('classes', function (Blueprint $table) {
            $table->id();
            $table->string('name', 50);
            $table->foreignId('hit_die_id')->constrained('dice_types');
            $table->integer('skill_points_per_level');
            $table->enum('bab_progression_type', ['poor', 'medium', 'good']);
            $table->enum('fort_save_progression', ['poor', 'good']);
            $table->enum('ref_save_progression', ['poor', 'good']);
            $table->enum('will_save_progression', ['poor', 'good']);
            $table->foreignId('spellcasting_ability_id')->nullable()->constrained('abilities');
            $table->text('description')->nullable();
            $table->foreignId('source_id')->nullable()->constrained('sources');
            $table->integer('page_number')->nullable();
        });

        Schema::create('class_levels', function (Blueprint $table) {
            $table->foreignId('class_id')->constrained('classes');
            $table->integer('level');
            $table->integer('base_attack_bonus');
            $table->integer('base_save_fort');
            $table->integer('base_save_ref');
            $table->integer('base_save_will');
            $table->text('special_abilities')->nullable();
            $table->primary(['class_id', 'level']);
        });

        Schema::create('class_features', function (Blueprint $table) {
            $table->id();
            $table->foreignId('class_id')->constrained('classes');
            $table->integer('level_acquired');
            $table->string('name', 100);
            $table->text('description')->nullable();
        });

        Schema::create('class_starting_gold', function (Blueprint $table) {
            $table->foreignId('class_id')->constrained('classes');
            $table->string('dice_roll', 20);
            $table->integer('multiplier')->default(10);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('class_starting_gold');
        Schema::dropIfExists('class_features');
        Schema::dropIfExists('class_levels');
        Schema::dropIfExists('classes');
        Schema::dropIfExists('racial_traits');
        Schema::dropIfExists('race_languages');
        Schema::dropIfExists('race_ability_adjustments');
        Schema::dropIfExists('races');
        Schema::dropIfExists('currencies');
        Schema::dropIfExists('languages');
        Schema::dropIfExists('damage_types');
        Schema::dropIfExists('dice_types');
        Schema::dropIfExists('abilities');
        Schema::dropIfExists('alignments');
        Schema::dropIfExists('sizes');
        Schema::dropIfExists('sources');
    }
};
