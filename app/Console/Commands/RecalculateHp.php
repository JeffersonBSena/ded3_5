<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Character;
use App\Models\Race;
use App\Models\CharacterClass;

class RecalculateHp extends Command
{
    protected $signature = 'dnd:recalculate-hp';
    protected $description = 'Recalculates max HP for all characters based on current rules (Level 1 only)';

    public function handle()
    {
        $characters = Character::with(['classes', 'race', 'abilities'])->get();

        foreach ($characters as $character) {
            // Assume Level 1 for now as per current scope
            $class = $character->classes->first();
            if (!$class) continue;

            $hitDie = $class->hitDie;
            if (!$hitDie) {
                $this->error("Character {$character->character_name} class has no hit die.");
                continue; 
            }
            
            // Calculate Con Mod
            $conAttr = $character->abilities->where('abbreviation', 'CON')->first();
            // Or by ID 3 if abbreviation missing, but we translated them to CON/CON
            
            // Fallback if relation not fully loaded with pivot
            $baseCon = 10;
            if ($conAttr) {
                 $baseCon = $conAttr->pivot->base_score;
            } else {
                 // Try ID 3
                 $conAttrById = $character->abilities->where('id', 3)->first();
                 if ($conAttrById) $baseCon = $conAttrById->pivot->base_score;
            }

            // Race Mod
            $race = $character->race;
            $raceMod = 0;
            if ($race) {
                 // We need to fetch race adjustments. 
                 // We can use the accessor from Character if properly loaded, 
                 // or manual fetch. manual is safer here.
                 $adj = \DB::table('race_ability_adjustments')
                        ->where('race_id', $race->id)
                        ->where('ability_id', 3) // CON
                        ->value('adjustment');
                 if ($adj) $raceMod = $adj;
            }
            
            $finalCon = $baseCon + $raceMod;
            $conMod = floor(($finalCon - 10) / 2);
            
            $maxHp = max(1, $hitDie->sides + $conMod);
            
            $character->hp_max = $maxHp;
            $character->hp_current = $maxHp; // Reset current to max for this fix
            $character->save();
            
            $this->info("Updated {$character->character_name}: Con $finalCon (Mod $conMod), HD d{$hitDie->sides} -> HP $maxHp");
        }
    }
}
