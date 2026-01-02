-- Populate Advanced Rules Data (Phase 2)
-- Assumes schema.sql V2 has been run and basic seed data exists.

-- 1. Sources
-- INSERT INTO sources (name, abbreviation, publisher, publication_date) VALUES 
-- ('Player''s Handbook', 'PHB', 'Wizards of the Coast', '2003-07-01'),
-- ('Dungeon Master''s Guide', 'DMG', 'Wizards of the Coast', '2003-07-01'),
-- ('Monster Manual', 'MM', 'Wizards of the Coast', '2003-07-01');

-- Set "PHB" as source for existing Core data (if any exists from previous scripts)
-- SAFE UPDATE mode might need to be disabled or use valid WHERE clauses
SET SQL_SAFE_UPDATES = 0;
UPDATE races SET source_id = (SELECT id FROM sources WHERE abbreviation = 'PHB');
UPDATE classes SET source_id = (SELECT id FROM sources WHERE abbreviation = 'PHB');
UPDATE skills SET source_id = (SELECT id FROM sources WHERE abbreviation = 'PHB');
UPDATE items SET source_id = (SELECT id FROM sources WHERE abbreviation = 'PHB');
SET SQL_SAFE_UPDATES = 1;

-- 2. Currencies
INSERT INTO currencies (name, abbreviation, gold_value) VALUES
('Platinum Piece', 'pp', 10.0),
('Gold Piece', 'gp', 1.0),
('Silver Piece', 'sp', 0.1),
('Copper Piece', 'cp', 0.01);

-- 3. Languages
INSERT INTO languages (name, alphabet, description) VALUES
('Common', 'Common', 'Spoken by humans, halflings, half-elves, and half-orcs.'),
('Dwarven', 'Dwarven', 'Spoken by dwarves.'),
('Elven', 'Elven', 'Spoken by elves.'),
('Gnome', 'Dwarven', 'Spoken by gnomes.'),
('Halfling', 'Common', 'Spoken by halflings.'),
('Orc', 'Dwarven', 'Spoken by orcs.'),
('Draconic', 'Draconic', 'Spoken by kobolds, troglodytes, lizardfolk, dragons.'),
('Giant', 'Dwarven', 'Spoken by ogres, giants.'),
('Goblin', 'Dwarven', 'Spoken by goblinoids.'),
('Gnoll', 'Common', 'Spoken by gnolls.');

-- Race Languages (Sample)
-- Human (ID 1)
-- INSERT INTO race_languages (race_id, language_id, is_automatic) VALUES 
-- (1, 1, TRUE); -- Common
-- Dwarf (ID 2)
-- INSERT INTO race_languages (race_id, language_id, is_automatic) VALUES 
-- (2, 1, TRUE), (2, 2, TRUE), -- Common, Dwarven
-- (2, 8, FALSE), (2, 4, FALSE), (2, 9, FALSE), (2, 6, FALSE); -- Bonus: Giant, Gnome, Goblin, Orc

-- 4. Deities (Greyhawk Pantheon - Default 3.5)
-- Domains must exist first. Creating a few common ones.
INSERT INTO domains (name, granted_power, source_id) VALUES
('Good', 'Cast Good spells at +1 caster level.', 1),
('Evil', 'Cast Evil spells at +1 caster level.', 1),
('Law', 'Cast Law spells at +1 caster level.', 1),
('Chaos', 'Cast Chaos spells at +1 caster level.', 1),
('Strength', 'Feat of strength 1/day.', 1),
('Protection', 'Protective Ward 1/day.', 1),
('War', 'Bonus Weapon Focus feat.', 1),
('Death', 'Death Touch 1/day.', 1),
('Magic', 'Use scrolls as wizard.', 1),
('Healing', 'Cast healing spells at +1 caster level.', 1),
('Sun', 'Greater Turning 1/day.', 1);

-- Deity: Pelor (NG) - Sun, Strength, Healing, Good
INSERT INTO deities (name, alignment_id, description, source_id) VALUES
('Pelor', 2, 'The Shining One, god of the sun.', 1);
SET @pelor = LAST_INSERT_ID();
-- Link Domains (assuming IDs match insert order: 1=Good, 2=Evil, 3=Law, 4=Chaos, 5=Str, 6=Prot, 7=War, 8=Death, 9=Magic, 10=Heal, 11=Sun)
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@pelor, 1), (@pelor, 5), (@pelor, 10), (@pelor, 11);

-- Deity: Heironeous (LG) - Law, Good, War
INSERT INTO deities (name, alignment_id, description, source_id) VALUES
('Heironeous', 1, 'God of chivalry and valor.', 1);
SET @heironeous = LAST_INSERT_ID();
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@heironeous, 1), (@heironeous, 3), (@heironeous, 7);

-- 5. Class Starting Gold (Sample)
-- Barbarian: 4d4 x 10gp
INSERT INTO class_starting_gold (class_id, dice_roll, multiplier) VALUES
(1, '4d4', 10), -- Barbarian
(2, '4d4', 10), -- Bard
(3, '5d4', 10), -- Cleric
(4, '2d4', 10), -- Druid
(5, '6d4', 10), -- Fighter
(6, '5d4', 1),  -- Monk (5d4 gp... actually check PHB. Monk is just 5d4. Multiplier 1?) Wait. PHB says "Monk 5d4". Others are "x 10". So yes.
(7, '6d4', 10), -- Paladin
(8, '6d4', 10), -- Ranger
(9, '5d4', 10), -- Rogue
(10, '3d4', 10), -- Sorcerer
(11, '3d4', 10); -- Wizard

-- 6. Carrying Capacity Rule Block (Simplification)
INSERT IGNORE INTO carrying_capacity (strength_score, light_load, medium_load, heavy_load) VALUES
(1, 3, 6, 10),
(2, 6, 13, 20),
(3, 10, 20, 30),
(4, 13, 26, 40),
(5, 16, 33, 50),
(6, 20, 40, 60),
(7, 23, 46, 70),
(8, 26, 53, 80),
(9, 30, 60, 90),
(10, 33, 66, 100),
(11, 38, 76, 115),
(12, 43, 86, 130),
(13, 50, 100, 150),
(14, 58, 116, 175),
(15, 66, 133, 200),
(16, 76, 153, 230),
(17, 86, 173, 260),
(18, 100, 200, 300),
(19, 116, 233, 350),
(20, 133, 266, 400);

-- 7. Combat Actions
INSERT INTO combat_actions (name, action_type, provokes_aoo) VALUES
('Attack (Melee)', 'Standard', FALSE),
('Attack (Ranged)', 'Standard', TRUE),
('Cast a Spell', 'Standard', TRUE),
('Charge', 'Full-Round', FALSE), -- Complex AOO rules, usually No
('Bull Rush', 'Standard', TRUE),
('Disarm', 'Standard', TRUE),
('Grapple', 'Standard', TRUE),
('Trip', 'Standard', TRUE),
('Feint', 'Standard', FALSE);

-- 8. Conditions
INSERT INTO conditions (name, description) VALUES
('Blinded', '-2 AC, loses Dex bonus to AC, moves at half speed, -4 Search/Spot/Str/Dex checks.'),
('Dazed', 'Unable to act normaly. Takes no actions but no penalty to AC.'),
('Flat-footed', 'Loses Dex bonus to AC. Cannot make attacks of opportunity.'),
('Prone', '-4 penalty on melee attacks. +4 AC vs ranged, -4 AC vs melee. Move action to stand.'),
('Stunned', 'Drops everything held, can''t take actions, -2 AC, loses Dex bonus.');

