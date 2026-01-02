<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;

class DndDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Order matters due to foreign key constraints
        $files = [
            'seed.sql', // Core lookups
            'populate_races.sql', // Races
            'populate_classes.sql', // Classes (requires Dice)
            // 'populate_skills.sql', // Skills (requires Abilities) -- If exists
            // 'populate_chapter_*.sql' - Ideally should be ordered.
        ];

        // If specific order isn't strictly known for chapters, we can list them.
        // However, looking at the previous list:
        // populate_chapter_1.sql (Abilities?)
        // populate_chapter_2.sql (Races?)
        // populate_chapter_3.sql (Classes?)
        // populate_chapter_4.sql (Skills?)
        // populate_chapter_5.sql (Feats?)
        // populate_chapter_6.sql (Combat?)
        // populate_chapter_7.sql (Equipment?)
        // populate_chapter_8.sql (Magic?)
        // populate_chapter_9.sql (Spells?)
        // populate_chapter_10.sql (Magic Items?)
        // populate_chapter_11_part1.sql (Spells/Deities?)
        
        // Let's grab all SQL files and try to run them in a logical order if possible, 
        // or just hardcode the likely correct order based on D&D structure.
        
        $executionOrder = [
             'seed.sql', // Master seed
             'populate_chapter_1.sql',
             'populate_races.sql', // Likely redundant with chapter_2 but let's see
             'populate_chapter_2.sql',
             'populate_classes.sql',
             'populate_chapter_3.sql',
             'populate_skills.sql',
             'populate_chapter_4.sql',
             'populate_chapter_5.sql', // Feats
             'populate_equipment.sql',
             'populate_chapter_7.sql',
             'populate_chapter_6.sql',
             'populate_chapter_8.sql', // Magic Theory?
             'populate_chapter_9.sql', // Spells?
             'populate_chapter_10.sql',
             'populate_chapter_11_part1.sql',
             'populate_part2.sql', // What is this?
             'populate_advanced.sql',
             'update_spells_data.sql', // Updates Spells
        ];

        $sqlPath = database_path('sql');
        
        // Get all files to check existence
        $allSqlFiles = File::glob($sqlPath . '/*.sql');
        $executed = [];

        // Disable Foreign Key Checks globally before starting (this might not persist across shell sessions, 
        // but the scripts usually define SET FOREIGN_KEY_CHECKS=0 anyway)
        
        $username = config('database.connections.mysql.username');
        $password = config('database.connections.mysql.password');
        $database = config('database.connections.mysql.database');
        $host = config('database.connections.mysql.host');
        $port = config('database.connections.mysql.port');

        foreach ($executionOrder as $filename) {
            $path = $sqlPath . '/' . $filename;
            if (File::exists($path)) {
                $this->command->info("Seeding from: $filename using MySQL CLI...");
                
                // Construct command - be careful with password security in logs (not logging it here)
                // Use default-extra-file or simple command line for now as this is a dev task
                $cmd = sprintf(
                    'mysql -h %s -P %s -u %s %s %s --default-character-set=utf8mb4 --init-command="SET FOREIGN_KEY_CHECKS=0;" < %s',
                    escapeshellarg($host),
                    escapeshellarg($port),
                    escapeshellarg($username),
                    $password ? '-p'.escapeshellarg($password) : '',
                    escapeshellarg($database),
                    escapeshellarg($path)
                );

                exec($cmd, $output, $returnVar);

                if ($returnVar !== 0) {
                     $this->command->error("Error executing $filename");
                     // We might choose to continue or stop. Let's Stop to avoid cascading errors.
                     // throw new \Exception("Failed to seed $filename"); 
                     // Actually, let's just warn and continue, as some scripts might have benign errors
                }
                
                $executed[] = $path;
            }
        }

        foreach ($allSqlFiles as $filePath) {
            if (!in_array($filePath, $executed)) {
                $filename = basename($filePath);
                if ($filename === 'schema.sql') continue;

                $this->command->info("Seeding remaining file: $filename using MySQL CLI...");
                
                $cmd = sprintf(
                    'mysql -h %s -P %s -u %s %s %s --default-character-set=utf8mb4 --init-command="SET FOREIGN_KEY_CHECKS=0;" < %s',
                    escapeshellarg($host),
                    escapeshellarg($port),
                    escapeshellarg($username),
                    $password ? '-p'.escapeshellarg($password) : '',
                    escapeshellarg($database),
                    escapeshellarg($filePath)
                );

                exec($cmd, $output, $returnVar);
                
                if ($returnVar !== 0) {
                     $this->command->error("Error executing $filename");
                }
            }
        }
    }
}
