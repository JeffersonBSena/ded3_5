<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ClassSkillsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $map = [
            'Bárbaro' => ['Escalar', 'Ofícios', 'Adestrar Animais', 'Intimidação', 'Saltar', 'Ouvir', 'Cavalgar', 'Sobrevivência', 'Natação'],
            'Bardo' => ['Acrobacia', 'Avaliação', 'Blefar', 'Escalar', 'Concentração', 'Ofícios', 'Decifrar Escrita', 'Diplomacia', 'Disfarces', 'Arte da Fuga', 'Obter Informação', 'Esconder-se', 'Conhecimento (Arcano)', 'Conhecimento (Religião)', 'Conhecimento (Natureza)', 'Ouvir', 'Furtividade', 'Atuação', 'Profissão', 'Sentir Motivação', 'Prestidigitação', 'Identificar Magia', 'Natação', 'Acrobacia', 'Usar Instrumento Mágico'],
            'Clérigo' => ['Concentração', 'Ofícios', 'Diplomacia', 'Cura', 'Conhecimento (Arcano)', 'Conhecimento (Religião)', 'Profissão', 'Identificar Magia'],
            'Druida' => ['Concentração', 'Ofícios', 'Diplomacia', 'Adestrar Animais', 'Cura', 'Conhecimento (Natureza)', 'Ouvir', 'Profissão', 'Cavalgar', 'Identificar Magia', 'Observar', 'Sobrevivência', 'Natação'],
            'Guerreiro' => ['Escalar', 'Ofícios', 'Adestrar Animais', 'Intimidação', 'Saltar', 'Cavalgar', 'Natação'],
            'Monge' => ['Acrobacia', 'Escalar', 'Ofícios', 'Diplomacia', 'Arte da Fuga', 'Esconder-se', 'Saltar', 'Conhecimento (Arcano)', 'Conhecimento (Religião)', 'Ouvir', 'Furtividade', 'Atuação', 'Profissão', 'Sentir Motivação', 'Observar', 'Natação', 'Acrobacia'],
            'Paladino' => ['Concentração', 'Ofícios', 'Diplomacia', 'Adestrar Animais', 'Cura', 'Conhecimento (Religião)', 'Profissão', 'Cavalgar', 'Sentir Motivação'],
            'Ranger' => ['Escalar', 'Ofícios', 'Concentração', 'Adestrar Animais', 'Cura', 'Esconder-se', 'Saltar', 'Conhecimento (Natureza)', 'Ouvir', 'Furtividade', 'Profissão', 'Cavalgar', 'Procurar', 'Observar', 'Sobrevivência', 'Natação', 'Usar Cordas'],
            'Ladino' => ['Acrobacia', 'Avaliação', 'Blefar', 'Escalar', 'Ofícios', 'Decifrar Escrita', 'Diplomacia', 'Disfarces', 'Arte da Fuga', 'Falsificação', 'Obter Informação', 'Esconder-se', 'Intimidação', 'Saltar', 'Conhecimento (local)', 'Ouvir', 'Furtividade', 'Abrir Fechaduras', 'Atuação', 'Profissão', 'Procurar', 'Sentir Motivação', 'Prestidigitação', 'Observar', 'Natação', 'Acrobacia', 'Usar Instrumento Mágico', 'Usar Cordas'],
            'Feiticeiro' => ['Blefar', 'Concentração', 'Ofícios', 'Conhecimento (Arcano)', 'Profissão', 'Identificar Magia'],
            'Mago' => ['Concentração', 'Ofícios', 'Decifrar Escrita', 'Conhecimento (Arcano)', 'Conhecimento (Religião)', 'Conhecimento (Natureza)', 'Profissão', 'Identificar Magia'],
        ];

        foreach ($map as $className => $skillNames) {
            $class = \App\Models\CharacterClass::where('name', $className)->first();
            if (!$class) continue;

            $skillIds = \App\Models\Skill::whereIn('name', $skillNames)->pluck('id');
            $class->skills()->sync($skillIds);
        }
    }
}
