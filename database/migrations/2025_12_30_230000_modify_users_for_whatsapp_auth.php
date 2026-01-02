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
        Schema::table('users', function (Blueprint $table) {
            // Remove email unique constraint and make nullable
            $table->string('email')->nullable()->change();
            
            // Add phone as the unique identifier
            $table->string('phone', 20)->unique()->after('name');
            $table->timestamp('phone_verified_at')->nullable()->after('phone');
            
            // Password is optional for WhatsApp auth
            $table->string('password')->nullable()->change();
        });

        // Update password_reset_tokens to use phone
        Schema::table('password_reset_tokens', function (Blueprint $table) {
            $table->string('phone', 20)->nullable()->after('email');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn(['phone', 'phone_verified_at']);
            $table->string('email')->unique()->nullable(false)->change();
            $table->string('password')->nullable(false)->change();
        });

        Schema::table('password_reset_tokens', function (Blueprint $table) {
            $table->dropColumn('phone');
        });
    }
};
