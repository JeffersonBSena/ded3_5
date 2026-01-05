<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

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
        'skills_finalized_at_level',
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
        return $this->belongsToMany(Ability::class, 'character_abilities')
                    ->withPivot('base_score', 'temp_score', 'magic_modifier', 'misc_modifier');
    }
    public function skills()
    {
        return $this->belongsToMany(Skill::class, 'character_skills')
                    ->withPivot('ranks', 'misc_mod');
    }
    
    public function feats()
    {
        return $this->belongsToMany(Feat::class, 'character_feats')
                    ->withPivot('notes')
                    ->withTimestamps();
    }

    public function getFeatSlotsAttribute()
    {
        // Base slots: 1 (at Lv 1) + 1 every 3 levels (3, 6, 9...)
        // Formula: 1 + floor(TotalLevel / 3) 
        // Wait, standard is 1st, 3rd, 6th.
        // Lv 1: 1
        // Lv 2: 1
        // Lv 3: 2
        // Formula: 1 + floor(TotalLevel / 3) IS Correct.

        $totalLevel = 0;
        $fighterLevel = 0;

        foreach ($this->classes as $class) {
            $totalLevel += $class->pivot->level;
            if ($class->name === 'Guerreiro') {
                $fighterLevel = $class->pivot->level;
            }
        }
        if ($totalLevel == 0) $totalLevel = 1; // Fallback

        $slots = 1 + floor($totalLevel / 3);

        // Human bonus: +1 at Lv 1
        if ($this->race && stripos($this->race->name, 'Humano') !== false) {
            $slots += 1;
        }

        // Fighter Bonus Feats
        // Lv 1, 2, 4, 6, 8, 10...
        if ($fighterLevel > 0) {
            if ($fighterLevel == 1) {
                $slots += 1;
            } elseif ($fighterLevel >= 2) {
                // 1 (Lv1) + 1 (Lv2) + (Lv-2)/2
                $slots += 2 + floor(($fighterLevel - 2) / 2);
            }
        }
        
        return $slots;
    }
    public function getAttributesWithModifiersAttribute()
    {
        $abilities = $this->abilities;
        $raceModifiers = $this->race ? $this->race->abilities()->pluck('adjustment', 'ability_id') : [];
        
        return $abilities->map(function ($ability) use ($raceModifiers) {
            $base = $ability->pivot->base_score;
            $magic = $ability->pivot->magic_modifier ?? 0;
            $misc = $ability->pivot->misc_modifier ?? 0;
            $raceMod = $raceModifiers[$ability->id] ?? 0;
            
            $final = $base + $raceMod + $magic + $misc;
            
            $ability->final_score = $final;
            $ability->modifier = floor(($final - 10) / 2);
            $ability->race_mod = $raceMod;
            $ability->magic_mod = $magic;
            $ability->misc_mod = $misc;
            
            return $ability;
        });
    }

    // Helper to get specific ability score
    public function getAbilityScore($abbr)
    {
        // Logic to fetch from pivot
    }

    public function getAvatarUrlAttribute()
    {
        if (!$this->race) {
            return asset('img/avatares/default_avatar.png'); // Fallback
        }

        $raceSlug = Str::slug($this->race->name);
        $gender = $this->gender ?? 'M';
        $filename = "{$raceSlug}_{$gender}_avatar.png";
        $path = "img/avatares/{$filename}";

        if (file_exists(public_path($path))) {
            return asset($path);
        }

        return asset('img/avatares/default_avatar.png'); // Fallback
    }
}
