<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Character extends Model
{
    protected $fillable = [
        'player_name',
        'character_name',
        'race_id',
        'alignment_id',
        'gender',
        'height',
        'weight',
        'age',
        'experience_points',
        'hp_current',
        'hp_max',
    ];

    public function race()
    {
        return $this->belongsTo(Race::class);
    }

    public function classes()
    {
        return $this->belongsToMany(CharacterClass::class, 'character_classes', 'character_id', 'class_id')
            ->withPivot('level');
    }

    public function abilities()
    {
        // specific relationship or manual helper
        return $this->hasManyThrough(Ability::class, 'character_abilities', 'character_id', 'id', 'id', 'ability_id');
        // Actually this is ManyToMany
        // return $this->belongsToMany(Ability::class, 'character_abilities')->withPivot('base_score', 'temp_score');
    }

    // Helper to get specific ability score
    public function getAbilityScore($abbr)
    {
        // Logic to fetch from pivot
    }
}
