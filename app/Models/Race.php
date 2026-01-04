<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Race extends Model
{
    public $timestamps = false; // Usually pivot/catalog tables don't need timestamps unless specified

    public function abilities()
    {
        return $this->belongsToMany(Ability::class, 'race_ability_adjustments')
                    ->withPivot('adjustment');
    }

    public function size()
    {
        return $this->belongsTo(Size::class);
    }
    
    public function getSpeedMetersAttribute()
    {
        // Standard D&D 3.5 conversion
        // 30 ft -> 9m
        // 20 ft -> 6m
        // 40 ft -> 12m
        // 50 ft -> 15m
        // 60 ft -> 18m
        // General rule: feet / 10 * 3
        return floor($this->base_speed / 10) * 3 .'m';
    }
}
