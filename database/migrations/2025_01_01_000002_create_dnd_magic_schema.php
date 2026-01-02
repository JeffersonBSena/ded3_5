<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // 4. Skills & Feats
        Schema::create('skills', function (Blueprint $table) {
            $table->id();
            $table->string('name', 50);
            $table->foreignId('key_ability_id')->nullable()->constrained('abilities');
            $table->boolean('trained_only')->default(false);
            $table->boolean('armor_check_penalty')->default(false);
            $table->text('description')->nullable();
            $table->text('synergy_text')->nullable();
            $table->foreignId('source_id')->nullable()->constrained('sources');
        });

        Schema::create('class_skills', function (Blueprint $table) {
            $table->foreignId('class_id')->constrained('classes');
            $table->foreignId('skill_id')->constrained('skills');
            $table->primary(['class_id', 'skill_id']);
        });

        Schema::create('feat_types', function (Blueprint $table) {
            $table->id();
            $table->string('name', 30);
        });

        Schema::create('feats', function (Blueprint $table) {
            $table->id();
            $table->string('name', 50);
            $table->foreignId('feat_type_id')->constrained('feat_types');
            $table->text('prerequisites_text')->nullable();
            $table->text('benefit');
            $table->text('normal')->nullable();
            $table->text('special')->nullable();
            $table->foreignId('source_id')->nullable()->constrained('sources');
            $table->integer('page_number')->nullable();
        });

        Schema::create('prerequisites', function (Blueprint $table) {
            $table->id();
            $table->enum('parent_entity_type', ['Feat', 'PrestigeClass', 'Item']);
            $table->integer('parent_entity_id');
            $table->enum('req_type', ['Ability', 'Feat', 'BAB', 'SkillRank', 'Race', 'CasterLevel', 'Special']);
            $table->string('req_value', 100);
            $table->string('req_details', 50)->nullable();
            $table->string('operator', 20)->default('>=');
            $table->index(['parent_entity_type', 'parent_entity_id']);
        });

        // 5. Magic
        Schema::create('magic_schools', function (Blueprint $table) {
            $table->id();
            $table->string('name', 30);
            $table->text('description')->nullable();
        });

        Schema::create('spell_components', function (Blueprint $table) {
            $table->id();
            $table->string('code', 5);
            $table->string('name', 50);
            $table->text('description')->nullable();
        });

        Schema::create('spells', function (Blueprint $table) {
            $table->id();
            $table->string('name', 100);
            $table->foreignId('school_id')->constrained('magic_schools');
            $table->string('subschool', 50)->nullable();
            $table->string('descriptors', 100)->nullable();
            $table->string('casting_time', 50);
            $table->string('range_text', 50);
            $table->string('area_target_effect_text', 100)->nullable();
            $table->string('duration', 50);
            $table->string('saving_throw', 50)->nullable();
            $table->boolean('spell_resistance')->default(true);
            $table->text('description');
            $table->foreignId('source_id')->nullable()->constrained('sources');
            $table->integer('page_number')->nullable();
        });

        Schema::create('class_spell_lists', function (Blueprint $table) {
            $table->foreignId('class_id')->constrained('classes');
            $table->foreignId('spell_id')->constrained('spells');
            $table->integer('spell_level');
            $table->primary(['class_id', 'spell_id']);
        });

        Schema::create('class_spell_slots', function (Blueprint $table) {
            $table->foreignId('class_id')->constrained('classes');
            $table->integer('level');
            $table->integer('spell_level');
            $table->integer('base_slots');
            $table->primary(['class_id', 'level', 'spell_level']);
        });

        Schema::create('class_spells_known_progression', function (Blueprint $table) {
            $table->foreignId('class_id')->constrained('classes');
            $table->integer('level');
            $table->integer('spell_level');
            $table->integer('spells_known');
            $table->primary(['class_id', 'level', 'spell_level']);
        });

        Schema::create('spell_component_requirements', function (Blueprint $table) {
            $table->foreignId('spell_id')->constrained('spells');
            $table->foreignId('component_id')->constrained('spell_components');
            $table->string('details', 100)->nullable();
            $table->primary(['spell_id', 'component_id']);
        });

        Schema::create('domains', function (Blueprint $table) {
            $table->id();
            $table->string('name', 50);
            $table->text('granted_power')->nullable();
            $table->foreignId('source_id')->nullable()->constrained('sources');
        });

        Schema::create('domain_spells', function (Blueprint $table) {
            $table->foreignId('domain_id')->constrained('domains');
            $table->integer('spell_level');
            $table->foreignId('spell_id')->constrained('spells');
            $table->primary(['domain_id', 'spell_level']);
        });

        Schema::create('deities', function (Blueprint $table) {
            $table->id();
            $table->string('name', 50);
            $table->foreignId('alignment_id')->constrained('alignments');
            $table->text('description')->nullable();
            $table->integer('favored_weapon_id')->nullable(); // We'll link this in the next migration or logic, FK is theoretical here
            $table->foreignId('source_id')->nullable()->constrained('sources');
        });

        Schema::create('deity_domains', function (Blueprint $table) {
            $table->foreignId('deity_id')->constrained('deities');
            $table->foreignId('domain_id')->constrained('domains');
            $table->primary(['deity_id', 'domain_id']);
        });
        
        // 1-1 Table
         Schema::create('ability_score_lookup', function (Blueprint $table) {
            $table->integer('score')->primary();
            $table->integer('modifier');
            $table->integer('bonus_spells_1st')->default(0);
            $table->integer('bonus_spells_2nd')->default(0);
            $table->integer('bonus_spells_3rd')->default(0);
            $table->integer('bonus_spells_4th')->default(0);
            $table->integer('bonus_spells_5th')->default(0);
            $table->integer('bonus_spells_6th')->default(0);
            $table->integer('bonus_spells_7th')->default(0);
            $table->integer('bonus_spells_8th')->default(0);
            $table->integer('bonus_spells_9th')->default(0);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ability_score_lookup');
        Schema::dropIfExists('deity_domains');
        Schema::dropIfExists('deities');
        Schema::dropIfExists('domain_spells');
        Schema::dropIfExists('domains');
        Schema::dropIfExists('spell_component_requirements');
        Schema::dropIfExists('class_spells_known_progression');
        Schema::dropIfExists('class_spell_slots');
        Schema::dropIfExists('class_spell_lists');
        Schema::dropIfExists('spells');
        Schema::dropIfExists('spell_components');
        Schema::dropIfExists('magic_schools');
        Schema::dropIfExists('prerequisites');
        Schema::dropIfExists('feats');
        Schema::dropIfExists('feat_types');
        Schema::dropIfExists('class_skills');
        Schema::dropIfExists('skills');
    }
};
