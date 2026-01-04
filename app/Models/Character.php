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
                    ->withPivot('base_score', 'temp_score');
    }
    
    // Accessor to get abilities with racial modifiers
    public function getAttributesWithModifiersAttribute()
    {
        $abilities = $this->abilities;
        $raceModifiers = $this->race ? $this->race->abilities()->pluck('adjustment', 'ability_id') : [];
        
        return $abilities->map(function ($ability) use ($raceModifiers) {
            $base = $ability->pivot->base_score;
            $temp = $ability->pivot->temp_score;
            $raceMod = $raceModifiers[$ability->id] ?? 0;
            
            // In 3.5, racial modifiers affect the "base" for the purpose of calculation, but temp scores override or stack.
            // Simplified: Total = Base + Race + (Temp - Base if Temp exists? No, temp usually replaces or adds)
            // Sticking to: Final = Base + RaceMod
            
            $final = $base + $raceMod;
            
            $ability->final_score = $final;
            $ability->modifier = floor(($final - 10) / 2);
            $ability->race_mod = $raceMod;
            
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
