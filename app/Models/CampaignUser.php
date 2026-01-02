<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CampaignUser extends Model
{
    protected $fillable = [
        'campaign_id',
        'user_id',
        'status',
        'character_id',
    ];

    public function campaign()
    {
        return $this->belongsTo(Campaign::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
