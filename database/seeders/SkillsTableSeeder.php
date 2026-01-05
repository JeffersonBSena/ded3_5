<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class SkillsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $skills = [
            ['name' => 'Abrir Fechaduras', 'attribute' => 'DES', 'trained_only' => true, 'armor_check_penalty' => false],
            ['name' => 'Acrobacia', 'attribute' => 'DES', 'trained_only' => true, 'armor_check_penalty' => true],
            ['name' => 'Adestrar Animais', 'attribute' => 'CAR', 'trained_only' => true, 'armor_check_penalty' => false],
            ['name' => 'Arte da Fuga', 'attribute' => 'DES', 'trained_only' => false, 'armor_check_penalty' => true],
            ['name' => 'Atuação', 'attribute' => 'CAR', 'trained_only' => false, 'armor_check_penalty' => false],
            ['name' => 'Avaliação', 'attribute' => 'INT', 'trained_only' => false, 'armor_check_penalty' => false],
            ['name' => 'Blefar', 'attribute' => 'CAR', 'trained_only' => false, 'armor_check_penalty' => false],
            ['name' => 'Cavalgar', 'attribute' => 'DES', 'trained_only' => false, 'armor_check_penalty' => false],
            ['name' => 'Concentração', 'attribute' => 'CON', 'trained_only' => false, 'armor_check_penalty' => false],
            ['name' => 'Conhecimento (Arcano)', 'attribute' => 'INT', 'trained_only' => true, 'armor_check_penalty' => false],
            ['name' => 'Conhecimento (Religião)', 'attribute' => 'INT', 'trained_only' => true, 'armor_check_penalty' => false],
            ['name' => 'Conhecimento (Natureza)', 'attribute' => 'INT', 'trained_only' => true, 'armor_check_penalty' => false],
            ['name' => 'Cura', 'attribute' => 'SAB', 'trained_only' => false, 'armor_check_penalty' => false],
            ['name' => 'Decifrar Escrita', 'attribute' => 'INT', 'trained_only' => true, 'armor_check_penalty' => false],
            ['name' => 'Diplomacia', 'attribute' => 'CAR', 'trained_only' => false, 'armor_check_penalty' => false],
            ['name' => 'Disfarces', 'attribute' => 'CAR', 'trained_only' => false, 'armor_check_penalty' => false],
            ['name' => 'Equilíbrio', 'attribute' => 'DES', 'trained_only' => false, 'armor_check_penalty' => true],
            ['name' => 'Escalar', 'attribute' => 'FOR', 'trained_only' => false, 'armor_check_penalty' => true],
            ['name' => 'Esconder-se', 'attribute' => 'DES', 'trained_only' => false, 'armor_check_penalty' => true],
            ['name' => 'Falsificação', 'attribute' => 'INT', 'trained_only' => false, 'armor_check_penalty' => false],
            ['name' => 'Furtividade', 'attribute' => 'DES', 'trained_only' => false, 'armor_check_penalty' => true],
            ['name' => 'Identificar Magia', 'attribute' => 'INT', 'trained_only' => true, 'armor_check_penalty' => false],
            ['name' => 'Intimidação', 'attribute' => 'CAR', 'trained_only' => false, 'armor_check_penalty' => false],
            ['name' => 'Natação', 'attribute' => 'FOR', 'trained_only' => false, 'armor_check_penalty' => true],
            ['name' => 'Observar', 'attribute' => 'SAB', 'trained_only' => false, 'armor_check_penalty' => false],
            ['name' => 'Obter Informação', 'attribute' => 'CAR', 'trained_only' => false, 'armor_check_penalty' => false],
            ['name' => 'Ofícios', 'attribute' => 'INT', 'trained_only' => false, 'armor_check_penalty' => false],
            ['name' => 'Ouvir', 'attribute' => 'SAB', 'trained_only' => false, 'armor_check_penalty' => false],
            ['name' => 'Prestidigitação', 'attribute' => 'DES', 'trained_only' => true, 'armor_check_penalty' => true],
            ['name' => 'Procurar', 'attribute' => 'INT', 'trained_only' => false, 'armor_check_penalty' => false],
            ['name' => 'Profissão', 'attribute' => 'SAB', 'trained_only' => true, 'armor_check_penalty' => false],
            ['name' => 'Saltar', 'attribute' => 'FOR', 'trained_only' => false, 'armor_check_penalty' => true],
            ['name' => 'Sentir Motivação', 'attribute' => 'SAB', 'trained_only' => false, 'armor_check_penalty' => false],
            ['name' => 'Sobrevivência', 'attribute' => 'SAB', 'trained_only' => false, 'armor_check_penalty' => false],
            ['name' => 'Usar Cordas', 'attribute' => 'DES', 'trained_only' => false, 'armor_check_penalty' => false],
            ['name' => 'Usar Instrumento Mágico', 'attribute' => 'CAR', 'trained_only' => true, 'armor_check_penalty' => false],
        ];

        foreach ($skills as $skill) {
            \App\Models\Skill::firstOrCreate(['name' => $skill['name']], $skill);
        }
    }
}
