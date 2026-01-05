<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Feat extends Model
{
    protected $fillable = ['name', 'feat_type_id', 'prerequisites_text', 'benefit', 'normal', 'special', 'source_id'];

    public function type()
    {
        return $this->belongsTo(FeatType::class, 'feat_type_id');
    }

    public function characters()
    {
        return $this->belongsToMany(Character::class, 'character_feats')
                    ->withPivot('notes', 'created_at');
    }
}
