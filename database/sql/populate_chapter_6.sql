
-- POPULATE CHAPTER 6: DESCRIPTION
-- Covers: Alignments, Vital Statistics (Age, Height, Weight), and Religion (Deities).

-- ==========================================
-- 0. SCHEMA EXTENSIONS (Vital Statistics)
-- ==========================================

CREATE TABLE IF NOT EXISTS race_aging (
    id INT AUTO_INCREMENT PRIMARY KEY,
    race_id INT NOT NULL,
    adulthood INT NOT NULL,
    middle_age INT NOT NULL,
    old_age INT NOT NULL,
    venerable INT NOT NULL,
    max_age_dice VARCHAR(20) NOT NULL,
    FOREIGN KEY (race_id) REFERENCES races(id)
);

CREATE TABLE IF NOT EXISTS random_height_weight (
    id INT AUTO_INCREMENT PRIMARY KEY,
    race_id INT NOT NULL,
    gender ENUM('Male', 'Female') NOT NULL,
    base_height_cm INT NOT NULL,
    height_modifier_dice VARCHAR(20) NOT NULL,
    height_multiplier_cm FLOAT DEFAULT 2.5,
    base_weight_kg INT NOT NULL,
    weight_modifier_dice VARCHAR(20) NOT NULL,
    weight_multiplier_kg FLOAT DEFAULT 0.5,
    FOREIGN KEY (race_id) REFERENCES races(id)
);

CREATE TABLE IF NOT EXISTS class_starting_ages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,
    dice_roll VARCHAR(20) NOT NULL,
    FOREIGN KEY (class_id) REFERENCES classes(id)
);

-- Clean up previous duplicates in Domains/Deities if they exist
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE deity_domains;
TRUNCATE TABLE deities;
 TRUNCATE TABLE domains; -- Reset domains to avoid duplicates
SET FOREIGN_KEY_CHECKS = 1;

-- ==========================================
-- 1. ALIGNMENTS (Update Descriptions)
-- ==========================================

UPDATE alignments SET description = 'Leal e Bom (LB), "Cruzado": Combina honra e compaixão. Diz a verdade, mantém a palavra, ajuda os necessitados e combate o mal. Ex: Alhandra, a paladina.' WHERE abbreviation = 'LG';
UPDATE alignments SET description = 'Neutro e Bom (NB), "Benfeitor": Faz o melhor que uma pessoa boa pode fazer. Ajuda os outros sem se sentir obrigado por leis. Ex: Jozan, o clérigo.' WHERE abbreviation = 'NG';
UPDATE alignments SET description = 'Caótico e Bom (CB), "Rebelde": Segue o próprio coração. Benevolente mas independente. Detesta intimidação. Ex: Soveliss, o ranger.' WHERE abbreviation = 'CG';
UPDATE alignments SET description = 'Leal e Neutro (LN), "Juiz": Guiado pela lei, tradição ou código pessoal. Ordem é primordial. Confiável mas não fanático. Ex: Ember, a monja.' WHERE abbreviation = 'LN';
UPDATE alignments SET description = 'Neutro (N), "Indeciso": Evita extremos. Faz o que parece boa ideia. Pode buscar o equilíbrio (Druidas). Ex: Mialee, a maga.' WHERE abbreviation = 'N';
UPDATE alignments SET description = 'Caótico e Neutro (CN), "Espírito Livre": Segue apenas sua vontade. Valoriza liberdade acima de tudo. Imprevisível. Ex: Gimble, o bardo.' WHERE abbreviation = 'CN';
UPDATE alignments SET description = 'Leal e Mau (LM), "Dominador": Mal metódico e intencional. Usa o sistema/regras para ganho pessoal, sem compaixão. Ex: Barão conspirador.' WHERE abbreviation = 'LE';
UPDATE alignments SET description = 'Neutro e Mau (NM), "Malfeitor": Mal puro. Faz o que for preciso para sair impune. Egoísta e sem remorso. Ex: Criminoso.' WHERE abbreviation = 'NE';
UPDATE alignments SET description = 'Caótico e Mau (CM), "Destruidor": Destruição da beleza, vida e ordem. Violento, cruel e imprevisível. Ex: Feiticeiro louco.' WHERE abbreviation = 'CE';

-- ==========================================
-- 2. RELIGION (Domains & Deities)
-- ==========================================

-- Insert Domains (Unique)
INSERT INTO domains (name) VALUES 
('Ar'), ('Animal'), ('Caos'), ('Morte'), ('Destruição'), 
('Terra'), ('Mal'), ('Fogo'), ('Bem'), ('Cura'), 
('Conhecimento'), ('Ordem'), ('Sorte'), ('Magia'), 
('Planta'), ('Proteção'), ('Força'), ('Sol'), 
('Viagem'), ('Enganação'), ('Guerra'), ('Água');

-- Helper Variables for Domains
SET @DOM_AIR = (SELECT id FROM domains WHERE name = 'Ar');
SET @DOM_ANIMAL = (SELECT id FROM domains WHERE name = 'Animal');
SET @DOM_CHAOS = (SELECT id FROM domains WHERE name = 'Caos');
SET @DOM_DEATH = (SELECT id FROM domains WHERE name = 'Morte');
SET @DOM_DESTR = (SELECT id FROM domains WHERE name = 'Destruição');
SET @DOM_EARTH = (SELECT id FROM domains WHERE name = 'Terra');
SET @DOM_EVIL = (SELECT id FROM domains WHERE name = 'Mal');
SET @DOM_FIRE = (SELECT id FROM domains WHERE name = 'Fogo');
SET @DOM_GOOD = (SELECT id FROM domains WHERE name = 'Bem');
SET @DOM_HEAL = (SELECT id FROM domains WHERE name = 'Cura');
SET @DOM_KNOW = (SELECT id FROM domains WHERE name = 'Conhecimento');
SET @DOM_LAW = (SELECT id FROM domains WHERE name = 'Ordem');
SET @DOM_LUCK = (SELECT id FROM domains WHERE name = 'Sorte');
SET @DOM_MAGIC = (SELECT id FROM domains WHERE name = 'Magia');
SET @DOM_PLANT = (SELECT id FROM domains WHERE name = 'Planta');
SET @DOM_PROT = (SELECT id FROM domains WHERE name = 'Proteção');
SET @DOM_STR = (SELECT id FROM domains WHERE name = 'Força');
SET @DOM_SUN = (SELECT id FROM domains WHERE name = 'Sol');
SET @DOM_TRAVEL = (SELECT id FROM domains WHERE name = 'Viagem');
SET @DOM_TRICK = (SELECT id FROM domains WHERE name = 'Enganação');
SET @DOM_WAR = (SELECT id FROM domains WHERE name = 'Guerra');
SET @DOM_WATER = (SELECT id FROM domains WHERE name = 'Água');

-- Helper Variables for Alignments
SET @LG = (SELECT id FROM alignments WHERE abbreviation = 'LG');
SET @NG = (SELECT id FROM alignments WHERE abbreviation = 'NG');
SET @CG = (SELECT id FROM alignments WHERE abbreviation = 'CG');
SET @LN = (SELECT id FROM alignments WHERE abbreviation = 'LN');
SET @NN = (SELECT id FROM alignments WHERE abbreviation = 'N');
SET @CN = (SELECT id FROM alignments WHERE abbreviation = 'CN');
SET @LE = (SELECT id FROM alignments WHERE abbreviation = 'LE');
SET @NE = (SELECT id FROM alignments WHERE abbreviation = 'NE');
SET @CE = (SELECT id FROM alignments WHERE abbreviation = 'CE');

-- Insert Deities & Map Domains
-- Boccob (N)
INSERT INTO deities (name, alignment_id, description, favored_weapon_id) VALUES ('Boccob', @NN, 'O Distraído, Lorde de Todas as Magias. Deus da magia e conhecimento.', NULL); -- Weapon: Bordão (Quarterstaff)
SET @D_BOC = LAST_INSERT_ID();
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@D_BOC, @DOM_KNOW), (@D_BOC, @DOM_MAGIC), (@D_BOC, @DOM_TRICK);

-- Corellon Larethian (CG)
INSERT INTO deities (name, alignment_id, description, favored_weapon_id) VALUES ('Corellon Larethian', @CG, 'Criador dos Elfos. Deus da magia, artes, guerra e elfos.', NULL); -- Weapon: Espada Longa (Longsword)
SET @D_COR = LAST_INSERT_ID();
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@D_COR, @DOM_CHAOS), (@D_COR, @DOM_GOOD), (@D_COR, @DOM_PROT), (@D_COR, @DOM_WAR);

-- Ehlonna (NG)
INSERT INTO deities (name, alignment_id, description, favored_weapon_id) VALUES ('Ehlonna', @NG, 'Ehlonna das Florestas. Deusa das florestas, flora e fauna.', NULL); -- Weapon: Arco Longo (Longbow)
SET @D_EHL = LAST_INSERT_ID();
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@D_EHL, @DOM_ANIMAL), (@D_EHL, @DOM_GOOD), (@D_EHL, @DOM_PLANT), (@D_EHL, @DOM_SUN);

-- Erythnul (CE)
INSERT INTO deities (name, alignment_id, description, favored_weapon_id) VALUES ('Erythnul', @CE, 'O Diverso. Deus da matança, pânico e carnificina.', NULL); -- Weapon: Maça-Estrela (Morningstar)
SET @D_ERY = LAST_INSERT_ID();
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@D_ERY, @DOM_CHAOS), (@D_ERY, @DOM_EVIL), (@D_ERY, @DOM_TRICK), (@D_ERY, @DOM_WAR);

-- Fharlanghn (N)
INSERT INTO deities (name, alignment_id, description, favored_weapon_id) VALUES ('Fharlanghn', @NN, 'O Morador do Horizonte. Deus das estradas e viagens.', NULL); -- Weapon: Bordão
SET @D_FHA = LAST_INSERT_ID();
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@D_FHA, @DOM_LUCK), (@D_FHA, @DOM_PROT), (@D_FHA, @DOM_TRAVEL);

-- Garl Glittergold (NG)
INSERT INTO deities (name, alignment_id, description, favored_weapon_id) VALUES ('Garl Glittergold', @NG, 'O Brincalhão. Deus dos gnomos, humor e lapidação.', NULL); -- Weapon: Machado de Batalha (Battleaxe)
SET @D_GAR = LAST_INSERT_ID();
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@D_GAR, @DOM_GOOD), (@D_GAR, @DOM_PROT), (@D_GAR, @DOM_TRICK);

-- Gruumsh (CE)
INSERT INTO deities (name, alignment_id, description, favored_weapon_id) VALUES ('Gruumsh', @CE, 'O Caolho. Deus dos orcs, força e conquista.', NULL); -- Weapon: Lança (Spear/Longspear? Uses "Lança")
SET @D_GRU = LAST_INSERT_ID();
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@D_GRU, @DOM_CHAOS), (@D_GRU, @DOM_EVIL), (@D_GRU, @DOM_STR), (@D_GRU, @DOM_WAR);

-- Heironeous (LG)
INSERT INTO deities (name, alignment_id, description, favored_weapon_id) VALUES ('Heironeous', @LG, 'O Invencível. Deus do heroísmo, justiça e honra.', NULL); -- Weapon: Espada Longa
SET @D_HEI = LAST_INSERT_ID();
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@D_HEI, @DOM_GOOD), (@D_HEI, @DOM_LAW), (@D_HEI, @DOM_WAR);

-- Hextor (LE)
INSERT INTO deities (name, alignment_id, description, favored_weapon_id) VALUES ('Hextor', @LE, 'O Campeão do Mal. Deus da tirania, guerra e discórdia.', NULL); -- Weapon: Mangual (Flail)
SET @D_HEX = LAST_INSERT_ID();
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@D_HEX, @DOM_DESTR), (@D_HEX, @DOM_EVIL), (@D_HEX, @DOM_LAW), (@D_HEX, @DOM_WAR);

-- Kord (CG)
INSERT INTO deities (name, alignment_id, description, favored_weapon_id) VALUES ('Kord', @CG, 'O Lutador. Deus da força e atletismo.', NULL); -- Weapon: Espada Larga (Greatsword)
SET @D_KOR = LAST_INSERT_ID();
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@D_KOR, @DOM_CHAOS), (@D_KOR, @DOM_GOOD), (@D_KOR, @DOM_LUCK), (@D_KOR, @DOM_STR);

-- Moradin (LG)
INSERT INTO deities (name, alignment_id, description, favored_weapon_id) VALUES ('Moradin', @LG, 'O Forjador de Almas. Deus dos anões, forja e engenharia.', NULL); -- Weapon: Martelo de Guerra
SET @D_MOR = LAST_INSERT_ID();
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@D_MOR, @DOM_EARTH), (@D_MOR, @DOM_GOOD), (@D_MOR, @DOM_LAW), (@D_MOR, @DOM_PROT);

-- Nerull (NE)
INSERT INTO deities (name, alignment_id, description, favored_weapon_id) VALUES ('Nerull', @NE, 'O Inimigo do Bem. Deus da morte e escuridão.', NULL); -- Weapon: Foice (Scythe)
SET @D_NER = LAST_INSERT_ID();
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@D_NER, @DOM_DEATH), (@D_NER, @DOM_EVIL), (@D_NER, @DOM_TRICK);

-- Obad-Hai (N)
INSERT INTO deities (name, alignment_id, description, favored_weapon_id) VALUES ('Obad-Hai', @NN, 'A Flauta do Pastor. Deus da natureza.', NULL); -- Weapon: Bordão
SET @D_OBA = LAST_INSERT_ID();
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@D_OBA, @DOM_AIR), (@D_OBA, @DOM_ANIMAL), (@D_OBA, @DOM_EARTH), (@D_OBA, @DOM_FIRE), (@D_OBA, @DOM_PLANT), (@D_OBA, @DOM_WATER);

-- Olidammara (CN)
INSERT INTO deities (name, alignment_id, description, favored_weapon_id) VALUES ('Olidammara', @CN, 'O Ladino Sorridente. Deus dos ladinos, música e vinho.', NULL); -- Weapon: Sabre (Rapier)
SET @D_OLI = LAST_INSERT_ID();
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@D_OLI, @DOM_CHAOS), (@D_OLI, @DOM_LUCK), (@D_OLI, @DOM_TRICK);

-- Pelor (NG)
INSERT INTO deities (name, alignment_id, description, favored_weapon_id) VALUES ('Pelor', @NG, 'O Radiante. Deus do sol, cura e força.', NULL); -- Weapon: Maça
SET @D_PEL = LAST_INSERT_ID();
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@D_PEL, @DOM_GOOD), (@D_PEL, @DOM_HEAL), (@D_PEL, @DOM_STR), (@D_PEL, @DOM_SUN);

-- St. Cuthbert (LN)
INSERT INTO deities (name, alignment_id, description, favored_weapon_id) VALUES ('St. Cuthbert', @LN, 'St. Cuthbert da Maça. Deus da retribuição e bom senso.', NULL); -- Weapon: Maça
SET @D_STC = LAST_INSERT_ID();
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@D_STC, @DOM_DESTR), (@D_STC, @DOM_LAW), (@D_STC, @DOM_PROT), (@D_STC, @DOM_STR);

-- Vecna (NE)
INSERT INTO deities (name, alignment_id, description, favored_weapon_id) VALUES ('Vecna', @NE, 'O Mestre de Todos os Segredos. Deus dos segredos e magia maligna.', NULL); -- Weapon: Adaga
SET @D_VEC = LAST_INSERT_ID();
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@D_VEC, @DOM_EVIL), (@D_VEC, @DOM_KNOW), (@D_VEC, @DOM_MAGIC);

-- Wee Jas (LN)
INSERT INTO deities (name, alignment_id, description, favored_weapon_id) VALUES ('Wee Jas', @LN, 'A Deusa Bruxa. Deusa da morte e magia.', NULL); -- Weapon: Adaga
SET @D_WEE = LAST_INSERT_ID();
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@D_WEE, @DOM_DEATH), (@D_WEE, @DOM_LAW), (@D_WEE, @DOM_MAGIC);

-- Yondalla (LG)
INSERT INTO deities (name, alignment_id, description, favored_weapon_id) VALUES ('Yondalla', @LG, 'A Protetora e Provedora. Deusa dos halflings e harmonia.', NULL); -- Weapon: Espada Curta
SET @D_YON = LAST_INSERT_ID();
INSERT INTO deity_domains (deity_id, domain_id) VALUES (@D_YON, @DOM_GOOD), (@D_YON, @DOM_LAW), (@D_YON, @DOM_PROT);


-- ==========================================
-- 3. VITAL STATISTICS (Tables 6-4, 6-5, 6-6)
-- ==========================================

-- Helper Variables for Classes
SET @C_BARB = (SELECT id FROM classes WHERE name = 'Bárbaro');
SET @C_BARD = (SELECT id FROM classes WHERE name = 'Bardo');
SET @C_CLER = (SELECT id FROM classes WHERE name = 'Clérigo');
SET @C_DRUI = (SELECT id FROM classes WHERE name = 'Druida');
SET @C_FIGH = (SELECT id FROM classes WHERE name = 'Guerreiro');
SET @C_MONK = (SELECT id FROM classes WHERE name = 'Monge');
SET @C_PALA = (SELECT id FROM classes WHERE name = 'Paladino');
SET @C_RANG = (SELECT id FROM classes WHERE name = 'Ranger');
SET @C_ROGU = (SELECT id FROM classes WHERE name = 'Ladino');
SET @C_SORC = (SELECT id FROM classes WHERE name = 'Feiticeiro');
SET @C_WIZA = (SELECT id FROM classes WHERE name = 'Mago');

-- Random Starting Age (Tabela 6-4)
-- Bárbaro, Ladino, Feiticeiro: +1d4
INSERT INTO class_starting_ages (class_id, dice_roll) VALUES
(@C_BARB, '1d4'), (@C_ROGU, '1d4'), (@C_SORC, '1d4');

-- Bardo, Guerreiro, Paladino, Ranger: +1d6
INSERT INTO class_starting_ages (class_id, dice_roll) VALUES
(@C_BARD, '1d6'), (@C_FIGH, '1d6'), (@C_PALA, '1d6'), (@C_RANG, '1d6');

-- Clérigo, Druida, Monge, Mago: +2d6
INSERT INTO class_starting_ages (class_id, dice_roll) VALUES
(@C_CLER, '2d6'), (@C_DRUI, '2d6'), (@C_MONK, '2d6'), (@C_WIZA, '2d6');


-- Aging Effects (Tabela 6-5)
SET @R_HUM = (SELECT id FROM races WHERE name = 'Humano');
SET @R_DWA = (SELECT id FROM races WHERE name = 'Anão');
SET @R_ELF = (SELECT id FROM races WHERE name = 'Elfo');
SET @R_GNO = (SELECT id FROM races WHERE name = 'Gnomo');
SET @R_HEL = (SELECT id FROM races WHERE name = 'Meio-Elfo');
SET @R_HOR = (SELECT id FROM races WHERE name = 'Meio-Orc');
SET @R_HAL = (SELECT id FROM races WHERE name = 'Halfling');

INSERT INTO race_aging (race_id, adulthood, middle_age, old_age, venerable, max_age_dice) VALUES
(@R_HUM, 15, 35, 53, 70, '2d20'),
(@R_DWA, 40, 125, 188, 250, '2d100'), -- 2d%
(@R_ELF, 110, 175, 263, 350, '4d100'), -- 4d%
(@R_GNO, 40, 100, 150, 200, '3d100'), -- 3d%
(@R_HEL, 20, 62, 93, 125, '3d20'),
(@R_HOR, 14, 30, 45, 60, '2d10'),
(@R_HAL, 20, 50, 75, 100, '5d20');


-- Height and Weight (Tabela 6-6)
INSERT INTO random_height_weight (race_id, gender, base_height_cm, height_modifier_dice, base_weight_kg, weight_modifier_dice, weight_multiplier_kg) VALUES
-- Humano
(@R_HUM, 'Male', 160, '2d10', 60, '2d4', 0.5), -- Wait, table lists Humano/Humana separately for Base, but Modifiers interact.
-- The table lists "Humano" (Man) and "Humana" (Woman).
(@R_HUM, 'Female', 145, '2d10', 42, '2d4', 0.5),

-- Anão
(@R_DWA, 'Male', 125, '2d4', 65, '2d6', 0.5),
(@R_DWA, 'Female', 120, '2d4', 50, '2d6', 0.5),

-- Elfo
(@R_ELF, 'Male', 145, '2d6', 42, '1d6', 0.5),
(@R_ELF, 'Female', 145, '2d6', 40, '1d6', 0.5),

-- Gnomo
(@R_GNO, 'Male', 90, '2d4', 20, '1d1', 0.5), -- "x 0,5 kg" implies modifier is 1? No, "x (1 x 0,5)"? The table says "Peso Modificador: x 0,5 kg" for Gnomo. Usually this means multiply the height mod by 1. Wait.
-- Table says: "x 0,5 kg" in "Modificador de Peso". But typically it multiplies the result of the Height Roll.
-- Actually the table has a specific formula.
-- Gnomo Mod Peso: "x 0,5 kg". This usually means 1 * HeightRoll.
-- Let's assume weight_modifier_dice is '1' (constant) or the logic is implied. I'll put '1' here.
(@R_GNO, 'Female', 85, '2d4', 17, '1', 0.5),

-- Meio-Elfo
(@R_HEL, 'Male', 155, '2d8', 50, '2d4', 0.5),
(@R_HEL, 'Female', 145, '2d8', 40, '2d4', 0.5),

-- Meio-Orc
(@R_HOR, 'Male', 165, '2d10', 65, '2d4', 0.5),
(@R_HOR, 'Female', 145, '2d10', 45, '2d4', 0.5),

-- Halfling
(@R_HAL, 'Male', 80, '2d4', 15, '1', 0.5),
(@R_HAL, 'Female', 75, '2d4', 12, '1', 0.5);

