<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Skill extends Model
{
    protected $fillable = ['name', 'attribute', 'trained_only', 'armor_check_penalty'];

    public function classes()
    {
        return $this->belongsToMany(CharacterClass::class, 'class_skills', 'skill_id', 'class_id');
    }

    public function characters()
    {
        return $this->belongsToMany(Character::class, 'character_skills')
                    ->withPivot('ranks', 'misc_mod');
    }
}
