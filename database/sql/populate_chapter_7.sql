
-- POPULATE CHAPTER 7: EQUIPMENT (FULL)
-- Covers: Wealth, Weapons, Armor, Goods, Services, Mounts, Vehicles, Clothing.

SET FOREIGN_KEY_CHECKS = 0;

-- Helper Variables for Damage Types
SET @DT_BLUDG = (SELECT id FROM damage_types WHERE name = 'Bludgeoning' LIMIT 1);
SET @DT_PIERC = (SELECT id FROM damage_types WHERE name = 'Piercing' LIMIT 1);
SET @DT_SLASH = (SELECT id FROM damage_types WHERE name = 'Slashing' LIMIT 1);
INSERT IGNORE INTO damage_types (name) VALUES 
('Bludgeoning and Piercing'), 
('Piercing or Slashing'), 
('Bludgeoning or Piercing'),
('Slashing or Bludgeoning');
SET @DT_B_AND_P = (SELECT id FROM damage_types WHERE name = 'Bludgeoning and Piercing' LIMIT 1);
SET @DT_P_OR_S = (SELECT id FROM damage_types WHERE name = 'Piercing or Slashing' LIMIT 1); 
SET @DT_B_OR_P = (SELECT id FROM damage_types WHERE name = 'Bludgeoning or Piercing' LIMIT 1);

-- Helper Variables for Dice
INSERT IGNORE INTO dice_types (name, sides) VALUES ('d2', 2), ('d3', 3);
SET @D2 = (SELECT id FROM dice_types WHERE name = 'd2' LIMIT 1);
SET @D3 = (SELECT id FROM dice_types WHERE name = 'd3' LIMIT 1);
SET @D4 = (SELECT id FROM dice_types WHERE name = 'd4' LIMIT 1);
SET @D6 = (SELECT id FROM dice_types WHERE name = 'd6' LIMIT 1);
SET @D8 = (SELECT id FROM dice_types WHERE name = 'd8' LIMIT 1);
SET @D10 = (SELECT id FROM dice_types WHERE name = 'd10' LIMIT 1);
SET @D12 = (SELECT id FROM dice_types WHERE name = 'd12' LIMIT 1);

-- Ensure Item Types exist
INSERT IGNORE INTO item_types (name) VALUES 
('Alchemical Item'),
('Clothing'),
('Tool'),
('Mount'),
('Vehicle'),
('Service'),
('Conveyance'), -- Container
('Food/Drink/Lodging');

-- Refresh Variables
SET @IT_WEAPON = (SELECT id FROM item_types WHERE name = 'Weapon' LIMIT 1);
SET @IT_ARMOR  = (SELECT id FROM item_types WHERE name = 'Armor' LIMIT 1);
SET @IT_SHIELD = (SELECT id FROM item_types WHERE name = 'Shield' LIMIT 1);
SET @IT_GOODS  = (SELECT id FROM item_types WHERE name = 'Goods and Services' LIMIT 1);
SET @IT_ALCHEM = (SELECT id FROM item_types WHERE name = 'Alchemical Item' LIMIT 1);
SET @IT_CLOTHI = (SELECT id FROM item_types WHERE name = 'Clothing' LIMIT 1);
SET @IT_TOOL   = (SELECT id FROM item_types WHERE name = 'Tool' LIMIT 1);
SET @IT_MOUNT  = (SELECT id FROM item_types WHERE name = 'Mount' LIMIT 1);
SET @IT_VEHICL = (SELECT id FROM item_types WHERE name = 'Vehicle' LIMIT 1);
SET @IT_SERVIC = (SELECT id FROM item_types WHERE name = 'Service' LIMIT 1);
SET @IT_CONVEY = (SELECT id FROM item_types WHERE name = 'Conveyance' LIMIT 1);
SET @IT_FOOD   = (SELECT id FROM item_types WHERE name = 'Food/Drink/Lodging' LIMIT 1);

-- Clean up existing data for Chapter 7 (PHB Source = 1)
DELETE FROM weapons;
DELETE FROM armor;
DELETE FROM items WHERE source_id = 1;

-- ==========================================
-- 1. WEALTH & CURRENCY
-- ==========================================
TRUNCATE TABLE class_starting_gold;

SET @C_BARB = (SELECT id FROM classes WHERE name = 'Bárbaro' LIMIT 1);
SET @C_BARD = (SELECT id FROM classes WHERE name = 'Bardo' LIMIT 1);
SET @C_CLER = (SELECT id FROM classes WHERE name = 'Clérigo' LIMIT 1);
SET @C_DRUI = (SELECT id FROM classes WHERE name = 'Druida' LIMIT 1);
SET @C_FIGH = (SELECT id FROM classes WHERE name = 'Guerreiro' LIMIT 1);
SET @C_MONK = (SELECT id FROM classes WHERE name = 'Monge' LIMIT 1);
SET @C_PALA = (SELECT id FROM classes WHERE name = 'Paladino' LIMIT 1);
SET @C_RANG = (SELECT id FROM classes WHERE name = 'Ranger' LIMIT 1);
SET @C_ROGU = (SELECT id FROM classes WHERE name = 'Ladino' LIMIT 1);
SET @C_SORC = (SELECT id FROM classes WHERE name = 'Feiticeiro' LIMIT 1);
SET @C_WIZA = (SELECT id FROM classes WHERE name = 'Mago' LIMIT 1);

INSERT INTO class_starting_gold (class_id, dice_roll, multiplier) VALUES
(@C_BARB, '4d4', 10),
(@C_BARD, '4d4', 10),
(@C_CLER, '5d4', 10),
(@C_DRUI, '2d4', 10),
(@C_FIGH, '6d4', 10),
(@C_MONK, '5d4', 1),
(@C_PALA, '6d4', 10),
(@C_RANG, '6d4', 10),
(@C_ROGU, '5d4', 10),
(@C_SORC, '3d4', 10),
(@C_WIZA, '3d4', 10);

TRUNCATE TABLE currencies;
INSERT INTO currencies (name, abbreviation, gold_value) VALUES
('Peça de Cobre', 'PC', 0.01),
('Peça de Prata', 'PP', 0.10),
('Peça de Ouro', 'PO', 1.00),
('Peça de Platina', 'PL', 10.00);

-- ==========================================
-- 2. WEAPONS (Table 7-5)
-- ==========================================
DROP PROCEDURE IF EXISTS InsertWeapon;
DELIMITER //
CREATE PROCEDURE InsertWeapon(
    IN p_name VARCHAR(100),
    IN p_cost DECIMAL(10,2),
    IN p_weight DECIMAL(10,2),
    IN p_damage_dice_id INT,
    IN p_num_dice INT,
    IN p_crit VARCHAR(20),
    IN p_range INT,
    IN p_dmg_type_id INT,
    IN p_cat VARCHAR(20), 
    IN p_hands VARCHAR(20), 
    IN p_source_id INT
)
BEGIN
    INSERT INTO items (name, item_type_id, cost_gp, weight_lb, description, source_id)
    VALUES (p_name, (SELECT id FROM item_types WHERE name='Weapon' LIMIT 1), p_cost, p_weight, 'See weapon table', p_source_id);
    
    INSERT INTO weapons (item_id, damage_dice_id, num_dice, critical_range, damage_type_id, range_increment, category, light_one_two_handed)
    VALUES (LAST_INSERT_ID(), p_damage_dice_id, p_num_dice, p_crit, p_dmg_type_id, p_range, p_cat, p_hands);
END //
DELIMITER ;

-- Simple Weapons
CALL InsertWeapon('Ataque Desarmado', 0, 0, @D3, 1, '20/x2', 0, @DT_BLUDG, 'Simple', 'Light', 1);
CALL InsertWeapon('Manopla', 2, 0.5, @D3, 1, '20/x2', 0, @DT_BLUDG, 'Simple', 'Light', 1);
CALL InsertWeapon('Adaga', 2, 0.5, @D4, 1, '19-20/x2', 3, @DT_P_OR_S, 'Simple', 'Light', 1);
CALL InsertWeapon('Adaga de soco', 2, 0.5, @D4, 1, '20/x3', 0, @DT_PIERC, 'Simple', 'Light', 1);
CALL InsertWeapon('Foice curta', 6, 1, @D6, 1, '20/x2', 0, @DT_SLASH, 'Simple', 'Light', 1);
CALL InsertWeapon('Maça leve', 5, 2, @D6, 1, '20/x2', 0, @DT_BLUDG, 'Simple', 'Light', 1);
CALL InsertWeapon('Manopla com cravos', 5, 0.5, @D4, 1, '20/x2', 0, @DT_PIERC, 'Simple', 'Light', 1);
CALL InsertWeapon('Clava', 0, 1.5, @D6, 1, '20/x2', 3, @DT_BLUDG, 'Simple', 'One-Handed', 1);
CALL InsertWeapon('Lança curta', 1, 1.5, @D6, 1, '20/x2', 6, @DT_PIERC, 'Simple', 'One-Handed', 1);
CALL InsertWeapon('Maça pesada', 12, 4, @D8, 1, '20/x2', 0, @DT_BLUDG, 'Simple', 'One-Handed', 1);
CALL InsertWeapon('Maça-estrela', 8, 3, @D8, 1, '20/x2', 0, @DT_B_AND_P, 'Simple', 'One-Handed', 1);
CALL InsertWeapon('Bordão', 0, 2, @D6, 1, '20/x2', 0, @DT_BLUDG, 'Simple', 'Two-Handed', 1);
CALL InsertWeapon('Lança', 2, 3, @D8, 1, '20/x3', 6, @DT_PIERC, 'Simple', 'Two-Handed', 1);
CALL InsertWeapon('Lança longa', 5, 4.5, @D8, 1, '20/x3', 0, @DT_PIERC, 'Simple', 'Two-Handed', 1);
CALL InsertWeapon('Azagaia', 1, 1, @D6, 1, '20/x2', 9, @DT_PIERC, 'Simple', 'Light', 1);
CALL InsertWeapon('Besta leve', 35, 2, @D8, 1, '19-20/x2', 24, @DT_PIERC, 'Simple', 'Two-Handed', 1);
CALL InsertWeapon('Besta pesada', 50, 4, @D10, 1, '19-20/x2', 36, @DT_PIERC, 'Simple', 'Two-Handed', 1);
CALL InsertWeapon('Dardo', 0.5, 0.25, @D4, 1, '20/x2', 6, @DT_PIERC, 'Simple', 'Light', 1);
CALL InsertWeapon('Funda', 0, 0, @D4, 1, '20/x2', 15, @DT_BLUDG, 'Simple', 'One-Handed', 1);

-- Martial Weapons
CALL InsertWeapon('Armadura com cravos', 50, 5, @D6, 1, '20/x2', 0, @DT_PIERC, 'Martial', 'Light', 1);
CALL InsertWeapon('Escudo leve com cravos', 0, 0, @D4, 1, '20/x2', 0, @DT_PIERC, 'Martial', 'Light', 1);
CALL InsertWeapon('Espada curta', 10, 1, @D6, 1, '19-20/x2', 0, @DT_PIERC, 'Martial', 'Light', 1);
CALL InsertWeapon('Kukri', 8, 1, @D4, 1, '18-20/x2', 0, @DT_SLASH, 'Martial', 'Light', 1);
CALL InsertWeapon('Machadinha', 6, 1.5, @D6, 1, '20/x3', 0, @DT_SLASH, 'Martial', 'Light', 1);
CALL InsertWeapon('Machado de Arremesso', 8, 1, @D6, 1, '20/x2', 3, @DT_SLASH, 'Martial', 'Light', 1);
CALL InsertWeapon('Martelo leve', 1, 1, @D4, 1, '20/x2', 6, @DT_BLUDG, 'Martial', 'Light', 1);
CALL InsertWeapon('Picareta leve', 4, 2, @D4, 1, '20/x4', 0, @DT_PIERC, 'Martial', 'Light', 1);
CALL InsertWeapon('Porrete', 1, 1.5, @D6, 1, '20/x2', 0, @DT_BLUDG, 'Martial', 'Light', 1);
CALL InsertWeapon('Cimitarra', 15, 2, @D6, 1, '18-20/x2', 0, @DT_SLASH, 'Martial', 'One-Handed', 1);
CALL InsertWeapon('Escudo pesado com cravos', 0, 0, @D6, 1, '20/x2', 0, @DT_PIERC, 'Martial', 'One-Handed', 1);
CALL InsertWeapon('Espada longa', 15, 2, @D8, 1, '19-20/x2', 0, @DT_SLASH, 'Martial', 'One-Handed', 1);
CALL InsertWeapon('Machado de batalha', 10, 3, @D8, 1, '20/x3', 0, @DT_SLASH, 'Martial', 'One-Handed', 1);
CALL InsertWeapon('Mangual', 8, 2.5, @D8, 1, '20/x2', 0, @DT_BLUDG, 'Martial', 'One-Handed', 1);
CALL InsertWeapon('Martelo de guerra', 12, 2.5, @D8, 1, '20/x3', 0, @DT_BLUDG, 'Martial', 'One-Handed', 1);
CALL InsertWeapon('Picareta pesada', 8, 3, @D6, 1, '20/x4', 0, @DT_PIERC, 'Martial', 'One-Handed', 1);
CALL InsertWeapon('Sabre', 20, 1, @D6, 1, '18-20/x2', 0, @DT_PIERC, 'Martial', 'One-Handed', 1);
CALL InsertWeapon('Tridente', 15, 2, @D8, 1, '20/x2', 3, @DT_PIERC, 'Martial', 'One-Handed', 1);
CALL InsertWeapon('Alabarda', 10, 6, @D10, 1, '20/x3', 0, @DT_P_OR_S, 'Martial', 'Two-Handed', 1);
CALL InsertWeapon('Clava grande', 5, 4, @D10, 1, '20/x2', 0, @DT_BLUDG, 'Martial', 'Two-Handed', 1);
CALL InsertWeapon('Espada larga', 50, 4, @D6, 2, '19-20/x2', 0, @DT_SLASH, 'Martial', 'Two-Handed', 1);
CALL InsertWeapon('Falcione', 75, 4, @D4, 2, '18-20/x2', 0, @DT_SLASH, 'Martial', 'Two-Handed', 1);
CALL InsertWeapon('Foice longa', 18, 5, @D4, 2, '20/x4', 0, @DT_P_OR_S, 'Martial', 'Two-Handed', 1);
CALL InsertWeapon('Glaive', 8, 5, @D10, 1, '20/x3', 0, @DT_SLASH, 'Martial', 'Two-Handed', 1);
CALL InsertWeapon('Guisarme', 9, 6, @D4, 2, '20/x3', 0, @DT_SLASH, 'Martial', 'Two-Handed', 1);
CALL InsertWeapon('Lança montada', 10, 5, @D8, 1, '20/x3', 0, @DT_PIERC, 'Martial', 'Two-Handed', 1);
CALL InsertWeapon('Machado grande', 20, 6, @D12, 1, '20/x3', 0, @DT_SLASH, 'Martial', 'Two-Handed', 1);
CALL InsertWeapon('Mangual pesado', 15, 5, @D10, 1, '19-20/x2', 0, @DT_BLUDG, 'Martial', 'Two-Handed', 1);
CALL InsertWeapon('Ranseur', 10, 6, @D4, 2, '20/x3', 0, @DT_PIERC, 'Martial', 'Two-Handed', 1);
CALL InsertWeapon('Arco curto', 30, 1, @D6, 1, '20/x3', 18, @DT_PIERC, 'Martial', 'Two-Handed', 1);
CALL InsertWeapon('Arco curto composto', 75, 1, @D6, 1, '20/x3', 21, @DT_PIERC, 'Martial', 'Two-Handed', 1);
CALL InsertWeapon('Arco longo', 75, 1.5, @D8, 1, '20/x3', 30, @DT_PIERC, 'Martial', 'Two-Handed', 1);
CALL InsertWeapon('Arco longo composto', 100, 1.5, @D8, 1, '20/x3', 33, @DT_PIERC, 'Martial', 'Two-Handed', 1);

-- Exotic Weapons
CALL InsertWeapon('Kama', 2, 1, @D6, 1, '20/x2', 0, @DT_SLASH, 'Exotic', 'Light', 1);
CALL InsertWeapon('Nunchaku', 2, 1, @D6, 1, '20/x2', 0, @DT_BLUDG, 'Exotic', 'Light', 1);
CALL InsertWeapon('Sai', 1, 0.5, @D4, 1, '20/x2', 3, @DT_BLUDG, 'Exotic', 'Light', 1);
CALL InsertWeapon('Siangham', 3, 0.5, @D6, 1, '20/x2', 0, @DT_PIERC, 'Exotic', 'Light', 1);
CALL InsertWeapon('Chicote', 1, 1, @D3, 1, '20/x2', 0, @DT_SLASH, 'Exotic', 'One-Handed', 1);
CALL InsertWeapon('Espada bastarda', 35, 3, @D10, 1, '19-20/x2', 0, @DT_SLASH, 'Exotic', 'One-Handed', 1);
CALL InsertWeapon('Machado de guerra anão', 30, 4, @D10, 1, '20/x3', 0, @DT_SLASH, 'Exotic', 'One-Handed', 1);
CALL InsertWeapon('Corrente com cravos', 25, 5, @D4, 2, '20/x2', 0, @DT_PIERC, 'Exotic', 'Two-Handed', 1);
CALL InsertWeapon('Espada de duas lâminas', 100, 5, @D8, 1, '19-20/x2', 0, @DT_SLASH, 'Exotic', 'Two-Handed', 1);
CALL InsertWeapon('Machado orc duplo', 60, 7.5, @D8, 1, '20/x3', 0, @DT_SLASH, 'Exotic', 'Two-Handed', 1);
CALL InsertWeapon('Mangual atroz', 90, 5, @D8, 1, '20/x2', 0, @DT_BLUDG, 'Exotic', 'Two-Handed', 1);
CALL InsertWeapon('Martelo gnomo com gancho', 20, 3, @D8, 1, '20/x3', 0, @DT_BLUDG, 'Exotic', 'Two-Handed', 1);
CALL InsertWeapon('Urgrosh anão', 50, 6, @D8, 1, '20/x3', 0, @DT_P_OR_S, 'Exotic', 'Two-Handed', 1);
CALL InsertWeapon('Besta de mão', 100, 1, @D4, 1, '19-20/x2', 9, @DT_PIERC, 'Exotic', 'Light', 1);
CALL InsertWeapon('Besta leve de repetição', 250, 3, @D8, 1, '19-20/x2', 24, @DT_PIERC, 'Exotic', 'Two-Handed', 1);
CALL InsertWeapon('Besta pesada de repetição', 400, 6, @D10, 1, '19-20/x2', 36, @DT_PIERC, 'Exotic', 'Two-Handed', 1);
CALL InsertWeapon('Boleadeira', 5, 1, @D4, 1, '20/x2', 3, @DT_BLUDG, 'Exotic', 'Light', 1);
CALL InsertWeapon('Rede', 20, 3, 0, 0, '--', 3, @DT_BLUDG, 'Exotic', 'One-Handed', 1);
CALL InsertWeapon('Shuriken', 1, 0.1, @D2, 1, '20/x2', 3, @DT_PIERC, 'Exotic', 'Light', 1);


-- ==========================================
-- 3. ARMOR (Table 7-6)
-- ==========================================
DROP PROCEDURE IF EXISTS InsertArmor;
DELIMITER //
CREATE PROCEDURE InsertArmor(
    IN p_name VARCHAR(100),
    IN p_cost DECIMAL(10,2),
    IN p_weight DECIMAL(10,2),
    IN p_bonus INT,
    IN p_max_dex INT,
    IN p_check_pen INT,
    IN p_spell_fail INT,
    IN p_speed30 INT,
    IN p_speed20 INT,
    IN p_cat VARCHAR(20),
    IN p_source_id INT
)
BEGIN
    INSERT INTO items (name, item_type_id, cost_gp, weight_lb, description, source_id)
    VALUES (p_name, (SELECT id FROM item_types WHERE name='Armor' LIMIT 1), p_cost, p_weight, 'See armor table', p_source_id);
    
    INSERT INTO armor (item_id, armor_bonus, max_dex_bonus, armor_check_penalty, arcane_spell_failure, speed_30, speed_20, category)
    VALUES (LAST_INSERT_ID(), p_bonus, p_max_dex, p_check_pen, p_spell_fail, p_speed30, p_speed20, p_cat);
END //
DELIMITER ;

-- Armor Data
CALL InsertArmor('Acolchoada', 5, 5, 1, 8, 0, 5, 30, 20, 'Light', 1);
CALL InsertArmor('Couro', 10, 7.5, 2, 6, 0, 10, 30, 20, 'Light', 1);
CALL InsertArmor('Couro batido', 25, 10, 3, 5, -1, 15, 30, 20, 'Light', 1);
CALL InsertArmor('Camisão de Cota de Malha', 100, 12.5, 4, 4, -2, 20, 30, 20, 'Light', 1);
CALL InsertArmor('Gibão de Peles', 15, 12.5, 3, 4, -3, 20, 20, 15, 'Medium', 1);
CALL InsertArmor('Brunea', 50, 15, 4, 3, -4, 25, 20, 15, 'Medium', 1);
CALL InsertArmor('Cota de Malha', 150, 20, 5, 2, -5, 30, 20, 15, 'Medium', 1);
CALL InsertArmor('Peitoral de Aço', 200, 15, 5, 3, -4, 25, 20, 15, 'Medium', 1);
CALL InsertArmor('Cota de Talas', 20, 22.5, 6, 0, -7, 40, 20, 15, 'Heavy', 1);
CALL InsertArmor('Loriga Segmentada', 250, 17.5, 6, 1, -6, 35, 20, 15, 'Heavy', 1);
CALL InsertArmor('Meia Armadura', 600, 25, 7, 0, -7, 40, 20, 15, 'Heavy', 1);
CALL InsertArmor('Armadura de Batalha', 1500, 25, 8, 1, -6, 35, 20, 15, 'Heavy', 1);

-- Shields (Manually inserted to set item_types='Shield')
INSERT INTO items (name, item_type_id, cost_gp, weight_lb, description, source_id) VALUES ('Broquel', @IT_SHIELD, 15, 2.5, 'Escudo', 1);
INSERT INTO armor (item_id, armor_bonus, max_dex_bonus, armor_check_penalty, arcane_spell_failure, speed_30, speed_20, category) VALUES (LAST_INSERT_ID(), 1, NULL, -1, 5, 0, 0, 'Shield');
INSERT INTO items (name, item_type_id, cost_gp, weight_lb, description, source_id) VALUES ('Escudo Pequeno de Madeira', @IT_SHIELD, 3, 2.5, 'Escudo', 1);
INSERT INTO armor (item_id, armor_bonus, max_dex_bonus, armor_check_penalty, arcane_spell_failure, speed_30, speed_20, category) VALUES (LAST_INSERT_ID(), 1, NULL, -1, 5, 0, 0, 'Shield');
INSERT INTO items (name, item_type_id, cost_gp, weight_lb, description, source_id) VALUES ('Escudo Pequeno de Metal', @IT_SHIELD, 9, 3, 'Escudo', 1);
INSERT INTO armor (item_id, armor_bonus, max_dex_bonus, armor_check_penalty, arcane_spell_failure, speed_30, speed_20, category) VALUES (LAST_INSERT_ID(), 1, NULL, -1, 5, 0, 0, 'Shield');
INSERT INTO items (name, item_type_id, cost_gp, weight_lb, description, source_id) VALUES ('Escudo Grande de Madeira', @IT_SHIELD, 7, 5, 'Escudo', 1);
INSERT INTO armor (item_id, armor_bonus, max_dex_bonus, armor_check_penalty, arcane_spell_failure, speed_30, speed_20, category) VALUES (LAST_INSERT_ID(), 2, NULL, -2, 15, 0, 0, 'Shield');
INSERT INTO items (name, item_type_id, cost_gp, weight_lb, description, source_id) VALUES ('Escudo Grande de Metal', @IT_SHIELD, 20, 7.5, 'Escudo', 1);
INSERT INTO armor (item_id, armor_bonus, max_dex_bonus, armor_check_penalty, arcane_spell_failure, speed_30, speed_20, category) VALUES (LAST_INSERT_ID(), 2, NULL, -2, 15, 0, 0, 'Shield');
INSERT INTO items (name, item_type_id, cost_gp, weight_lb, description, source_id) VALUES ('Escudo de Corpo', @IT_SHIELD, 30, 22.5, 'Escudo', 1);
INSERT INTO armor (item_id, armor_bonus, max_dex_bonus, armor_check_penalty, arcane_spell_failure, speed_30, speed_20, category) VALUES (LAST_INSERT_ID(), 4, NULL, -10, 50, 0, 0, 'Shield');


-- ==========================================
-- 4. GOODS & SERVICES (Table 7-8 and lists)
-- ==========================================
DROP PROCEDURE IF EXISTS InsertGood;
DELIMITER //
CREATE PROCEDURE InsertGood(
    IN p_name VARCHAR(100),
    IN p_cost DECIMAL(10,2),
    IN p_weight DECIMAL(10,2),
    IN p_type_id INT
)
BEGIN
    INSERT INTO items (name, item_type_id, cost_gp, weight_lb, description, source_id)
    VALUES (p_name, p_type_id, p_cost, p_weight, 'Equipamento de Aventura', 1);
END //
DELIMITER ;

CALL InsertGood('Agulha de costura', 0.5, 0, @IT_GOODS);
CALL InsertGood('Algemas (obra-prima)', 50, 1, @IT_GOODS);
CALL InsertGood('Algemas', 15, 1, @IT_GOODS);
CALL InsertGood('Algibeira', 1, 0.25, @IT_CONVEY);
CALL InsertGood('Anzol', 0.1, 0, @IT_GOODS);
CALL InsertGood('Apito de advertência', 0.8, 0, @IT_GOODS);
CALL InsertGood('Aríete', 10, 10, @IT_GOODS);
CALL InsertGood('Balde (vazio)', 0.5, 1, @IT_CONVEY);
CALL InsertGood('Barril (vazio)', 2, 15, @IT_CONVEY);
CALL InsertGood('Baú (vazio)', 2, 12.5, @IT_CONVEY);
CALL InsertGood('Caneco de cerâmica', 0.02, 0.5, @IT_GOODS);
CALL InsertGood('Caneta tinteiro', 0.1, 0, @IT_GOODS);
CALL InsertGood('Cantil', 1, 2, @IT_CONVEY);
CALL InsertGood('Cesto (vazio)', 0.4, 0.5, @IT_CONVEY);
CALL InsertGood('Cobertor de inverno', 0.5, 1.5, @IT_GOODS);
CALL InsertGood('Corda de Cânhamo (15 m)', 1, 5, @IT_GOODS);
CALL InsertGood('Corda de seda (15 m)', 10, 2.5, @IT_GOODS);
CALL InsertGood('Corrente (3 m)', 30, 1, @IT_GOODS);
CALL InsertGood('Escada (3 m)', 0.05, 10, @IT_GOODS);
CALL InsertGood('Esmeril', 0.02, 0.5, @IT_GOODS);
CALL InsertGood('Espelho de metal pequeno', 10, 0.25, @IT_GOODS);
CALL InsertGood('Estrepes', 1, 1, @IT_GOODS);
CALL InsertGood('Fechadura (Muito simples)', 20, 0.5, @IT_GOODS);
CALL InsertGood('Fechadura (Padrão)', 40, 0.5, @IT_GOODS);
CALL InsertGood('Fechadura (Bom)', 80, 0.5, @IT_GOODS);
CALL InsertGood('Fechadura (Incrível)', 150, 0.5, @IT_GOODS);
CALL InsertGood('Frasco (vazio)', 0.03, 0.75, @IT_CONVEY);
CALL InsertGood('Garrafa de vinho (vidro)', 2, 0, @IT_CONVEY);
CALL InsertGood('Giz (1 pedaço)', 0.01, 0, @IT_GOODS);
CALL InsertGood('Jarro de cerâmica', 0.03, 4.5, @IT_CONVEY);
CALL InsertGood('Lâmpada', 0.1, 0.5, @IT_GOODS);
CALL InsertGood('Lanterna coberta', 7, 1, @IT_GOODS);
CALL InsertGood('Lanterna furta-fogo', 12, 1.5, @IT_GOODS);
CALL InsertGood('Lenha (por dia)', 0.01, 10, @IT_GOODS);
CALL InsertGood('Lona (m2)', 0.1, 0.5, @IT_GOODS);
CALL InsertGood('Luneta', 1000, 0.5, @IT_GOODS);
CALL InsertGood('Marreta', 1, 5, @IT_GOODS);
CALL InsertGood('Martelo', 0.5, 1, @IT_GOODS);
CALL InsertGood('Mochila (vazia)', 2, 1, @IT_CONVEY);
CALL InsertGood('Óleo (500 ml)', 0.1, 0.5, @IT_GOODS);
CALL InsertGood('Pá', 2, 4, @IT_GOODS);
CALL InsertGood('Panela de ferro', 0.5, 5, @IT_GOODS);
CALL InsertGood('Parafina', 1, 0.5, @IT_GOODS);
CALL InsertGood('Pé de cabra', 2, 2.5, @IT_GOODS);
CALL InsertGood('Pederneira e isqueiro', 1, 0, @IT_GOODS);
CALL InsertGood('Pergaminho (folha)', 0.2, 0, @IT_GOODS);
CALL InsertGood('Picareta de mina', 3, 5, @IT_GOODS);
CALL InsertGood('Píton', 0.1, 0.25, @IT_GOODS);
CALL InsertGood('Porta-mapas', 1, 0.25, @IT_CONVEY);
CALL InsertGood('Pote de cerâmica', 0.02, 2.5, @IT_CONVEY);
CALL InsertGood('Rações de viagem (por dia)', 0.5, 0.5, @IT_FOOD);
CALL InsertGood('Rede de pesca (5 x 5 m)', 4, 2.5, @IT_GOODS);
CALL InsertGood('Sabão (por kg)', 0.5, 0.5, @IT_GOODS);
CALL InsertGood('Saco (vazio)', 0.1, 0.25, @IT_CONVEY);
CALL InsertGood('Saco de dormir', 0.1, 2.5, @IT_GOODS);
CALL InsertGood('Sinete', 5, 0, @IT_GOODS);
CALL InsertGood('Sino', 1, 0, @IT_GOODS);
CALL InsertGood('Talha ou sisal', 5, 2.5, @IT_GOODS);
CALL InsertGood('Tenda', 10, 10, @IT_GOODS);
CALL InsertGood('Tinta (vidro de 30 ml)', 8, 0, @IT_GOODS);
CALL InsertGood('Tocha', 0.01, 0.5, @IT_GOODS);
CALL InsertGood('Vara (3 m)', 0.2, 4, @IT_GOODS);
CALL InsertGood('Vela', 0.01, 0, @IT_GOODS);
CALL InsertGood('Vidro para tinta ou poção', 1, 0.05, @IT_CONVEY);

CALL InsertGood('Ácido (frasco)', 10, 0.5, @IT_ALCHEM);
CALL InsertGood('Água benta (frasco)', 25, 0.5, @IT_ALCHEM);
CALL InsertGood('Antídoto (vidro)', 50, 0, @IT_ALCHEM);
CALL InsertGood('Bastão de fumaça', 20, 0.25, @IT_ALCHEM);
CALL InsertGood('Bastão solar', 2, 0.5, @IT_ALCHEM);
CALL InsertGood('Bolsa de cola', 50, 2, @IT_ALCHEM);
CALL InsertGood('Fogo alquímico (frasco)', 20, 0.5, @IT_ALCHEM);
CALL InsertGood('Fósforo', 1, 0, @IT_ALCHEM);
CALL InsertGood('Pedra trovão', 30, 0.5, @IT_ALCHEM);
CALL InsertGood('Tocha da chama eterna', 110, 0.5, @IT_GOODS);

CALL InsertGood('Ampulheta', 25, 0.5, @IT_TOOL);
CALL InsertGood('Azevinho e visco', 0, 0, @IT_TOOL);
CALL InsertGood('Balança de mercador', 2, 0.5, @IT_TOOL);
CALL InsertGood('Bolsa de componentes de magia', 5, 1, @IT_TOOL);
CALL InsertGood('Clepsidra', 1000, 100, @IT_TOOL);
CALL InsertGood('Ferramenta de artesão', 5, 2.5, @IT_TOOL);
CALL InsertGood('Ferramenta de artesão (obra-prima)', 55, 2.5, @IT_TOOL);
CALL InsertGood('Grimório de mago (em branco)', 15, 1.5, @IT_TOOL);
CALL InsertGood('Instrumento musical (comum)', 5, 1.5, @IT_TOOL);
CALL InsertGood('Instrumento musical (obra-prima)', 100, 1.5, @IT_TOOL);
CALL InsertGood('Instrumentos de ladrão', 30, 0.5, @IT_TOOL);
CALL InsertGood('Instrumentos de ladrão (obra-prima)', 100, 1, @IT_TOOL);
CALL InsertGood('Kit de disfarces', 50, 4, @IT_TOOL);
CALL InsertGood('Kit de escalada', 80, 2.5, @IT_TOOL);
CALL InsertGood('Kit de primeiros socorros', 50, 0.5, @IT_TOOL);
CALL InsertGood('Laboratório alquímico', 500, 20, @IT_TOOL);
CALL InsertGood('Lente de aumento', 100, 0, @IT_TOOL);
CALL InsertGood('Símbolo sagrado (madeira)', 1, 0, @IT_TOOL);
CALL InsertGood('Símbolo sagrado (prata)', 25, 0.5, @IT_TOOL);

CALL InsertGood('Traje de artesão', 1, 2, @IT_CLOTHI);
CALL InsertGood('Traje de clima frio', 8, 3.5, @IT_CLOTHI);
CALL InsertGood('Traje de corte', 30, 3, @IT_CLOTHI);
CALL InsertGood('Traje de entretenimento', 3, 2, @IT_CLOTHI);
CALL InsertGood('Traje de explorador', 10, 4, @IT_CLOTHI);
CALL InsertGood('Traje de monge', 5, 1, @IT_CLOTHI);
CALL InsertGood('Traje de nobre', 75, 5, @IT_CLOTHI);
CALL InsertGood('Traje de plebeu', 0.1, 1, @IT_CLOTHI);
CALL InsertGood('Traje de sábio', 5, 3, @IT_CLOTHI);
CALL InsertGood('Traje de viajante', 1, 2.5, @IT_CLOTHI);
CALL InsertGood('Traje real', 200, 7.5, @IT_CLOTHI);
CALL InsertGood('Vestimentas de clérigo', 5, 3, @IT_CLOTHI);

CALL InsertGood('Acomodação (Pobre)', 0.2, 0, @IT_FOOD);
CALL InsertGood('Acomodação (Padrão)', 0.5, 0, @IT_FOOD);
CALL InsertGood('Acomodação (Bom)', 2, 0, @IT_FOOD);
CALL InsertGood('Banquete (por pessoa)', 10, 0, @IT_FOOD);
CALL InsertGood('Carne (pedaço)', 0.3, 0.25, @IT_FOOD);
CALL InsertGood('Cerveja (Caneca)', 0.04, 0.5, @IT_FOOD);
CALL InsertGood('Cerveja (Jarra)', 0.2, 4, @IT_FOOD);
CALL InsertGood('Pão', 0.02, 0.25, @IT_FOOD);
CALL InsertGood('Queijo (pedaço)', 0.1, 0.25, @IT_FOOD);
CALL InsertGood('Refeição (Pobre)', 0.1, 0, @IT_FOOD);
CALL InsertGood('Refeição (Padrão)', 0.3, 0, @IT_FOOD);
CALL InsertGood('Refeição (Bom)', 0.5, 0, @IT_FOOD);
CALL InsertGood('Vinho (jarro)', 0.2, 0, @IT_FOOD);
CALL InsertGood('Vinho (garrafa fina)', 10, 0, @IT_FOOD);

CALL InsertGood('Alforje', 4, 4, @IT_CONVEY);
CALL InsertGood('Alimentação (por dia)', 0.05, 5, @IT_FOOD);
CALL InsertGood('Armadura de montaria', 0, 0, @IT_ARMOR);
CALL InsertGood('Cachorro de montaria', 150, 0, @IT_MOUNT);
CALL InsertGood('Cão de guarda', 25, 0, @IT_MOUNT);
CALL InsertGood('Cavalo de guerra leve', 150, 0, @IT_MOUNT);
CALL InsertGood('Cavalo de guerra pesado', 400, 0, @IT_MOUNT);
CALL InsertGood('Cavalo leve', 75, 0, @IT_MOUNT);
CALL InsertGood('Cavalo pesado', 200, 0, @IT_MOUNT);
CALL InsertGood('Pônei de guerra', 100, 0, @IT_MOUNT);
CALL InsertGood('Pônei', 30, 0, @IT_MOUNT);
CALL InsertGood('Jumento ou mula', 8, 0, @IT_MOUNT);

CALL InsertGood('Estábulo (por dia)', 0.5, 0, @IT_SERVIC);
CALL InsertGood('Freio e rédeas', 2, 0.5, @IT_GOODS);
CALL InsertGood('Sela (Carga)', 5, 7.5, @IT_GOODS);
CALL InsertGood('Sela (Militar)', 20, 15, @IT_GOODS);
CALL InsertGood('Sela (Montaria)', 10, 12.5, @IT_GOODS);
CALL InsertGood('Sela exótica (Carga)', 15, 10, @IT_GOODS);
CALL InsertGood('Sela exótica (Militar)', 60, 20, @IT_GOODS);
CALL InsertGood('Sela exótica (Montaria)', 30, 15, @IT_GOODS);

CALL InsertGood('Barco a remo', 50, 50, @IT_VEHICL);
CALL InsertGood('Remo', 2, 5, @IT_VEHICL);
CALL InsertGood('Barcaça', 3000, 0, @IT_VEHICL);
CALL InsertGood('Carroça', 35, 200, @IT_VEHICL);
CALL InsertGood('Carruagem', 100, 300, @IT_VEHICL);
CALL InsertGood('Charrete', 15, 100, @IT_VEHICL);
CALL InsertGood('Galeão', 30000, 0, @IT_VEHICL);
CALL InsertGood('Navio de guerra', 25000, 0, @IT_VEHICL);
CALL InsertGood('Navio', 10000, 0, @IT_VEHICL);
CALL InsertGood('Trenó', 20, 150, @IT_VEHICL);
CALL InsertGood('Veleiro', 10000, 0, @IT_VEHICL);

CALL InsertGood('Condução de carroça (por 1.5km)', 0.03, 0, @IT_SERVIC);
CALL InsertGood('Mensageiro (por 1.5km)', 0.02, 0, @IT_SERVIC);
CALL InsertGood('Passagem de navio (por 1.5km)', 0.1, 0, @IT_SERVIC);
CALL InsertGood('Trabalhador treinado (dia)', 0.3, 0, @IT_SERVIC);
CALL InsertGood('Trabalhador sem treinamento (dia)', 0.1, 0, @IT_SERVIC);
CALL InsertGood('Pedágio', 0.01, 0, @IT_SERVIC);

INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('vestindo-armadura', 'Equipment', 'Vestindo uma Armadura', 
'# Tabela 7-7: Vestindo uma Armadura
| Tipo de Armadura | Vestir | Vestir Rapidamente | Retirar |
|---|---|---|---|
| Escudo (qualquer) | 1 ação de movimento | 1 ação de movimento | 1 ação de movimento |
| Acolchoada, couro, gibão de peles, couro batido ou camisão de cota de malha | 1 minuto | 1 minuto | 1 minuto |
| Peitoral de aço, brunea, cota de malha, cota de talas ou loriga segmentada | 4 minutos | 4 minutos | 1 minuto |
| Meia-armadura ou armadura de batalha | 4 minutos | 1d4+1 minutos | 1d4+1 minutos |
*Se o personagem tiver auxílio, reduza o tempo à metade.*', 1);

INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('objetos-quebrar', 'Environment', 'Dureza e Pontos de Vida de Objetos',
'Consulte as regras de Quebrando Objetos para determinar a resistência de itens como algemas, cordas e portas.', 1);

SET FOREIGN_KEY_CHECKS = 1;

