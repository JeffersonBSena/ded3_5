<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class FeatsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // 1. Create Types
        $types = [
            'Geral' => \App\Models\FeatType::firstOrCreate(['name' => 'Geral']),
            'Metamágico' => \App\Models\FeatType::firstOrCreate(['name' => 'Metamágico']),
            'Criação de Item' => \App\Models\FeatType::firstOrCreate(['name' => 'Criação de Item']),
            'Especial' => \App\Models\FeatType::firstOrCreate(['name' => 'Especial']),
        ];

        $typeMap = [
            '@TYPE_GEN' => $types['Geral']->id,
            '@TYPE_META' => $types['Metamágico']->id,
            '@TYPE_ITEM' => $types['Criação de Item']->id,
            '@TYPE_SPEC' => $types['Especial']->id,
        ];

        // 2. Parse SQL manually
        $path = database_path('sql/populate_chapter_5.sql');
        if (!file_exists($path)) {
            $this->command->error("SQL file not found: $path");
            return;
        }

        $content = file_get_contents($path);
        
        // Regex to match value groups like: ('Name', @TYPE, 'Prereq', 'Benefit', 'Normal', 'Special', 1)
        // This is tricky due to nested quotes. 
        // Simplified approach: The file structure is very cleaner.
        // It uses single quotes. Let's try to match lines or blocks.
        // Or better: Use the standard regexp for SQL values.
        
        // Pattern: \('([^']+)',\s*(@TYPE_[A-Z]+),\s*(NULL|'[^']+'),\s*(NULL|'[^']+'),\s*(NULL|'[^']+'),\s*(NULL|'[^']+'),\s*1\)
        // Note: 'Benefit' might contain comma.
        
        // Less fragile: Read the file line by line? No, it's multi-line insert.
        // Let's use a robust regex that captures content between single quotes.
        
        preg_match_all("/\('([^']+)',\s*(@TYPE_[A-Z]+),\s*(NULL|'[^']+(?:''[^']*)*'),\s*(NULL|'[^']+(?:''[^']*)*'),\s*(NULL|'[^']+(?:''[^']*)*'),\s*(NULL|'[^']+(?:''[^']*)*'),\s*1\)/s", $content, $matches, PREG_SET_ORDER);
        
        foreach ($matches as $match) {
            $name = $match[1];
            $typeVar = $match[2];
            $prereq = ($match[3] === 'NULL') ? null : trim($match[3], "'");
            $benefit = ($match[4] === 'NULL') ? null : trim($match[4], "'");
            $normal = ($match[5] === 'NULL') ? null : trim($match[5], "'");
            $special = ($match[6] === 'NULL') ? null : trim($match[6], "'");
            
            \App\Models\Feat::updateOrCreate(
                ['name' => $name],
                [
                    'feat_type_id' => $typeMap[$typeVar] ?? $types['Geral']->id,
                    'prerequisites_text' => $prereq,
                    'benefit' => $benefit,
                    'normal' => $normal,
                    'special' => $special,
                    'source_id' => 1
                ]
            );
        }

        // Manual Additions for missing Class Feats
        \App\Models\Feat::firstOrCreate(['name' => 'Senso da Natureza'], [
            'feat_type_id' => $types['Geral']->id,
            'prerequisites_text' => null,
            'benefit' => 'Você recebe +2 de bônus em todos os testes de Conhecimento (natureza) e Sobrevivência.',
            'normal' => null,
            'special' => null,
            'source_id' => 1
        ]);
    }
}
