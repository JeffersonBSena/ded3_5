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
        Schema::dropIfExists('character_feats');
        Schema::dropIfExists('feats');
        Schema::dropIfExists('feat_types');

        Schema::create('feat_types', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->timestamps();
        });

        Schema::create('feats', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->foreignId('feat_type_id')->constrained()->cascadeOnDelete();
            $table->text('prerequisites_text')->nullable();
            $table->text('benefit')->nullable();
            $table->text('normal')->nullable();
            $table->text('special')->nullable();
            $table->integer('source_id')->default(1);
            $table->timestamps();
        });

        Schema::create('character_feats', function (Blueprint $table) {
            $table->id();
            $table->foreignId('character_id')->constrained()->cascadeOnDelete();
            $table->foreignId('feat_id')->constrained()->cascadeOnDelete();
            $table->string('notes')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('character_feats');
        Schema::dropIfExists('feats');
        Schema::dropIfExists('feat_types');
    }
};
