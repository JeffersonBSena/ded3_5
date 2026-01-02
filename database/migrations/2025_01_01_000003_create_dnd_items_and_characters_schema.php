<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // 6. Items
        Schema::create('item_types', function (Blueprint $table) {
            $table->id();
            $table->string('name', 30);
        });

        Schema::create('items', function (Blueprint $table) {
            $table->id();
            $table->string('name', 100);
            $table->foreignId('item_type_id')->constrained('item_types');
            $table->decimal('cost_gp', 10, 2);
            $table->decimal('weight_lb', 10, 2);
            $table->text('description')->nullable();
            $table->foreignId('source_id')->nullable()->constrained('sources');
            $table->integer('page_number')->nullable();
        });

        Schema::create('weapons', function (Blueprint $table) {
            $table->foreignId('item_id')->primary()->constrained('items');
            $table->foreignId('damage_dice_id')->constrained('dice_types');
            $table->integer('num_dice')->default(1);
            $table->string('critical_range', 20)->default('20');
            $table->foreignId('damage_type_id')->constrained('damage_types');
            $table->integer('range_increment')->nullable();
            $table->enum('category', ['Simple', 'Martial', 'Exotic']);
            $table->enum('light_one_two_handed', ['Light', 'One-Handed', 'Two-Handed']);
        });

        Schema::create('armor', function (Blueprint $table) {
            $table->foreignId('item_id')->primary()->constrained('items');
            $table->integer('armor_bonus');
            $table->integer('max_dex_bonus')->nullable();
            $table->integer('armor_check_penalty')->default(0);
            $table->integer('arcane_spell_failure')->default(0);
            $table->integer('speed_30');
            $table->integer('speed_20');
            $table->enum('category', ['Light', 'Medium', 'Heavy', 'Shield']);
        });

        Schema::create('item_properties', function (Blueprint $table) {
            $table->id();
            $table->string('name', 50);
            $table->text('description')->nullable();
        });

        // 7. Advanced Rules
        Schema::create('carrying_capacity', function (Blueprint $table) {
            $table->integer('strength_score')->primary();
            $table->integer('light_load');
            $table->integer('medium_load');
            $table->integer('heavy_load');
        });

        Schema::create('rule_blocks', function (Blueprint $table) {
            $table->id();
            $table->string('slug', 50)->unique();
            $table->string('category', 50);
            $table->string('title', 100);
            $table->text('content');
            $table->foreignId('source_id')->nullable()->constrained('sources');
        });

        Schema::create('conditions', function (Blueprint $table) {
            $table->id();
            $table->string('name', 50);
            $table->text('description');
        });

        Schema::create('combat_actions', function (Blueprint $table) {
            $table->id();
            $table->string('name', 50);
            $table->enum('action_type', ['Standard', 'Move', 'Full-Round', 'Free', 'Immediate', 'Swift']);
            $table->boolean('provokes_aoo')->default(false);
            $table->text('description')->nullable();
        });

        Schema::create('modifiers', function (Blueprint $table) {
            $table->id();
            $table->enum('source_type', ['Race', 'Feat', 'Item', 'ClassFeature', 'Condition', 'Spell']);
            $table->integer('source_id');
            $table->string('target_stat', 50);
            $table->string('modifier_type', 30)->default('Untyped');
            $table->integer('value');
            $table->string('condition_text', 100)->nullable();
        });

        // 8. Characters
        Schema::create('characters', function (Blueprint $table) {
            $table->id();
            $table->string('player_name', 50)->nullable();
            $table->string('character_name', 50);
            $table->foreignId('race_id')->constrained('races');
            $table->foreignId('alignment_id')->constrained('alignments');
            $table->string('gender', 20)->nullable();
            $table->string('height', 20)->nullable();
            $table->string('weight', 20)->nullable();
            $table->integer('age')->nullable();
            $table->integer('experience_points')->default(0);
            $table->integer('hp_current');
            $table->integer('hp_max');
            $table->timestamp('created_at')->useCurrent();
        });

        Schema::create('character_level_history', function (Blueprint $table) {
            $table->id();
            $table->foreignId('character_id')->constrained('characters');
            $table->integer('level_number');
            $table->foreignId('class_id')->constrained('classes');
            $table->integer('hp_roll');
            $table->integer('skill_points_spent')->default(0);
        });

        Schema::create('character_classes', function (Blueprint $table) {
            $table->foreignId('character_id')->constrained('characters');
            $table->foreignId('class_id')->constrained('classes');
            $table->integer('level');
            $table->primary(['character_id', 'class_id']);
        });

        Schema::create('character_abilities', function (Blueprint $table) {
            $table->foreignId('character_id')->constrained('characters');
            $table->foreignId('ability_id')->constrained('abilities');
            $table->integer('base_score');
            $table->integer('temp_score')->nullable();
            $table->primary(['character_id', 'ability_id']);
        });

        Schema::create('character_skills', function (Blueprint $table) {
            $table->foreignId('character_id')->constrained('characters');
            $table->foreignId('skill_id')->constrained('skills');
            $table->float('ranks')->default(0);
            $table->integer('misc_modifier')->default(0);
            $table->primary(['character_id', 'skill_id']);
        });

        Schema::create('character_feats', function (Blueprint $table) {
            $table->foreignId('character_id')->constrained('characters');
            $table->foreignId('feat_id')->constrained('feats');
            $table->string('note', 100)->nullable();
            $table->integer('level_acquired')->nullable();
            $table->primary(['character_id', 'feat_id']);
        });

        Schema::create('character_spells_known', function (Blueprint $table) {
            $table->foreignId('character_id')->constrained('characters');
            $table->foreignId('spell_id')->constrained('spells');
            $table->primary(['character_id', 'spell_id']);
        });

        Schema::create('character_spells_prepared', function (Blueprint $table) {
            $table->id();
            $table->foreignId('character_id')->constrained('characters');
            $table->foreignId('spell_id')->constrained('spells');
            $table->boolean('is_cast')->default(false);
        });

        Schema::create('character_inventory', function (Blueprint $table) {
            $table->id();
            $table->foreignId('character_id')->constrained('characters');
            $table->foreignId('item_id')->constrained('items');
            $table->integer('quantity')->default(1);
            $table->boolean('is_equipped')->default(false);
            $table->string('location', 50)->default('Carried');
        });

        Schema::create('character_languages', function (Blueprint $table) {
            $table->foreignId('character_id')->constrained('characters');
            $table->foreignId('language_id')->constrained('languages');
            $table->primary(['character_id', 'language_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('character_languages');
        Schema::dropIfExists('character_inventory');
        Schema::dropIfExists('character_spells_prepared');
        Schema::dropIfExists('character_spells_known');
        Schema::dropIfExists('character_feats');
        Schema::dropIfExists('character_skills');
        Schema::dropIfExists('character_abilities');
        Schema::dropIfExists('character_classes');
        Schema::dropIfExists('character_level_history');
        Schema::dropIfExists('characters');
        Schema::dropIfExists('modifiers');
        Schema::dropIfExists('combat_actions');
        Schema::dropIfExists('conditions');
        Schema::dropIfExists('rule_blocks');
        Schema::dropIfExists('carrying_capacity');
        Schema::dropIfExists('item_properties');
        Schema::dropIfExists('armor');
        Schema::dropIfExists('weapons');
        Schema::dropIfExists('items');
        Schema::dropIfExists('item_types');
    }
};
