-- Populating Classes (PHB Base Classes)
-- Dice IDs: 2=d6, 3=d8, 4=d10, 5=d12 (from seed.sql assumption: d4, d6, d8, d10, d12)
-- Abilities: 4=INT, 5=WIS, 6=CHA

INSERT INTO classes (name, hit_die_id, skill_points_per_level, bab_progression_type, fort_save_progression, ref_save_progression, will_save_progression, spellcasting_ability_id, description) VALUES
('Barbarian', 5, 4, 'good', 'good', 'poor', 'poor', NULL, 'A ferocious warrior who uses fury and instinct to bring down foes.'),
('Bard', 2, 6, 'medium', 'poor', 'good', 'good', 6, 'A performer whose music works magic.'),
('Cleric', 3, 2, 'medium', 'good', 'poor', 'good', 5, 'A master of divine magic and a capable warrior as well.'),
('Druid', 3, 4, 'medium', 'good', 'poor', 'good', 5, 'One who draws energy from the natural world to cast divine spells and gain magical powers.'),
('Fighter', 4, 2, 'good', 'good', 'poor', 'poor', NULL, 'A warrior with exceptional combat capability and unequaled skill with weapons.'),
('Monk', 3, 4, 'medium', 'good', 'good', 'good', NULL, 'A martial artist whose unarmed strikes hit fast and hard.'),
('Paladin', 4, 2, 'good', 'good', 'poor', 'poor', 5, 'A champion of justice and destroyer of evil.'),
('Ranger', 3, 6, 'good', 'good', 'good', 'poor', 5, 'A cunning, skilled warrior of the wilderness.'),
('Rogue', 2, 8, 'medium', 'poor', 'good', 'poor', NULL, 'A scoundrel who uses stealth and trickery to get the job done.'),
('Sorcerer', 1, 2, 'poor', 'poor', 'poor', 'good', 6, 'A spellcaster born with innate magical ability.'),
('Wizard', 1, 2, 'poor', 'poor', 'poor', 'good', 4, 'A potent spellcaster schooled in the arcane arts.');
-- Note: Sorcerer/Wizard HD is d4 (ID 1). 
-- Wait, let me check seed.sql dice order.
-- seed.sql: d4, d6, d8, d10, d12.
-- So ID 1=d4, 2=d6, 3=d8, 4=d10, 5=d12.
-- Barbarian d12 (ID 5). Correct.
-- Fighter d10 (ID 4). Correct.
-- Cleric d8 (ID 3). Correct.
-- Rogue d6 (ID 2). Correct.
-- Wizard d4 (ID 1). Correct.

-- Class Features (Level 1 only for brevity, can populate more later)
-- Assumes IDs: 1=Barb, 2=Bard, 3=Cler, 4=Dru, 5=Fgt, 6=Mnk, 7=Pal, 8=Rgr, 9=Rog, 10=Sor, 11=Wiz
INSERT INTO class_features (class_id, level_acquired, name, description) VALUES
(1, 1, 'Rage', 'Can range 1/day'),
(1, 1, 'Fast Movement', '+10ft land speed'),
(2, 1, 'Bardic Music', 'Countersong, Fascinate, Inspire Courage +1'),
(2, 1, 'Bardic Knowledge', 'Check to know local lore'),
(3, 1, 'Turn or Rebuke Undead', 'Channel positive/negative energy'),
(3, 1, 'Domains', 'Choose two domains'),
(4, 1, 'Animal Companion', 'Bond with an animal'),
(4, 1, 'Nature Sense', '+2 Knowledge(Nature) and Survival'),
(4, 1, 'Wild Empathy', 'Improve attitude of an animal'),
(5, 1, 'Bonus Feat', 'Select a fighter bonus feat'),
(6, 1, 'Unarmed Strike', 'Improved Dmg'),
(6, 1, 'Flurry of Blows', 'Extra attack with penalty'),
(7, 1, 'Aura of Good', 'Power depends on level'),
(7, 1, 'Detect Evil', 'At will'),
(7, 1, 'Smite Evil', '1/day'),
(8, 1, 'Favored Enemy', 'Bonus vs specific enemy type'),
(8, 1, 'Track', 'Bonus feat'),
(8, 1, 'Wild Empathy', 'As Druid'),
(9, 1, 'Sneak Attack', '+1d6'),
(9, 1, 'Trapfinding', 'Can use Search/Disable Device on DCs > 20'),
(10, 1, 'Summon Familiar', 'Bond with creature'),
(11, 1, 'Summon Familiar', 'Bond with creature'),
(11, 1, 'Scribe Scroll', 'Bonus feat');
