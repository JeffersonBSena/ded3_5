<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class FeatType extends Model
{
    protected $fillable = ['name'];

    public function feats()
    {
        return $this->hasMany(Feat::class);
    }
}
