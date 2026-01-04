<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CharacterClass extends Model
{
    protected $table = 'classes';
    
    public function hitDie()
    {
        return $this->belongsTo(DiceType::class, 'hit_die_id');
    }
}
