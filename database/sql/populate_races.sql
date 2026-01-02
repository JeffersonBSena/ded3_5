-- Populating Races (PHB/SRD)
-- Assumes Sizes: 4=Small, 5=Medium

INSERT INTO races (name, size_id, base_speed, level_adjustment, description) VALUES
('Human', 5, 30, 0, 'Humans are the most adaptable of the common races.'),
('Dwarf', 5, 20, 0, 'Dwarves are known for their skill in warfare, their ability to withstand physical and magical punishment, and their knowledge of the earth''s secrets.'),
('Elf', 5, 30, 0, 'Elves mingle freely in human lands, always welcome yet never quite at home.'),
('Gnome', 4, 20, 0, 'Gnomes are welcome everywhere as technicians, alchemists, and inventors.'),
('Half-Elf', 5, 30, 0, 'Half-elves find peace wherever they can, usually by moving on.'),
('Half-Orc', 5, 30, 0, 'Half-orcs are short-tempered and sullen.'),
('Halfling', 4, 20, 0, 'Halflings are clever, capable, and resourceful survivors.');

-- Get IDs for ease of reference in subsequent inserts if using a stored proc, 
-- but here we assume standard auto-inc order: 1=Human, 2=Dwarf, 3=Elf, 4=Gnome, 5=Half-Elf, 6=Half-Orc, 7=Halfling.

-- Race Ability Adjustments
-- Dwarf: Con +2, Cha -2
INSERT INTO race_ability_adjustments (race_id, ability_id, adjustment) VALUES
(2, 3, 2), (2, 6, -2);
-- Elf: Dex +2, Con -2
INSERT INTO race_ability_adjustments (race_id, ability_id, adjustment) VALUES
(3, 2, 2), (3, 3, -2);
-- Gnome: Con +2, Str -2
INSERT INTO race_ability_adjustments (race_id, ability_id, adjustment) VALUES
(4, 3, 2), (4, 1, -2);
-- Half-Orc: Str +2, Int -2, Cha -2
INSERT INTO race_ability_adjustments (race_id, ability_id, adjustment) VALUES
(6, 1, 2), (6, 4, -2), (6, 6, -2);
-- Halfling: Dex +2, Str -2
INSERT INTO race_ability_adjustments (race_id, ability_id, adjustment) VALUES
(7, 2, 2), (7, 1, -2);

-- Racial Traits (Sample of major ones)
INSERT INTO racial_traits (race_id, name, description) VALUES
(1, 'Bonus Feat', '1 extra feat at 1st level'),
(1, 'Bonus Skills', '4 extra skill points at 1st level, 1 per level thereafter'),
(2, 'Darkvision', '60 ft.'),
(2, 'Stonecunning', '+2 check to notice unusual stonework'),
(2, 'Stability', '+4 vs Bull Rush/Trip when standing on ground'),
(3, 'Immunity to Magic Sleep', 'Immune to sleep spells and effects'),
(3, 'Low-Light Vision', 'See twice as far as humans in starlight, moonlight, torchlight'),
(4, 'Low-Light Vision', 'See twice as far as humans in starlight, moonlight, torchlight'),
(4, 'Gnome Combat Training', '+1 attack vs Kobolds and Goblinoids'),
(5, 'Elven Blood', 'For all effects related to race, a half-elf is considered an elf'),
(5, 'Immunity to Magic Sleep', 'Immune to sleep spells and effects'),
(6, 'Darkvision', '60 ft.'),
(6, 'Orc Blood', 'For all effects related to race, a half-orc is considered an orc'),
(7, 'Lucky', '+1 racial bonus on all saving throws'),
(7, 'Fearless', '+2 morale bonus vs Fear');
