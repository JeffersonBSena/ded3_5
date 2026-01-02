-- Populating Equipment (Simple Weapons & Armor)
-- Item Types (seed.sql): 1=Weapon, 2=Armor, 3=Shield, 4=Potion...
-- Dice (seed.sql): 1=d4, 2=d6, 3=d8, 4=d10, 5=d12. (Checking seed.sql again to be safe)
-- seed.sql: d4, d6, d8, d10, d12, d20, d100. So 1=d4, 2=d6, 3=d8...
-- Damage Types: 1=B, 2=P, 3=S

-- Weapons (Type 1)
-- Dagger (1d4, 19-20/x2, P or S) - Simplifying to P(2) for now
INSERT INTO items (name, item_type_id, cost_gp, weight_lb, description) VALUES
('Dagger', 1, 2.0, 1.0, 'Typical dagger.');
SET @id = LAST_INSERT_ID();
INSERT INTO weapons (item_id, damage_dice_id, num_dice, critical_range, damage_type_id, range_increment, category, light_one_two_handed) VALUES
(@id, 1, 1, '19-20/x2', 2, 10, 'Simple', 'Light');

-- Longsword (1d8, 19-20/x2, S)
INSERT INTO items (name, item_type_id, cost_gp, weight_lb, description) VALUES
('Longsword', 1, 15.0, 4.0, 'A classic blade.');
SET @id = LAST_INSERT_ID();
INSERT INTO weapons (item_id, damage_dice_id, num_dice, critical_range, damage_type_id, range_increment, category, light_one_two_handed) VALUES
(@id, 3, 1, '19-20/x2', 3, NULL, 'Martial', 'One-Handed');

-- Greatsword (2d6, 19-20/x2, S)
INSERT INTO items (name, item_type_id, cost_gp, weight_lb, description) VALUES
('Greatsword', 1, 50.0, 8.0, 'A massive two-handed blade.');
SET @id = LAST_INSERT_ID();
INSERT INTO weapons (item_id, damage_dice_id, num_dice, critical_range, damage_type_id, range_increment, category, light_one_two_handed) VALUES
(@id, 2, 2, '19-20/x2', 3, NULL, 'Martial', 'Two-Handed');

-- Shortbow (1d6, x3, P)
INSERT INTO items (name, item_type_id, cost_gp, weight_lb, description) VALUES
('Shortbow', 1, 30.0, 2.0, 'Standard bow.');
SET @id = LAST_INSERT_ID();
INSERT INTO weapons (item_id, damage_dice_id, num_dice, critical_range, damage_type_id, range_increment, category, light_one_two_handed) VALUES
(@id, 2, 1, 'x3', 2, 60, 'Martial', 'Two-Handed');

-- Armor (Type 2)
-- Padded
INSERT INTO items (name, item_type_id, cost_gp, weight_lb, description) VALUES
('Padded', 2, 5.0, 10.0, 'Quilted layers of cloth and batting.');
SET @id = LAST_INSERT_ID();
INSERT INTO armor (item_id, armor_bonus, max_dex_bonus, armor_check_penalty, arcane_spell_failure, speed_30, speed_20, category) VALUES
(@id, 1, 8, 0, 5, 30, 20, 'Light');

-- Leather
INSERT INTO items (name, item_type_id, cost_gp, weight_lb, description) VALUES
('Leather', 2, 10.0, 15.0, 'Leather armor.');
SET @id = LAST_INSERT_ID();
INSERT INTO armor (item_id, armor_bonus, max_dex_bonus, armor_check_penalty, arcane_spell_failure, speed_30, speed_20, category) VALUES
(@id, 2, 6, 0, 10, 30, 20, 'Light');

-- Chainmail
INSERT INTO items (name, item_type_id, cost_gp, weight_lb, description) VALUES
('Chainmail', 2, 150.0, 40.0, 'Interlocking metal rings.');
SET @id = LAST_INSERT_ID();
INSERT INTO armor (item_id, armor_bonus, max_dex_bonus, armor_check_penalty, arcane_spell_failure, speed_30, speed_20, category) VALUES
(@id, 5, 2, -5, 30, 20, 15, 'Medium');

-- Full Plate
INSERT INTO items (name, item_type_id, cost_gp, weight_lb, description) VALUES
('Full Plate', 2, 1500.0, 50.0, 'Suits of metal plates.');
SET @id = LAST_INSERT_ID();
INSERT INTO armor (item_id, armor_bonus, max_dex_bonus, armor_check_penalty, arcane_spell_failure, speed_30, speed_20, category) VALUES
(@id, 8, 1, -6, 35, 20, 15, 'Heavy');

-- Shield (Type 3)
-- Heavy Steel Shield
INSERT INTO items (name, item_type_id, cost_gp, weight_lb, description) VALUES
('Heavy Steel Shield', 3, 20.0, 15.0, 'Large metal shield.');
SET @id = LAST_INSERT_ID();
INSERT INTO armor (item_id, armor_bonus, max_dex_bonus, armor_check_penalty, arcane_spell_failure, speed_30, speed_20, category) VALUES
(@id, 2, NULL, -2, 15, 30, 20, 'Shield');

