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
        Schema::dropIfExists('character_skills');
        Schema::dropIfExists('class_skills');
        Schema::dropIfExists('skills');

        Schema::create('skills', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('attribute', 3); // STR, DEX, etc.
            $table->boolean('trained_only')->default(false);
            $table->boolean('armor_check_penalty')->default(false);
            $table->timestamps();
        });

        Schema::create('class_skills', function (Blueprint $table) {
            $table->id();
            $table->foreignId('class_id')->constrained('classes')->cascadeOnDelete();
            $table->foreignId('skill_id')->constrained()->cascadeOnDelete();
            $table->timestamps();
        });

        Schema::create('character_skills', function (Blueprint $table) {
            $table->id();
            $table->foreignId('character_id')->constrained()->cascadeOnDelete();
            $table->foreignId('skill_id')->constrained()->cascadeOnDelete();
            $table->decimal('ranks', 5, 2)->default(0); // Supports half-ranks if needed
            $table->integer('misc_mod')->default(0);
            $table->timestamps();
            
            $table->unique(['character_id', 'skill_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('character_skills');
        Schema::dropIfExists('class_skills');
        Schema::dropIfExists('skills');
    }
};
