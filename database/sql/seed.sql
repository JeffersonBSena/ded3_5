-- Basic Seed Data for D&D 3.5

-- 0. Meta - Sources (Crucial for V2 Schema)
INSERT INTO sources (id, name, abbreviation, publisher, publication_date) VALUES 
(1, 'Player''s Handbook', 'PHB', 'Wizards of the Coast', '2003-07-01'),
(2, 'Dungeon Master''s Guide', 'DMG', 'Wizards of the Coast', '2003-07-01'),
(3, 'Monster Manual', 'MM', 'Wizards of the Coast', '2003-07-01');

-- Sizes
INSERT INTO sizes (name, modifier, grapple_modifier, hide_modifier, carrying_capacity_multiplier, source_id) VALUES
('Fine', 8, -16, 16, 0.125, 1),
('Diminutive', 4, -12, 12, 0.25, 1),
('Tiny', 2, -8, 8, 0.5, 1),
('Small', 1, -4, 4, 0.75, 1),
('Medium', 0, 0, 0, 1.0, 1),
('Large', -1, 4, -4, 2.0, 1),
('Huge', -2, 8, -8, 4.0, 1),
('Gargantuan', -4, 12, -12, 8.0, 1),
('Colossal', -8, 16, -16, 16.0, 1);

-- Alignments
INSERT INTO alignments (name, abbreviation, description) VALUES
('Lawful Good', 'LG', 'Crusader'),
('Neutral Good', 'NG', 'Benefactor'),
('Chaotic Good', 'CG', 'Rebel'),
('Lawful Neutral', 'LN', 'Judge'),
('True Neutral', 'N', 'Undecided'),
('Chaotic Neutral', 'CN', 'Free Spirit'),
('Lawful Evil', 'LE', 'Dominator'),
('Neutral Evil', 'NE', 'Malefactor'),
('Chaotic Evil', 'CE', 'Destroyer');

-- Abilities
INSERT INTO abilities (name, abbreviation) VALUES
('Strength', 'STR'),
('Dexterity', 'DEX'),
('Constitution', 'CON'),
('Intelligence', 'INT'),
('Wisdom', 'WIS'),
('Charisma', 'CHA');

-- Dice
INSERT INTO dice_types (name, sides) VALUES
('d4', 4), ('d6', 6), ('d8', 8), ('d10', 10), ('d12', 12), ('d20', 20), ('d100', 100);

-- Damage Types
INSERT INTO damage_types (name) VALUES
('Bludgeoning'), ('Piercing'), ('Slashing'), ('Fire'), ('Cold'), ('Electricity'), ('Acid'), ('Sonic'), ('Force');

-- Magic Schools
INSERT INTO magic_schools (name) VALUES
('Abjuration'), ('Conjuration'), ('Divination'), ('Enchantment'), ('Evocation'), ('Illusion'), ('Necromancy'), ('Transmutation'), ('Universal');

-- Item Types
INSERT INTO item_types (name) VALUES
('Weapon'), ('Armor'), ('Shield'), ('Potion'), ('Ring'), ('Wondrous Item'), ('Rod'), ('Staff'), ('Wand'), ('Scroll'), ('Goods and Services');
