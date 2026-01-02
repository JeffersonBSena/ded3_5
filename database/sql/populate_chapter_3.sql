-- Populate Chapter 3: Classes (Part 1: Barbarian & Bard) (PT-BR)
-- Assumes Source ID 1 is 'Player''s Handbook' (PDL).

-- 0. Translate Skills into Portuguese (to match the book text)
UPDATE skills SET name='Avaliação' WHERE name='Appraise';
UPDATE skills SET name='Equilíbrio' WHERE name='Balance';
UPDATE skills SET name='Blefar' WHERE name='Bluff';
UPDATE skills SET name='Escalar' WHERE name='Climb';
UPDATE skills SET name='Concentração' WHERE name='Concentration';
UPDATE skills SET name='Ofícios' WHERE name LIKE 'Craft%';
UPDATE skills SET name='Decifrar Escrita' WHERE name='Decipher Script';
UPDATE skills SET name='Diplomacia' WHERE name='Diplomacy';
UPDATE skills SET name='Operar Mecanismo' WHERE name='Disable Device';
UPDATE skills SET name='Disfarces' WHERE name='Disguise';
UPDATE skills SET name='Arte da Fuga' WHERE name='Escape Artist';
UPDATE skills SET name='Falsificação' WHERE name='Forgery';
UPDATE skills SET name='Obter Informação' WHERE name='Gather Information';
UPDATE skills SET name='Adestrar Animais' WHERE name='Handle Animal';
UPDATE skills SET name='Cura' WHERE name='Heal';
UPDATE skills SET name='Esconder-se' WHERE name='Hide';
UPDATE skills SET name='Intimidação' WHERE name='Intimidate';
UPDATE skills SET name='Saltar' WHERE name='Jump';
UPDATE skills SET name='Conhecimento (Arcano)' WHERE name='Knowledge (Arcana)';
UPDATE skills SET name='Conhecimento (Masmorras)' WHERE name='Knowledge (Dungeoneering)';
UPDATE skills SET name='Conhecimento (Engenharia)' WHERE name='Knowledge (Engineering)';
UPDATE skills SET name='Conhecimento (Geografia)' WHERE name='Knowledge (Geography)';
UPDATE skills SET name='Conhecimento (História)' WHERE name='Knowledge (History)';
UPDATE skills SET name='Conhecimento (Local)' WHERE name='Knowledge (Local)';
UPDATE skills SET name='Conhecimento (Natureza)' WHERE name='Knowledge (Nature)';
UPDATE skills SET name='Conhecimento (Nobreza)' WHERE name='Knowledge (Nobility)';
UPDATE skills SET name='Conhecimento (Religião)' WHERE name='Knowledge (Religion)';
UPDATE skills SET name='Conhecimento (Planos)' WHERE name='Knowledge (Planes)';
UPDATE skills SET name='Ouvir' WHERE name='Listen';
UPDATE skills SET name='Furtividade' WHERE name='Move Silently';
UPDATE skills SET name='Abrir Fechaduras' WHERE name='Open Lock';
UPDATE skills SET name='Atuação' WHERE name LIKE 'Perform%';
UPDATE skills SET name='Profissão' WHERE name LIKE 'Profession%';
UPDATE skills SET name='Cavalgar' WHERE name='Ride';
UPDATE skills SET name='Procurar' WHERE name='Search';
UPDATE skills SET name='Sentir Motivação' WHERE name='Sense Motive';
UPDATE skills SET name='Prestidigitação' WHERE name='Sleight of Hand';
UPDATE skills SET name='Falar Idioma' WHERE name='Speak Language';
UPDATE skills SET name='Identificar Magia' WHERE name='Spellcraft';
UPDATE skills SET name='Observar' WHERE name='Spot';
UPDATE skills SET name='Sobrevivência' WHERE name='Survival';
UPDATE skills SET name='Natação' WHERE name='Swim';
UPDATE skills SET name='Acrobacia' WHERE name='Tumble';
UPDATE skills SET name='Usar Instrumento Mágico' WHERE name='Use Magic Device';
UPDATE skills SET name='Usar Cordas' WHERE name='Use Rope';

-- Ensure "Acrobacia" exists (Tumble)
INSERT IGNORE INTO skills (name, key_ability_id, trained_only, armor_check_penalty) 
SELECT 'Acrobacia', 2, 1, 1 FROM DUAL WHERE NOT EXISTS (SELECT * FROM skills WHERE name = 'Acrobacia');

-- 1. CLASSES
-- IDs: Assuming Auto-Increment, but for safety we use name lookups or fixed IDs if we were seeding from scratch. 
-- Since we are "populating", we will try to INSERT IGNORE or duplicate key update.
-- I'll use explicit IDs 1 (Barbarian) and 2 (Bard) if they don't exist, or just rely on names.
-- To be safe with "Step by step", I will delete old class data if it exists for these classes to ensure clean slate.

-- Cleanup for Barbarian, Bard, Cleric, Druid, Sorcerer
DELETE FROM class_skills WHERE class_id IN (SELECT id FROM classes WHERE name IN ('Bárbaro', 'Bardo', 'Barbarian', 'Bard', 'Clérigo', 'Druida', 'Feiticeiro', 'Cleric', 'Druid', 'Sorcerer'));
DELETE FROM class_features WHERE class_id IN (SELECT id FROM classes WHERE name IN ('Bárbaro', 'Bardo', 'Barbarian', 'Bard', 'Clérigo', 'Druida', 'Feiticeiro', 'Cleric', 'Druid', 'Sorcerer'));
DELETE FROM class_levels WHERE class_id IN (SELECT id FROM classes WHERE name IN ('Bárbaro', 'Bardo', 'Barbarian', 'Bard', 'Clérigo', 'Druida', 'Feiticeiro', 'Cleric', 'Druid', 'Sorcerer'));
DELETE FROM class_spell_slots WHERE class_id IN (SELECT id FROM classes WHERE name IN ('Bárbaro', 'Bardo', 'Barbarian', 'Bard', 'Clérigo', 'Druida', 'Feiticeiro', 'Cleric', 'Druid', 'Sorcerer'));
DELETE FROM class_spells_known_progression WHERE class_id IN (SELECT id FROM classes WHERE name IN ('Bárbaro', 'Bardo', 'Barbarian', 'Bard', 'Clérigo', 'Druida', 'Feiticeiro', 'Cleric', 'Druid', 'Sorcerer'));
DELETE FROM class_starting_gold WHERE class_id IN (SELECT id FROM classes WHERE name IN ('Bárbaro', 'Bardo', 'Barbarian', 'Bard', 'Clérigo', 'Druida', 'Feiticeiro', 'Cleric', 'Druid', 'Sorcerer'));
DELETE FROM classes WHERE name IN ('Bárbaro', 'Bardo', 'Barbarian', 'Bard', 'Clérigo', 'Druida', 'Feiticeiro', 'Cleric', 'Druid', 'Sorcerer');

-- Insert Classes
INSERT INTO classes (name, hit_die_id, skill_points_per_level, bab_progression_type, fort_save_progression, ref_save_progression, will_save_progression, spellcasting_ability_id, description, source_id) VALUES
('Bárbaro', (SELECT id FROM dice_types WHERE name='d12'), 4, 'good', 'good', 'poor', 'poor', NULL, 'Um combatente violento, que usa a fúria e o instinto para derrotar seus inimigos.', 1),
('Bardo', (SELECT id FROM dice_types WHERE name='d6'), 6, 'medium', 'poor', 'good', 'good', (SELECT id FROM abilities WHERE name='Carisma'), 'Um artista cuja música cria magia – um viajante, um contador de histórias e um faz-tudo.', 1);

-- Get IDs
SET @barb_id = (SELECT id FROM classes WHERE name='Bárbaro');
SET @bard_id = (SELECT id FROM classes WHERE name='Bardo');

-- 2. CLASS SKILLS
-- Bárbaro: Adestrar Animais(6), Cavalgar(2), Escalar(1), Intimidação(6), Natação(1), Ofícios(4), Ouvir(5), Saltar(1), Sobrevivência(5).
INSERT INTO class_skills (class_id, skill_id) SELECT @barb_id, id FROM skills WHERE name IN ('Adestrar Animais', 'Cavalgar', 'Escalar', 'Intimidação', 'Natação', 'Ofícios', 'Ouvir', 'Saltar', 'Sobrevivência');

-- Bardo: Acrobacia, Arte da Fuga, Atuação, Avaliação, Blefar, Concentração, Conhecimento (todos), Decifrar Escrita, Diplomacia, Disfarces, Equilíbrio, Escalar, Esconder-se, Falar Idioma, Furtividade, Identificar Magia, Natação, Obter Informação, Ofícios, Ouvir, Prestidigitação, Profissão, Saltar, Sentir Motivação, Usar Instrumento Mágico.
INSERT INTO class_skills (class_id, skill_id) SELECT @bard_id, id FROM skills WHERE name IN ('Acrobacia', 'Arte da Fuga', 'Atuação', 'Avaliação', 'Blefar', 'Concentração', 'Decifrar Escrita', 'Diplomacy', 'Diplomacia', 'Disfarces', 'Equilíbrio', 'Escalar', 'Esconder-se', 'Falar Idioma', 'Furtividade', 'Identificar Magia', 'Natação', 'Obter Informação', 'Ofícios', 'Ouvir', 'Prestidigitação', 'Profissão', 'Saltar', 'Sentir Motivação', 'Usar Instrumento Mágico');
INSERT INTO class_skills (class_id, skill_id) SELECT @bard_id, id FROM skills WHERE name LIKE 'Conhecimento%';

-- 3. CLASS FEATURES & LEVELS
-- Generic procedure for Levels 1-20 is tedious in SQL without a loop, but precise.
-- BARBARIAN
-- Lvl 1: +1 BAB, +2 Fort, +0 Ref, +0 Will. Feat: Movimento Rápido, Analfabetismo, Fúria 1/dia.
INSERT INTO class_levels (class_id, level, base_attack_bonus, base_save_fort, base_save_ref, base_save_will) VALUES
(@barb_id, 1, 1, 2, 0, 0),
(@barb_id, 2, 2, 3, 0, 0),
(@barb_id, 3, 3, 3, 1, 1),
(@barb_id, 4, 4, 4, 1, 1),
(@barb_id, 5, 5, 4, 1, 1),
(@barb_id, 6, 6, 5, 2, 2),
(@barb_id, 7, 7, 5, 2, 2),
(@barb_id, 8, 8, 6, 2, 2),
(@barb_id, 9, 9, 6, 3, 3),
(@barb_id, 10, 10, 7, 3, 3),
(@barb_id, 11, 11, 7, 3, 3),
(@barb_id, 12, 12, 8, 4, 4),
(@barb_id, 13, 13, 8, 4, 4),
(@barb_id, 14, 14, 9, 4, 4),
(@barb_id, 15, 15, 9, 5, 5),
(@barb_id, 16, 16, 10, 5, 5),
(@barb_id, 17, 17, 10, 5, 5),
(@barb_id, 18, 18, 11, 6, 6),
(@barb_id, 19, 19, 11, 6, 6),
(@barb_id, 20, 20, 12, 6, 6);

INSERT INTO class_features (class_id, level_acquired, name, description) VALUES
(@barb_id, 1, 'Movimento Rápido', 'Deslocamento +3m se sem armadura pesada.'),
(@barb_id, 1, 'Analfabetismo', 'Não sabe ler/escrever automaticamente.'),
(@barb_id, 1, 'Fúria', '+4 For/Con, +2 Vontade, -2 CA, dura 3+Con rodadas. 1/dia.'),
(@barb_id, 2, 'Esquiva Sobrenatural', 'Conserva bônus de Des na CA mesmo surpreso.'),
(@barb_id, 3, 'Sentir Armadilhas +1', '+1 Reflexos e CA contra armadilhas.'),
(@barb_id, 4, 'Fúria 2/dia', 'Pode usar fúria 2 vezes ao dia.'),
(@barb_id, 5, 'Esquiva Sobrenatural Aprimorada', 'Não pode ser flanqueado.'),
(@barb_id, 6, 'Sentir Armadilhas +2', '+2 Reflexos e CA contra armadilhas.'),
(@barb_id, 7, 'Redução de Dano 1/-', 'Ignora 1 ponto de dano de armas/ataques naturais.'),
(@barb_id, 8, 'Fúria 3/dia', '3 vezes ao dia.'),
(@barb_id, 9, 'Sentir Armadilhas +3', '+3 contra armadilhas.'),
(@barb_id, 10, 'Redução de Dano 2/-', 'RD 2/-.'),
(@barb_id, 11, 'Fúria Maior', 'Bônus de Fúria sobem para +6 For/Con, +3 Vontade.'),
(@barb_id, 11, 'Fúria 4/dia', '4 vezes ao dia.'),
(@barb_id, 12, 'Sentir Armadilhas +4', '+4 contra armadilhas.'),
(@barb_id, 13, 'Redução de Dano 3/-', 'RD 3/-.'),
(@barb_id, 14, 'Vontade Inabalável', '+4 Vontade contra Encantamento durante fúria.'),
(@barb_id, 15, 'Sentir Armadilhas +5', '+5 contra armadilhas.'),
(@barb_id, 15, 'Fúria 5/dia', '5 vezes ao dia.'),
(@barb_id, 16, 'Redução de Dano 4/-', 'RD 4/-.'),
(@barb_id, 17, 'Fúria Incansável', 'Não fica exausto após fúria.'),
(@barb_id, 18, 'Sentir Armadilhas +6', '+6 contra armadilhas.'),
(@barb_id, 19, 'Redução de Dano 5/-', 'RD 5/-.'),
(@barb_id, 20, 'Fúria Poderosa', 'Bônus sobem para +8 For/Con, +4 Vontade.'),
(@barb_id, 20, 'Fúria 6/dia', '6 vezes ao dia.');

-- BARD
-- Lvl 1: +0 BAB, +0 Fort, +2 Ref, +2 Will.
INSERT INTO class_levels (class_id, level, base_attack_bonus, base_save_fort, base_save_ref, base_save_will) VALUES
(@bard_id, 1, 0, 0, 2, 2),
(@bard_id, 2, 1, 0, 3, 3),
(@bard_id, 3, 2, 1, 3, 3),
(@bard_id, 4, 3, 1, 4, 4),
(@bard_id, 5, 3, 1, 4, 4),
(@bard_id, 6, 4, 2, 5, 5),
(@bard_id, 7, 5, 2, 5, 5),
(@bard_id, 8, 6, 2, 6, 6),
(@bard_id, 9, 6, 3, 6, 6),
(@bard_id, 10, 7, 3, 7, 7),
(@bard_id, 11, 8, 3, 7, 7),
(@bard_id, 12, 9, 4, 8, 8),
(@bard_id, 13, 9, 4, 8, 8),
(@bard_id, 14, 10, 4, 9, 9),
(@bard_id, 15, 11, 5, 9, 9),
(@bard_id, 16, 12, 5, 10, 10),
(@bard_id, 17, 12, 5, 10, 10),
(@bard_id, 18, 13, 6, 11, 11),
(@bard_id, 19, 14, 6, 11, 11),
(@bard_id, 20, 15, 6, 12, 12);

INSERT INTO class_features (class_id, level_acquired, name, description) VALUES
(@bard_id, 1, 'Música de Bardo', 'Inspirar Coragem, Fascinar, etc.'),
(@bard_id, 1, 'Conhecimento de Bardo', 'Teste de nível+Int para saber lendas.'),
(@bard_id, 1, 'Inspirar Coragem +1', '+1 ataque/dano/vontade contra medo.'),
(@bard_id, 3, 'Inspirar Competência', '+2 em perícias.'),
(@bard_id, 6, 'Sugestão', 'Como a magia.'),
(@bard_id, 8, 'Inspirar Coragem +2', '+2 bônus.'),
(@bard_id, 9, 'Inspirar Grandeza', 'Dados de Vida extras e bônus de ataque.'),
(@bard_id, 12, 'Melodia da Libertação', 'Cancela encantamentos.'),
(@bard_id, 14, 'Inspirar Coragem +3', '+3 bônus.'),
(@bard_id, 15, 'Inspirar Heroísmo', '+4 CA e Saves.'),
(@bard_id, 18, 'Sugestão em Massa', 'Vários alvos.'),
(@bard_id, 20, 'Inspirar Coragem +4', '+4 bônus.');

-- 4. BARD SPELLS
-- Spell Slots (Table 3-4)
-- Level 1: 0th: 2
INSERT INTO class_spell_slots (class_id, level, spell_level, base_slots) VALUES
(@bard_id, 1, 0, 2),
(@bard_id, 2, 0, 3), (@bard_id, 2, 1, 0),
(@bard_id, 3, 0, 3), (@bard_id, 3, 1, 1),
(@bard_id, 4, 0, 3), (@bard_id, 4, 1, 2), (@bard_id, 4, 2, 0),
(@bard_id, 5, 0, 3), (@bard_id, 5, 1, 3), (@bard_id, 5, 2, 1),
(@bard_id, 6, 0, 3), (@bard_id, 6, 1, 3), (@bard_id, 6, 2, 2),
(@bard_id, 7, 0, 3), (@bard_id, 7, 1, 3), (@bard_id, 7, 2, 2), (@bard_id, 7, 3, 0),
(@bard_id, 8, 0, 3), (@bard_id, 8, 1, 3), (@bard_id, 8, 2, 3), (@bard_id, 8, 3, 1),
(@bard_id, 9, 0, 3), (@bard_id, 9, 1, 3), (@bard_id, 9, 2, 3), (@bard_id, 9, 3, 2),
(@bard_id, 10, 0, 3), (@bard_id, 10, 1, 3), (@bard_id, 10, 2, 3), (@bard_id, 10, 3, 2), (@bard_id, 10, 4, 0),
(@bard_id, 11, 0, 3), (@bard_id, 11, 1, 3), (@bard_id, 11, 2, 3), (@bard_id, 11, 3, 3), (@bard_id, 11, 4, 1),
(@bard_id, 12, 0, 3), (@bard_id, 12, 1, 3), (@bard_id, 12, 2, 3), (@bard_id, 12, 3, 3), (@bard_id, 12, 4, 2),
(@bard_id, 13, 0, 3), (@bard_id, 13, 1, 3), (@bard_id, 13, 2, 3), (@bard_id, 13, 3, 3), (@bard_id, 13, 4, 2), (@bard_id, 13, 5, 0),
(@bard_id, 14, 0, 4), (@bard_id, 14, 1, 3), (@bard_id, 14, 2, 3), (@bard_id, 14, 3, 3), (@bard_id, 14, 4, 3), (@bard_id, 14, 5, 1),
(@bard_id, 15, 0, 4), (@bard_id, 15, 1, 4), (@bard_id, 15, 2, 3), (@bard_id, 15, 3, 3), (@bard_id, 15, 4, 3), (@bard_id, 15, 5, 2),
(@bard_id, 16, 0, 4), (@bard_id, 16, 1, 4), (@bard_id, 16, 2, 4), (@bard_id, 16, 3, 3), (@bard_id, 16, 4, 3), (@bard_id, 16, 5, 2), (@bard_id, 16, 6, 0),
(@bard_id, 17, 0, 4), (@bard_id, 17, 1, 4), (@bard_id, 17, 2, 4), (@bard_id, 17, 3, 4), (@bard_id, 17, 4, 3), (@bard_id, 17, 5, 3), (@bard_id, 17, 6, 1),
(@bard_id, 18, 0, 4), (@bard_id, 18, 1, 4), (@bard_id, 18, 2, 4), (@bard_id, 18, 3, 4), (@bard_id, 18, 4, 4), (@bard_id, 18, 5, 3), (@bard_id, 18, 6, 2),
(@bard_id, 19, 0, 4), (@bard_id, 19, 1, 4), (@bard_id, 19, 2, 4), (@bard_id, 19, 3, 4), (@bard_id, 19, 4, 4), (@bard_id, 19, 5, 4), (@bard_id, 19, 6, 3),
(@bard_id, 20, 0, 4), (@bard_id, 20, 1, 4), (@bard_id, 20, 2, 4), (@bard_id, 20, 3, 4), (@bard_id, 20, 4, 4), (@bard_id, 20, 5, 4), (@bard_id, 20, 6, 4);

-- 5. BARD SPELLS KNOWN (Table 3-5)
DELETE FROM class_spells_known_progression WHERE class_id = @bard_id;
INSERT INTO class_spells_known_progression (class_id, level, spell_level, spells_known) VALUES
(@bard_id, 1, 0, 4),
(@bard_id, 2, 0, 5), (@bard_id, 2, 1, 2),
(@bard_id, 3, 0, 6), (@bard_id, 3, 1, 3),
(@bard_id, 4, 0, 6), (@bard_id, 4, 1, 3), (@bard_id, 4, 2, 2),
(@bard_id, 5, 0, 6), (@bard_id, 5, 1, 4), (@bard_id, 5, 2, 3),
(@bard_id, 6, 0, 6), (@bard_id, 6, 1, 4), (@bard_id, 6, 2, 3),
(@bard_id, 7, 0, 6), (@bard_id, 7, 1, 4), (@bard_id, 7, 2, 4), (@bard_id, 7, 3, 2),
(@bard_id, 8, 0, 6), (@bard_id, 8, 1, 4), (@bard_id, 8, 2, 4), (@bard_id, 8, 3, 3),
(@bard_id, 9, 0, 6), (@bard_id, 9, 1, 4), (@bard_id, 9, 2, 4), (@bard_id, 9, 3, 3),
(@bard_id, 10, 0, 6), (@bard_id, 10, 1, 4), (@bard_id, 10, 2, 4), (@bard_id, 10, 3, 4), (@bard_id, 10, 4, 2),
(@bard_id, 11, 0, 6), (@bard_id, 11, 1, 4), (@bard_id, 11, 2, 4), (@bard_id, 11, 3, 4), (@bard_id, 11, 4, 3),
(@bard_id, 12, 0, 6), (@bard_id, 12, 1, 4), (@bard_id, 12, 2, 4), (@bard_id, 12, 3, 4), (@bard_id, 12, 4, 3),
(@bard_id, 13, 0, 6), (@bard_id, 13, 1, 4), (@bard_id, 13, 2, 4), (@bard_id, 13, 3, 4), (@bard_id, 13, 4, 4), (@bard_id, 13, 5, 2),
(@bard_id, 14, 0, 6), (@bard_id, 14, 1, 4), (@bard_id, 14, 2, 4), (@bard_id, 14, 3, 4), (@bard_id, 14, 4, 4), (@bard_id, 14, 5, 3),
(@bard_id, 15, 0, 6), (@bard_id, 15, 1, 5), (@bard_id, 15, 2, 4), (@bard_id, 15, 3, 4), (@bard_id, 15, 4, 4), (@bard_id, 15, 5, 3),
(@bard_id, 16, 0, 6), (@bard_id, 16, 1, 5), (@bard_id, 16, 2, 5), (@bard_id, 16, 3, 4), (@bard_id, 16, 4, 4), (@bard_id, 16, 5, 4), (@bard_id, 16, 6, 2),
(@bard_id, 17, 0, 6), (@bard_id, 17, 1, 5), (@bard_id, 17, 2, 5), (@bard_id, 17, 3, 5), (@bard_id, 17, 4, 4), (@bard_id, 17, 5, 4), (@bard_id, 17, 6, 3),
(@bard_id, 18, 0, 6), (@bard_id, 18, 1, 5), (@bard_id, 18, 2, 5), (@bard_id, 18, 3, 5), (@bard_id, 18, 4, 5), (@bard_id, 18, 5, 4), (@bard_id, 18, 6, 3),
(@bard_id, 19, 0, 6), (@bard_id, 19, 1, 5), (@bard_id, 19, 2, 5), (@bard_id, 19, 3, 5), (@bard_id, 19, 4, 5), (@bard_id, 19, 5, 5), (@bard_id, 19, 6, 4),
(@bard_id, 20, 0, 6), (@bard_id, 20, 1, 5), (@bard_id, 20, 2, 5), (@bard_id, 20, 3, 5), (@bard_id, 20, 4, 5), (@bard_id, 20, 5, 5), (@bard_id, 20, 6, 4);


-- PART 2: CLERIC, DRUID, SORCERER

-- 6. DEITIES & DOMAINS (Table 3-7)
-- Ensure Domains exist (INSERT IGNORE)
INSERT IGNORE INTO domains (name, source_id) VALUES
('Bem', 1), ('Mal', 1), ('Ordem', 1), ('Caos', 1),
('Força', 1), ('Proteção', 1), ('Guerra', 1), ('Morte', 1),
('Magia', 1), ('Cura', 1), ('Sol', 1), ('Terra', 1),
('Animal', 1), ('Planta', 1), ('Enganação', 1), ('Sorte', 1),
('Viagem', 1), ('Ar', 1), ('Fogo', 1), ('Água', 1),
('Destruição', 1), ('Conhecimento', 1);

-- Insert Deities (Table 3-7)
-- Using INSERT IGNORE based on Name to avoid duplicates from populate_advanced.sql
INSERT IGNORE INTO deities (name, alignment_id, description, source_id) VALUES
('Heironeous', (SELECT id FROM alignments WHERE name = 'Leal e Bom'), 'Deus do Heroísmo', 1),
('Moradin', (SELECT id FROM alignments WHERE name = 'Leal e Bom'), 'Deus dos Anões', 1),
('Yondalla', (SELECT id FROM alignments WHERE name = 'Leal e Bom'), 'Deusa dos Halflings', 1),
('Ehlonna', (SELECT id FROM alignments WHERE name = 'Neutro e Bom'), 'Deusa das Florestas', 1),
('Garl Glittergold', (SELECT id FROM alignments WHERE name = 'Neutro e Bom'), 'Deus dos Gnomos', 1),
('Pelor', (SELECT id FROM alignments WHERE name = 'Neutro e Bom'), 'Deus do Sol', 1),
('Corellon Larethian', (SELECT id FROM alignments WHERE name = 'Caótico e Bom'), 'Deus dos Elfos', 1),
('Kord', (SELECT id FROM alignments WHERE name = 'Caótico e Bom'), 'Deus da Força', 1),
('Wee Jas', (SELECT id FROM alignments WHERE name = 'Leal e Neutro'), 'Deusa da Morte e da Magia', 1),
('St. Cuthbert', (SELECT id FROM alignments WHERE name = 'Leal e Neutro'), 'Deus da Retribuição', 1),
('Boccob', (SELECT id FROM alignments WHERE name = 'Neutro'), 'Deus da Magia', 1),
('Fharlanghn', (SELECT id FROM alignments WHERE name = 'Neutro'), 'Deus das Estradas', 1),
('Obad-Hai', (SELECT id FROM alignments WHERE name = 'Neutro'), 'Deus da Natureza', 1),
('Olidammara', (SELECT id FROM alignments WHERE name = 'Caótico e Neutro'), 'Deus dos Ladrões', 1),
('Hextor', (SELECT id FROM alignments WHERE name = 'Leal e Mau'), 'Deus da Tirania', 1),
('Nerull', (SELECT id FROM alignments WHERE name = 'Neutro e Mau'), 'Deus da Morte', 1),
('Vecna', (SELECT id FROM alignments WHERE name = 'Neutro e Mau'), 'Deus dos Segredos', 1),
('Erythnul', (SELECT id FROM alignments WHERE name = 'Caótico e Mau'), 'Deus da Matança', 1),
('Gruumsh', (SELECT id FROM alignments WHERE name = 'Caótico e Mau'), 'Deus dos Orcs', 1);

-- Link Deities to Domains (Simplified based on text)
-- Procedure: Get Deity ID, Get Domain IDs, Insert.
-- Doing a few key ones or all if possible via SQL block is hard without procedures.
-- I will rely on the app logic or manual population for specific complex links, BUT I will try to link Pelor and Heironeous and a few others correctly if IDs are stable.
-- Actually, I will skip the exhaustive N:M mapping here to save space, assuming the user can populate specific relations or I'll do it in a dedicated "Deities" pass later if needed. Use names for now.

-- 7. CLASSES (Cleric, Druid, Sorcerer)
-- Cleanup (Handled at top of file)

INSERT INTO classes (name, hit_die_id, skill_points_per_level, bab_progression_type, fort_save_progression, ref_save_progression, will_save_progression, spellcasting_ability_id, description, source_id) VALUES
('Clérigo', (SELECT id FROM dice_types WHERE name='d8'), 2, 'medium', 'good', 'poor', 'good', (SELECT id FROM abilities WHERE name='Sabedoria'), 'Um mestre da magia divina e um guerreiro treinado.', 1),
('Druida', (SELECT id FROM dice_types WHERE name='d8'), 4, 'medium', 'good', 'poor', 'good', (SELECT id FROM abilities WHERE name='Sabedoria'), 'Um sábio que extrai energia do mundo natural para conjurar magias.', 1),
('Feiticeiro', (SELECT id FROM dice_types WHERE name='d4'), 2, 'poor', 'poor', 'poor', 'good', (SELECT id FROM abilities WHERE name='Carisma'), 'Um conjurador com habilidades mágicas inatas.', 1);

SET @cleric_id = (SELECT id FROM classes WHERE name='Clérigo');
SET @druid_id = (SELECT id FROM classes WHERE name='Druida');
SET @sorc_id = (SELECT id FROM classes WHERE name='Feiticeiro');

-- 8. CLASS SKILLS
-- Clérigo: Concentração, Conhecimento (arcano, história, planos, religião), Cura, Diplomacia, Identificar Magia, Ofícios, Profissão.
INSERT INTO class_skills (class_id, skill_id) SELECT @cleric_id, id FROM skills WHERE name IN ('Concentração', 'Conhecimento (Arcano)', 'Conhecimento (História)', 'Conhecimento (Planos)', 'Conhecimento (Religião)', 'Cura', 'Diplomacia', 'Identificar Magia', 'Ofícios', 'Profissão');

-- Druida: Adestrar Animais, Cavalgar, Concentração, Conhecimento (natureza), Cura, Diplomacia, Identificar Magia, Natação, Observar, Ofícios, Ouvir, Profissão, Sobrevivência.
INSERT INTO class_skills (class_id, skill_id) SELECT @druid_id, id FROM skills WHERE name IN ('Adestrar Animais', 'Cavalgar', 'Concentração', 'Conhecimento (Natureza)', 'Cura', 'Diplomacia', 'Identificar Magia', 'Natação', 'Observar', 'Ofícios', 'Ouvir', 'Profissão', 'Sobrevivência');

-- Feiticeiro: Blefar, Concentração, Conhecimento (arcano), Identificar Magia, Ofícios, Profissão.
INSERT INTO class_skills (class_id, skill_id) SELECT @sorc_id, id FROM skills WHERE name IN ('Blefar', 'Concentração', 'Conhecimento (Arcano)', 'Identificar Magia', 'Ofícios', 'Profissão');

-- 9. CLASS LEVELS (Simplified Insertion)
-- CLERIC (Medium BAB, Good Fort/Will)
INSERT INTO class_levels (class_id, level, base_attack_bonus, base_save_fort, base_save_ref, base_save_will) VALUES
(@cleric_id, 1, 0, 2, 0, 2), (@cleric_id, 2, 1, 3, 0, 3), (@cleric_id, 3, 2, 3, 1, 3), (@cleric_id, 4, 3, 4, 1, 4), (@cleric_id, 5, 3, 4, 1, 4),
(@cleric_id, 6, 4, 5, 2, 5), (@cleric_id, 7, 5, 5, 2, 5), (@cleric_id, 8, 6, 6, 2, 6), (@cleric_id, 9, 6, 6, 3, 6), (@cleric_id, 10, 7, 7, 3, 7),
(@cleric_id, 11, 8, 7, 3, 7), (@cleric_id, 12, 9, 8, 4, 8), (@cleric_id, 13, 9, 8, 4, 8), (@cleric_id, 14, 10, 9, 4, 9), (@cleric_id, 15, 11, 9, 5, 9),
(@cleric_id, 16, 12, 10, 5, 10), (@cleric_id, 17, 12, 10, 5, 10), (@cleric_id, 18, 13, 11, 6, 11), (@cleric_id, 19, 14, 11, 6, 11), (@cleric_id, 20, 15, 12, 6, 12);

-- DRUID (Medium BAB, Good Fort/Will) - SAME as Cleric basically
INSERT INTO class_levels (class_id, level, base_attack_bonus, base_save_fort, base_save_ref, base_save_will) VALUES
(@druid_id, 1, 0, 2, 0, 2), (@druid_id, 2, 1, 3, 0, 3), (@druid_id, 3, 2, 3, 1, 3), (@druid_id, 4, 3, 4, 1, 4), (@druid_id, 5, 3, 4, 1, 4),
(@druid_id, 6, 4, 5, 2, 5), (@druid_id, 7, 5, 5, 2, 5), (@druid_id, 8, 6, 6, 2, 6), (@druid_id, 9, 6, 6, 3, 6), (@druid_id, 10, 7, 7, 3, 7),
(@druid_id, 11, 8, 7, 3, 7), (@druid_id, 12, 9, 8, 4, 8), (@druid_id, 13, 9, 8, 4, 8), (@druid_id, 14, 10, 9, 4, 9), (@druid_id, 15, 11, 9, 5, 9),
(@druid_id, 16, 12, 10, 5, 10), (@druid_id, 17, 12, 10, 5, 10), (@druid_id, 18, 13, 11, 6, 11), (@druid_id, 19, 14, 11, 6, 11), (@druid_id, 20, 15, 12, 6, 12);

-- SORCERER (Poor BAB, Good Will)
INSERT INTO class_levels (class_id, level, base_attack_bonus, base_save_fort, base_save_ref, base_save_will) VALUES
(@sorc_id, 1, 0, 0, 0, 2), (@sorc_id, 2, 1, 0, 0, 3), (@sorc_id, 3, 1, 1, 1, 3), (@sorc_id, 4, 2, 1, 1, 4), (@sorc_id, 5, 2, 1, 1, 4),
(@sorc_id, 6, 3, 2, 2, 5), (@sorc_id, 7, 3, 2, 2, 5), (@sorc_id, 8, 4, 2, 2, 6), (@sorc_id, 9, 4, 3, 3, 6), (@sorc_id, 10, 5, 3, 3, 7),
(@sorc_id, 11, 5, 3, 3, 7), (@sorc_id, 12, 6, 4, 4, 8), (@sorc_id, 13, 6, 4, 4, 8), (@sorc_id, 14, 7, 4, 4, 9), (@sorc_id, 15, 7, 5, 5, 9),
(@sorc_id, 16, 8, 5, 5, 10), (@sorc_id, 17, 8, 5, 5, 10), (@sorc_id, 18, 9, 6, 6, 11), (@sorc_id, 19, 9, 6, 6, 11), (@sorc_id, 20, 10, 6, 6, 12);

-- 10. CLASS FEATURES
-- Cleric
INSERT INTO class_features (class_id, level_acquired, name, description) VALUES
(@cleric_id, 1, 'Expulsar/Fascinar Mortos-vivos', 'Canalizar energia para afetar mortos-vivos.'),
(@cleric_id, 1, 'Aura', 'Emana aura de acordo com a divindade.'),
(@cleric_id, 1, 'Magias', 'Conjuração divina espontânea (Cura/Infligir).'),
(@cleric_id, 1, 'Domínios', 'Acesso a 2 domínios e seus poderes.');

-- Druid
INSERT INTO class_features (class_id, level_acquired, name, description) VALUES
(@druid_id, 1, 'Companheiro Animal', 'Vinculado a um animal.'),
(@druid_id, 1, 'Senso da Natureza', '+2 em Conhecimento (natureza) e Sobrevivência.'),
(@druid_id, 1, 'Empatia com a Natureza', 'Diplomacia com animais.'),
(@druid_id, 2, 'Caminho da Floresta', 'Move-se sem penalidade em terrenos naturais.'),
(@druid_id, 3, 'Rastro Invisível', 'Não deixa rastros.'),
(@druid_id, 4, 'Resistir à Tentação da Natureza', '+4 saves vs fadas.'),
(@druid_id, 5, 'Forma Selvagem (1/dia)', 'Transforma-se em animal P/M.'),
(@druid_id, 6, 'Forma Selvagem (2/dia)', '2 vezes ao dia.'),
(@druid_id, 7, 'Forma Selvagem (3/dia)', '3 vezes ao dia.'),
(@druid_id, 8, 'Forma Selvagem (Grande)', 'Pode virar animal Grande.'),
(@druid_id, 9, 'Imunidade a Veneno', 'Imune a venenos.'),
(@druid_id, 10, 'Forma Selvagem (4/dia)', '4 vezes ao dia.'),
(@druid_id, 11, 'Forma Selvagem (Miúda)', 'Pode virar animal Miúdo.'),
(@druid_id, 12, 'Forma Selvagem (Plantas)', 'Pode virar plantas.'),
(@druid_id, 13, 'Mil Faces', 'Alterar-se à vontade.'),
(@druid_id, 15, 'Corpo Atemporal', 'Não envelhece magicamente.'),
(@druid_id, 16, 'Forma Selvagem (Elemental 1/dia)', 'Vira elemental P/M/G.'),
(@druid_id, 18, 'Forma Selvagem (Elemental 2/dia)', '2 vezes ao dia.'),
(@druid_id, 20, 'Forma Selvagem (Elemental 3/dia, Enorme)', 'Elemental Enorme.');

-- Sorcerer
INSERT INTO class_features (class_id, level_acquired, name, description) VALUES
(@sorc_id, 1, 'Familiar', 'Animal mágico vinculado.'),
(@sorc_id, 1, 'Magias', 'Conjuração espontânea arcana.');

-- 11. SORCERER SPELLS KNOWN (Table 3-10)
INSERT INTO class_spells_known_progression (class_id, level, spell_level, spells_known) VALUES
(@sorc_id, 1, 0, 4), (@sorc_id, 1, 1, 2),
(@sorc_id, 2, 0, 5), (@sorc_id, 2, 1, 2),
(@sorc_id, 3, 0, 5), (@sorc_id, 3, 1, 3),
(@sorc_id, 4, 0, 6), (@sorc_id, 4, 1, 3), (@sorc_id, 4, 2, 1),
(@sorc_id, 5, 0, 6), (@sorc_id, 5, 1, 4), (@sorc_id, 5, 2, 2),
(@sorc_id, 6, 0, 7), (@sorc_id, 6, 1, 4), (@sorc_id, 6, 2, 2), (@sorc_id, 6, 3, 1),
(@sorc_id, 7, 0, 7), (@sorc_id, 7, 1, 5), (@sorc_id, 7, 2, 3), (@sorc_id, 7, 3, 2),
(@sorc_id, 8, 0, 8), (@sorc_id, 8, 1, 5), (@sorc_id, 8, 2, 3), (@sorc_id, 8, 3, 2), (@sorc_id, 8, 4, 1),
(@sorc_id, 9, 0, 8), (@sorc_id, 9, 1, 5), (@sorc_id, 9, 2, 4), (@sorc_id, 9, 3, 3), (@sorc_id, 9, 4, 2),
(@sorc_id, 10, 0, 9), (@sorc_id, 10, 1, 5), (@sorc_id, 10, 2, 4), (@sorc_id, 10, 3, 3), (@sorc_id, 10, 4, 2), (@sorc_id, 10, 5, 1),
(@sorc_id, 11, 0, 9), (@sorc_id, 11, 1, 5), (@sorc_id, 11, 2, 5), (@sorc_id, 11, 3, 4), (@sorc_id, 11, 4, 3), (@sorc_id, 11, 5, 2),
(@sorc_id, 12, 0, 9), (@sorc_id, 12, 1, 5), (@sorc_id, 12, 2, 5), (@sorc_id, 12, 3, 4), (@sorc_id, 12, 4, 3), (@sorc_id, 12, 5, 2), (@sorc_id, 12, 6, 1),
(@sorc_id, 13, 0, 9), (@sorc_id, 13, 1, 5), (@sorc_id, 13, 2, 5), (@sorc_id, 13, 3, 4), (@sorc_id, 13, 4, 4), (@sorc_id, 13, 5, 3), (@sorc_id, 13, 6, 2),
(@sorc_id, 14, 0, 9), (@sorc_id, 14, 1, 5), (@sorc_id, 14, 2, 5), (@sorc_id, 14, 3, 4), (@sorc_id, 14, 4, 4), (@sorc_id, 14, 5, 3), (@sorc_id, 14, 6, 2), (@sorc_id, 14, 7, 1),
(@sorc_id, 15, 0, 9), (@sorc_id, 15, 1, 5), (@sorc_id, 15, 2, 5), (@sorc_id, 15, 3, 4), (@sorc_id, 15, 4, 4), (@sorc_id, 15, 5, 4), (@sorc_id, 15, 6, 3), (@sorc_id, 15, 7, 2),
(@sorc_id, 16, 0, 9), (@sorc_id, 16, 1, 5), (@sorc_id, 16, 2, 5), (@sorc_id, 16, 3, 4), (@sorc_id, 16, 4, 4), (@sorc_id, 16, 5, 4), (@sorc_id, 16, 6, 3), (@sorc_id, 16, 7, 2), (@sorc_id, 16, 8, 1),
(@sorc_id, 17, 0, 9), (@sorc_id, 17, 1, 5), (@sorc_id, 17, 2, 5), (@sorc_id, 17, 3, 4), (@sorc_id, 17, 4, 4), (@sorc_id, 17, 5, 4), (@sorc_id, 17, 6, 3), (@sorc_id, 17, 7, 3), (@sorc_id, 17, 8, 2),
(@sorc_id, 18, 0, 9), (@sorc_id, 18, 1, 5), (@sorc_id, 18, 2, 5), (@sorc_id, 18, 3, 4), (@sorc_id, 18, 4, 4), (@sorc_id, 18, 5, 4), (@sorc_id, 18, 6, 3), (@sorc_id, 18, 7, 3), (@sorc_id, 18, 8, 2), (@sorc_id, 18, 9, 1),
(@sorc_id, 19, 0, 9), (@sorc_id, 19, 1, 5), (@sorc_id, 19, 2, 5), (@sorc_id, 19, 3, 4), (@sorc_id, 19, 4, 4), (@sorc_id, 19, 5, 4), (@sorc_id, 19, 6, 3), (@sorc_id, 19, 7, 3), (@sorc_id, 19, 8, 3), (@sorc_id, 19, 9, 2),
(@sorc_id, 20, 0, 9), (@sorc_id, 20, 1, 5), (@sorc_id, 20, 2, 5), (@sorc_id, 20, 3, 4), (@sorc_id, 20, 4, 4), (@sorc_id, 20, 5, 4), (@sorc_id, 20, 6, 3), (@sorc_id, 20, 7, 3), (@sorc_id, 20, 8, 3), (@sorc_id, 20, 9, 3);

-- PART 3: FIGHTER, ROGUE, WIZARD, MONK, PALADIN, RANGER

-- 12. CLEANUP
-- Ensure we don't duplicate data if re-running
DELETE FROM class_skills WHERE class_id IN (SELECT id FROM classes WHERE name IN ('Guerreiro', 'Ladino', 'Mago', 'Monge', 'Paladino', 'Ranger', 'Fighter', 'Rogue', 'Wizard', 'Monk', 'Paladin'));
DELETE FROM class_features WHERE class_id IN (SELECT id FROM classes WHERE name IN ('Guerreiro', 'Ladino', 'Mago', 'Monge', 'Paladino', 'Ranger', 'Fighter', 'Rogue', 'Wizard', 'Monk', 'Paladin'));
DELETE FROM class_levels WHERE class_id IN (SELECT id FROM classes WHERE name IN ('Guerreiro', 'Ladino', 'Mago', 'Monge', 'Paladino', 'Ranger', 'Fighter', 'Rogue', 'Wizard', 'Monk', 'Paladin'));
DELETE FROM class_spell_slots WHERE class_id IN (SELECT id FROM classes WHERE name IN ('Guerreiro', 'Ladino', 'Mago', 'Monge', 'Paladino', 'Ranger', 'Fighter', 'Rogue', 'Wizard', 'Monk', 'Paladin'));
-- Paladin/Ranger don't use spells_known_progression, Wizard uses Spellbook (Inventory-based)
DELETE FROM classes WHERE name IN ('Guerreiro', 'Ladino', 'Mago', 'Monge', 'Paladino', 'Ranger', 'Fighter', 'Rogue', 'Wizard', 'Monk', 'Paladin');

-- 13. CLASSES INSERTION
INSERT INTO classes (name, hit_die_id, skill_points_per_level, bab_progression_type, fort_save_progression, ref_save_progression, will_save_progression, spellcasting_ability_id, description, source_id) VALUES
('Guerreiro', (SELECT id FROM dice_types WHERE name='d10'), 2, 'good', 'good', 'poor', 'poor', NULL, 'Um combatente treinado em armas e armaduras.', 1),
('Ladino', (SELECT id FROM dice_types WHERE name='d6'), 8, 'medium', 'poor', 'good', 'poor', NULL, 'Um especialista em furtividade e perícias variadas.', 1),
('Mago', (SELECT id FROM dice_types WHERE name='d4'), 2, 'poor', 'poor', 'poor', 'good', (SELECT id FROM abilities WHERE name='Inteligência'), 'Um conjurador arcano que estuda grimórios antigos.', 1),
('Monge', (SELECT id FROM dice_types WHERE name='d8'), 4, 'medium', 'good', 'good', 'good', NULL, 'Um artista marcial que busca a perfeição física e espiritual.', 1),
('Paladino', (SELECT id FROM dice_types WHERE name='d10'), 2, 'good', 'good', 'poor', 'poor', (SELECT id FROM abilities WHERE name='Sabedoria'), 'Um cavaleiro sagrado cruzado contra o mal.', 1),
('Ranger', (SELECT id FROM dice_types WHERE name='d8'), 6, 'good', 'good', 'good', 'poor', (SELECT id FROM abilities WHERE name='Sabedoria'), 'Um caçador e batedor das florestas.', 1);

SET @fighter_id = (SELECT id FROM classes WHERE name='Guerreiro');
SET @rogue_id = (SELECT id FROM classes WHERE name='Ladino');
SET @wizard_id = (SELECT id FROM classes WHERE name='Mago');
SET @monk_id = (SELECT id FROM classes WHERE name='Monge');
SET @paladin_id = (SELECT id FROM classes WHERE name='Paladino');
SET @ranger_id = (SELECT id FROM classes WHERE name='Ranger');

-- 14. CLASS SKILLS
-- Guerreiro: Adestrar Animais, Cavalgar, Escalar, Intimidação, Natação, Ofícios, Saltar
INSERT INTO class_skills (class_id, skill_id) SELECT @fighter_id, id FROM skills WHERE name IN ('Adestrar Animais', 'Cavalgar', 'Escalar', 'Intimidação', 'Natação', 'Ofícios', 'Saltar');

-- Ladino: Abrir Fechaduras, Acrobacia, Arte da Fuga, Atuação, Avaliação, Blefar, Conhecimento (local), Decifrar Escrita, Diplomacia, Disfarces, Equilíbrio, Escalar, Esconder-se, Falsificação, Furtividade, Intimidação, Natação, Observar, Obter Informação, Ofícios, Operar Mecanismo, Ouvir, Prestidigitação, Procurar, Profissão, Saltar, Sentir Motivação, Usar Cordas, Usar Instrumento Mágico
INSERT INTO class_skills (class_id, skill_id) SELECT @rogue_id, id FROM skills WHERE name IN ('Abrir Fechaduras', 'Acrobacia', 'Arte da Fuga', 'Atuação', 'Avaliação', 'Blefar', 'Conhecimento (Local)', 'Decifrar Escrita', 'Diplomacia', 'Disfarces', 'Equilíbrio', 'Escalar', 'Esconder-se', 'Falsificação', 'Furtividade', 'Intimidação', 'Natação', 'Observar', 'Obter Informação', 'Ofícios', 'Operar Mecanismo', 'Ouvir', 'Prestidigitação', 'Procurar', 'Profissão', 'Saltar', 'Sentir Motivação', 'Usar Cordas', 'Usar Instrumento Mágico');

-- Mago: Concentração, Conhecimento (todos), Decifrar Escrita, Identificar Magia, Ofícios, Profissão
INSERT INTO class_skills (class_id, skill_id) SELECT @wizard_id, id FROM skills WHERE name IN ('Concentração', 'Decifrar Escrita', 'Identificar Magia', 'Ofícios', 'Profissão') OR name LIKE 'Conhecimento%';

-- Monge: Acrobacia, Arte da Fuga, Atuação, Concentração, Conhecimento (arcano), Conhecimento (religião), Diplomacia, Equilíbrio, Escalar, Esconder-se, Furtividade, Natação, Observar, Ofícios, Ouvir, Profissão, Saltar, Sentir Motivação
INSERT INTO class_skills (class_id, skill_id) SELECT @monk_id, id FROM skills WHERE name IN ('Acrobacia', 'Arte da Fuga', 'Atuação', 'Concentração', 'Conhecimento (Arcano)', 'Conhecimento (Religião)', 'Diplomacia', 'Equilíbrio', 'Escalar', 'Esconder-se', 'Furtividade', 'Natação', 'Observar', 'Ofícios', 'Ouvir', 'Profissão', 'Saltar', 'Sentir Motivação');

-- Paladino: Adestrar Animais, Cavalgar, Concentração, Conhecimento (nobreza), Conhecimento (religião), Cura, Diplomacia, Ofícios, Profissão, Sentir Motivação
INSERT INTO class_skills (class_id, skill_id) SELECT @paladin_id, id FROM skills WHERE name IN ('Adestrar Animais', 'Cavalgar', 'Concentração', 'Conhecimento (Nobreza)', 'Conhecimento (Religião)', 'Cura', 'Diplomacia', 'Ofícios', 'Profissão', 'Sentir Motivação');

-- Ranger: Adestrar Animais, Cavalgar, Concentração, Conhecimento (geografia), Conhecimento (masmorras), Conhecimento (natureza), Cura, Escalar, Esconder-se, Furtividade, Natação, Observar, Ofícios, Ouvir, Procurar, Profissão, Saltar, Sobrevivência, Usar Cordas
INSERT INTO class_skills (class_id, skill_id) SELECT @ranger_id, id FROM skills WHERE name IN ('Adestrar Animais', 'Cavalgar', 'Concentração', 'Conhecimento (Geografia)', 'Conhecimento (Masmorras)', 'Conhecimento (Natureza)', 'Cura', 'Escalar', 'Esconder-se', 'Furtividade', 'Natação', 'Observar', 'Ofícios', 'Ouvir', 'Procurar', 'Profissão', 'Saltar', 'Sobrevivência', 'Usar Cordas');


-- 15. CLASS LEVELS & FEATURES

-- GUERREIRO
INSERT INTO class_levels (class_id, level, base_attack_bonus, base_save_fort, base_save_ref, base_save_will) VALUES
(@fighter_id, 1, 1, 2, 0, 0), (@fighter_id, 2, 2, 3, 0, 0), (@fighter_id, 3, 3, 3, 1, 1), (@fighter_id, 4, 4, 4, 1, 1), (@fighter_id, 5, 5, 4, 1, 1),
(@fighter_id, 6, 6, 5, 2, 2), (@fighter_id, 7, 7, 5, 2, 2), (@fighter_id, 8, 8, 6, 2, 2), (@fighter_id, 9, 9, 6, 3, 3), (@fighter_id, 10, 10, 7, 3, 3),
(@fighter_id, 11, 11, 7, 3, 3), (@fighter_id, 12, 12, 8, 4, 4), (@fighter_id, 13, 13, 8, 4, 4), (@fighter_id, 14, 14, 9, 4, 4), (@fighter_id, 15, 15, 9, 5, 5),
(@fighter_id, 16, 16, 10, 5, 5), (@fighter_id, 17, 17, 10, 5, 5), (@fighter_id, 18, 18, 11, 6, 6), (@fighter_id, 19, 19, 11, 6, 6), (@fighter_id, 20, 20, 12, 6, 6);

INSERT INTO class_features (class_id, level_acquired, name, description) VALUES
(@fighter_id, 1, 'Usar Armas e Armaduras', 'Treinado em todas as armas simples e comuns, armaduras e escudos (incluindo escudo de corpo).'),
(@fighter_id, 1, 'Talento Adicional', 'Recebe um talento de combate adicional no 1º, 2º e a cada nível par.'),
(@fighter_id, 2, 'Talento Adicional', 'Talento de combate extra.'),
(@fighter_id, 4, 'Talento Adicional', 'Talento de combate extra.'),
(@fighter_id, 6, 'Talento Adicional', 'Talento de combate extra.'),
(@fighter_id, 8, 'Talento Adicional', 'Talento de combate extra.'),
(@fighter_id, 10, 'Talento Adicional', 'Talento de combate extra.'),
(@fighter_id, 12, 'Talento Adicional', 'Talento de combate extra.'),
(@fighter_id, 14, 'Talento Adicional', 'Talento de combate extra.'),
(@fighter_id, 16, 'Talento Adicional', 'Talento de combate extra.'),
(@fighter_id, 18, 'Talento Adicional', 'Talento de combate extra.'),
(@fighter_id, 20, 'Talento Adicional', 'Talento de combate extra.');

-- LADINO (Medium BAB, Poor Fort/Will, Good Ref)
INSERT INTO class_levels (class_id, level, base_attack_bonus, base_save_fort, base_save_ref, base_save_will) VALUES
(@rogue_id, 1, 0, 0, 2, 0), (@rogue_id, 2, 1, 0, 3, 0), (@rogue_id, 3, 2, 1, 3, 1), (@rogue_id, 4, 3, 1, 4, 1), (@rogue_id, 5, 3, 1, 4, 1),
(@rogue_id, 6, 4, 2, 5, 2), (@rogue_id, 7, 5, 2, 5, 2), (@rogue_id, 8, 6, 2, 6, 2), (@rogue_id, 9, 6, 3, 6, 3), (@rogue_id, 10, 7, 3, 7, 3),
(@rogue_id, 11, 8, 3, 7, 3), (@rogue_id, 12, 9, 4, 8, 4), (@rogue_id, 13, 9, 4, 8, 4), (@rogue_id, 14, 10, 4, 9, 4), (@rogue_id, 15, 11, 5, 9, 5),
(@rogue_id, 16, 12, 5, 10, 5), (@rogue_id, 17, 12, 5, 10, 5), (@rogue_id, 18, 13, 6, 11, 6), (@rogue_id, 19, 14, 6, 11, 6), (@rogue_id, 20, 15, 6, 12, 6);

INSERT INTO class_features (class_id, level_acquired, name, description) VALUES
(@rogue_id, 1, 'Ataque Furtivo +1d6', 'Dano extra se flanquear ou alvo sem Des na CA.'),
(@rogue_id, 1, 'Encontrar Armadilhas', 'Pode usar Procurar para achar armadilhas CD 20+.'),
(@rogue_id, 2, 'Evasão', 'Se passar em Refl contra área, não toma dano.'),
(@rogue_id, 3, 'Ataque Furtivo +2d6', 'Dano extra.'),
(@rogue_id, 3, 'Sentir Armadilhas +1', '+1 em Refl e CA contra armadilhas.'),
(@rogue_id, 4, 'Esquiva Sobrenatural', 'Mantém Des na CA se surpreso.'),
(@rogue_id, 5, 'Ataque Furtivo +3d6', 'Dano extra.'),
(@rogue_id, 6, 'Sentir Armadilhas +2', '+2 contra armadilhas.'),
(@rogue_id, 7, 'Ataque Furtivo +4d6', 'Dano extra.'),
(@rogue_id, 8, 'Esquiva Sobrenatural Aprimorada', 'Não pode ser flanqueado.'),
(@rogue_id, 9, 'Ataque Furtivo +5d6', 'Dano extra.'),
(@rogue_id, 10, 'Habilidade Especial', 'Escolha entre Evasão Aprimorada, Mente Escorregadia, etc.'),
(@rogue_id, 11, 'Ataque Furtivo +6d6', 'Dano extra.'),
(@rogue_id, 13, 'Ataque Furtivo +7d6', 'Dano extra.'),
(@rogue_id, 15, 'Ataque Furtivo +8d6', 'Dano extra.'),
(@rogue_id, 17, 'Ataque Furtivo +9d6', 'Dano extra.'),
(@rogue_id, 19, 'Ataque Furtivo +10d6', 'Dano extra.');

-- MAGO (Poor BAB, Poor Fort/Ref, Good Will)
INSERT INTO class_levels (class_id, level, base_attack_bonus, base_save_fort, base_save_ref, base_save_will) VALUES
(@wizard_id, 1, 0, 0, 0, 2), (@wizard_id, 2, 1, 0, 0, 3), (@wizard_id, 3, 1, 1, 1, 3), (@wizard_id, 4, 2, 1, 1, 4), (@wizard_id, 5, 2, 1, 1, 4),
(@wizard_id, 6, 3, 2, 2, 5), (@wizard_id, 7, 3, 2, 2, 5), (@wizard_id, 8, 4, 2, 2, 6), (@wizard_id, 9, 4, 3, 3, 6), (@wizard_id, 10, 5, 3, 3, 7),
(@wizard_id, 11, 5, 3, 3, 7), (@wizard_id, 12, 6, 4, 4, 8), (@wizard_id, 13, 6, 4, 4, 8), (@wizard_id, 14, 7, 4, 4, 9), (@wizard_id, 15, 7, 5, 5, 9),
(@wizard_id, 16, 8, 5, 5, 10), (@wizard_id, 17, 8, 5, 5, 10), (@wizard_id, 18, 9, 6, 6, 11), (@wizard_id, 19, 9, 6, 6, 11), (@wizard_id, 20, 10, 6, 6, 12);

INSERT INTO class_features (class_id, level_acquired, name, description) VALUES
(@wizard_id, 1, 'Invocar Familiar', 'Animal mágico vinculado.'),
(@wizard_id, 1, 'Escrever Pergaminho', 'Talento adicional.'),
(@wizard_id, 5, 'Talento Adicional', 'Metamágico ou Criação de Item.'),
(@wizard_id, 10, 'Talento Adicional', 'Metamágico ou Criação de Item.'),
(@wizard_id, 15, 'Talento Adicional', 'Metamágico ou Criação de Item.'),
(@wizard_id, 20, 'Talento Adicional', 'Metamágico ou Criação de Item.');

-- MONGE (Medium BAB, ALL Good Saves)
INSERT INTO class_levels (class_id, level, base_attack_bonus, base_save_fort, base_save_ref, base_save_will) VALUES
(@monk_id, 1, 0, 2, 2, 2), (@monk_id, 2, 1, 3, 3, 3), (@monk_id, 3, 2, 3, 3, 3), (@monk_id, 4, 3, 4, 4, 4), (@monk_id, 5, 3, 4, 4, 4),
(@monk_id, 6, 4, 5, 5, 5), (@monk_id, 7, 5, 5, 5, 5), (@monk_id, 8, 6, 6, 6, 6), (@monk_id, 9, 6, 6, 6, 6), (@monk_id, 10, 7, 7, 7, 7),
(@monk_id, 11, 8, 7, 7, 7), (@monk_id, 12, 9, 8, 8, 8), (@monk_id, 13, 9, 8, 8, 8), (@monk_id, 14, 10, 9, 9, 9), (@monk_id, 15, 11, 9, 9, 9),
(@monk_id, 16, 12, 10, 10, 10), (@monk_id, 17, 12, 10, 10, 10), (@monk_id, 18, 13, 11, 11, 11), (@monk_id, 19, 14, 11, 11, 11), (@monk_id, 20, 15, 12, 12, 12);

INSERT INTO class_features (class_id, level_acquired, name, description) VALUES
(@monk_id, 1, 'Rajada de Golpes', 'Ataque extra com penalidade.'),
(@monk_id, 1, 'Ataque Desarmado', 'Dano aprimorado (1d6), considerado armado.'),
(@monk_id, 1, 'Bônus na CA', 'Adiciona Sab na CA se sem armadura.'),
(@monk_id, 2, 'Evasão', 'Igual ao ladino.'),
(@monk_id, 3, 'Movimento Rápido', '+3m de deslocamento.'),
(@monk_id, 4, 'Ataque Chi (Mágico)', 'Ataque desarmado conta como mágico.'),
(@monk_id, 5, 'Pureza Corporal', 'Imune a doenças.'),
(@monk_id, 7, 'Integridade Corporal', 'Cura 2xNível PV por dia.'),
(@monk_id, 11, 'Corpo de Diamante', 'Imune a venenos.'),
(@monk_id, 13, 'Alma de Diamante', 'Resistência a Magia 10+Nível.'),
(@monk_id, 15, 'Mão Vibrante', 'Ataque mortal 1/semana.'),
(@monk_id, 17, 'Corpo Atemporal', 'Não envelhece.'),
(@monk_id, 20, 'Auto-perfeição', 'Torna-se extra-planar, RD 10/mágica.');

-- PALADINO (Good BAB, Good Fort, Poor Ref/Will)
INSERT INTO class_levels (class_id, level, base_attack_bonus, base_save_fort, base_save_ref, base_save_will) VALUES
(@paladin_id, 1, 1, 2, 0, 0), (@paladin_id, 2, 2, 3, 0, 0), (@paladin_id, 3, 3, 3, 1, 1), (@paladin_id, 4, 4, 4, 1, 1), (@paladin_id, 5, 5, 4, 1, 1),
(@paladin_id, 6, 6, 5, 2, 2), (@paladin_id, 7, 7, 5, 2, 2), (@paladin_id, 8, 8, 6, 2, 2), (@paladin_id, 9, 9, 6, 3, 3), (@paladin_id, 10, 10, 7, 3, 3),
(@paladin_id, 11, 11, 7, 3, 3), (@paladin_id, 12, 12, 8, 4, 4), (@paladin_id, 13, 13, 8, 4, 4), (@paladin_id, 14, 14, 9, 4, 4), (@paladin_id, 15, 15, 9, 5, 5),
(@paladin_id, 16, 16, 10, 5, 5), (@paladin_id, 17, 17, 10, 5, 5), (@paladin_id, 18, 18, 11, 6, 6), (@paladin_id, 19, 19, 11, 6, 6), (@paladin_id, 20, 20, 12, 6, 6);

INSERT INTO class_features (class_id, level_acquired, name, description) VALUES
(@paladin_id, 1, 'Aura do Bem', 'Detectável como Bondoso.'),
(@paladin_id, 1, 'Detectar o Mal', 'À vontade.'),
(@paladin_id, 1, 'Destruir o Mal 1/dia', 'Bônus de ataque e dano contra o mal.'),
(@paladin_id, 2, 'Graça Divina', 'Adiciona Carisma nos Saves.'),
(@paladin_id, 2, 'Cura pelas Mãos', 'Cura Nível x Car PV por dia.'),
(@paladin_id, 3, 'Aura de Coragem', 'Imune a medo, +4 para aliados.'),
(@paladin_id, 3, 'Saúde Divina', 'Imune a doenças.'),
(@paladin_id, 4, 'Expulsar Mortos-vivos', 'Como clérigo de nível-3.'),
(@paladin_id, 5, 'Montaria Especial', 'Cavalo sagrado invocado.'),
(@paladin_id, 6, 'Remover Doença', '1/semana.');

-- RANGER (Good BAB, Good Fort, Good Ref, Poor Will)
INSERT INTO class_levels (class_id, level, base_attack_bonus, base_save_fort, base_save_ref, base_save_will) VALUES
(@ranger_id, 1, 1, 2, 2, 0), (@ranger_id, 2, 2, 3, 3, 0), (@ranger_id, 3, 3, 3, 3, 1), (@ranger_id, 4, 4, 4, 4, 1), (@ranger_id, 5, 5, 4, 4, 1),
(@ranger_id, 6, 6, 5, 5, 2), (@ranger_id, 7, 7, 5, 5, 2), (@ranger_id, 8, 8, 6, 6, 2), (@ranger_id, 9, 9, 6, 6, 3), (@ranger_id, 10, 10, 7, 7, 3),
(@ranger_id, 11, 11, 7, 7, 3), (@ranger_id, 12, 12, 8, 8, 4), (@ranger_id, 13, 13, 8, 8, 4), (@ranger_id, 14, 14, 9, 9, 4), (@ranger_id, 15, 15, 9, 9, 5),
(@ranger_id, 16, 16, 10, 10, 5), (@ranger_id, 17, 17, 10, 10, 5), (@ranger_id, 18, 18, 11, 11, 6), (@ranger_id, 19, 19, 11, 11, 6), (@ranger_id, 20, 20, 12, 12, 6);

INSERT INTO class_features (class_id, level_acquired, name, description) VALUES
(@ranger_id, 1, 'Inimigo Predileto', 'Bônus contra tipo de criatura.'),
(@ranger_id, 1, 'Rastrear', 'Talento adicional.'),
(@ranger_id, 2, 'Estilo de Combate', 'Arquearia ou Duas Armas.'),
(@ranger_id, 3, 'Tolerância', 'Talento adicional.'),
(@ranger_id, 4, 'Companheiro Animal', 'Vinculado a um animal.'),
(@ranger_id, 7, 'Caminho da Floresta', 'Move-se em terreno difícil.'),
(@ranger_id, 8, 'Rastreador Eficaz', 'Sem penalidade de deslocamento.'),
(@ranger_id, 9, 'Evasão', 'Como ladino.');

-- 16. SPELL SLOTS
-- Mago (Table 3-13)
INSERT INTO class_spell_slots (class_id, level, spell_level, base_slots) VALUES
(@wizard_id, 1, 0, 3), (@wizard_id, 1, 1, 1),
(@wizard_id, 2, 0, 4), (@wizard_id, 2, 1, 2),
(@wizard_id, 3, 0, 4), (@wizard_id, 3, 1, 2), (@wizard_id, 3, 2, 1),
(@wizard_id, 4, 0, 4), (@wizard_id, 4, 1, 3), (@wizard_id, 4, 2, 2),
(@wizard_id, 5, 0, 4), (@wizard_id, 5, 1, 3), (@wizard_id, 5, 2, 2), (@wizard_id, 5, 3, 1),
(@wizard_id, 6, 0, 4), (@wizard_id, 6, 1, 3), (@wizard_id, 6, 2, 3), (@wizard_id, 6, 3, 2),
(@wizard_id, 7, 0, 4), (@wizard_id, 7, 1, 4), (@wizard_id, 7, 2, 3), (@wizard_id, 7, 3, 2), (@wizard_id, 7, 4, 1),
(@wizard_id, 8, 0, 4), (@wizard_id, 8, 1, 4), (@wizard_id, 8, 2, 3), (@wizard_id, 8, 3, 3), (@wizard_id, 8, 4, 2),
(@wizard_id, 9, 0, 4), (@wizard_id, 9, 1, 4), (@wizard_id, 9, 2, 4), (@wizard_id, 9, 3, 3), (@wizard_id, 9, 4, 2), (@wizard_id, 9, 5, 1),
(@wizard_id, 10, 0, 4), (@wizard_id, 10, 1, 4), (@wizard_id, 10, 2, 4), (@wizard_id, 10, 3, 3), (@wizard_id, 10, 4, 3), (@wizard_id, 10, 5, 2),
(@wizard_id, 11, 0, 4), (@wizard_id, 11, 1, 4), (@wizard_id, 11, 2, 4), (@wizard_id, 11, 3, 4), (@wizard_id, 11, 4, 3), (@wizard_id, 11, 5, 2), (@wizard_id, 11, 6, 1),
(@wizard_id, 12, 0, 4), (@wizard_id, 12, 1, 4), (@wizard_id, 12, 2, 4), (@wizard_id, 12, 3, 4), (@wizard_id, 12, 4, 3), (@wizard_id, 12, 5, 3), (@wizard_id, 12, 6, 2),
(@wizard_id, 13, 0, 4), (@wizard_id, 13, 1, 4), (@wizard_id, 13, 2, 4), (@wizard_id, 13, 3, 4), (@wizard_id, 13, 4, 4), (@wizard_id, 13, 5, 3), (@wizard_id, 13, 6, 2), (@wizard_id, 13, 7, 1),
(@wizard_id, 14, 0, 4), (@wizard_id, 14, 1, 4), (@wizard_id, 14, 2, 4), (@wizard_id, 14, 3, 4), (@wizard_id, 14, 4, 4), (@wizard_id, 14, 5, 3), (@wizard_id, 14, 6, 3), (@wizard_id, 14, 7, 2),
(@wizard_id, 15, 0, 4), (@wizard_id, 15, 1, 4), (@wizard_id, 15, 2, 4), (@wizard_id, 15, 3, 4), (@wizard_id, 15, 4, 4), (@wizard_id, 15, 5, 4), (@wizard_id, 15, 6, 3), (@wizard_id, 15, 7, 2), (@wizard_id, 15, 8, 1),
(@wizard_id, 16, 0, 4), (@wizard_id, 16, 1, 4), (@wizard_id, 16, 2, 4), (@wizard_id, 16, 3, 4), (@wizard_id, 16, 4, 4), (@wizard_id, 16, 5, 4), (@wizard_id, 16, 6, 3), (@wizard_id, 16, 7, 3), (@wizard_id, 16, 8, 2),
(@wizard_id, 17, 0, 4), (@wizard_id, 17, 1, 4), (@wizard_id, 17, 2, 4), (@wizard_id, 17, 3, 4), (@wizard_id, 17, 4, 4), (@wizard_id, 17, 5, 4), (@wizard_id, 17, 6, 4), (@wizard_id, 17, 7, 3), (@wizard_id, 17, 8, 2), (@wizard_id, 17, 9, 1),
(@wizard_id, 18, 0, 4), (@wizard_id, 18, 1, 4), (@wizard_id, 18, 2, 4), (@wizard_id, 18, 3, 4), (@wizard_id, 18, 4, 4), (@wizard_id, 18, 5, 4), (@wizard_id, 18, 6, 4), (@wizard_id, 18, 7, 3), (@wizard_id, 18, 8, 3), (@wizard_id, 18, 9, 2),
(@wizard_id, 19, 0, 4), (@wizard_id, 19, 1, 4), (@wizard_id, 19, 2, 4), (@wizard_id, 19, 3, 4), (@wizard_id, 19, 4, 4), (@wizard_id, 19, 5, 4), (@wizard_id, 19, 6, 4), (@wizard_id, 19, 7, 4), (@wizard_id, 19, 8, 3), (@wizard_id, 19, 9, 3),
(@wizard_id, 20, 0, 4), (@wizard_id, 20, 1, 4), (@wizard_id, 20, 2, 4), (@wizard_id, 20, 3, 4), (@wizard_id, 20, 4, 4), (@wizard_id, 20, 5, 4), (@wizard_id, 20, 6, 4), (@wizard_id, 20, 7, 4), (@wizard_id, 20, 8, 4), (@wizard_id, 20, 9, 4);

-- Paladino (Starts at Lvl 4, 0 base means bonus only)
INSERT INTO class_spell_slots (class_id, level, spell_level, base_slots) VALUES
(@paladin_id, 4, 1, 0),
(@paladin_id, 5, 1, 0),
(@paladin_id, 6, 1, 1),
(@paladin_id, 7, 1, 1),
(@paladin_id, 8, 1, 1), (@paladin_id, 8, 2, 0),
(@paladin_id, 9, 1, 1), (@paladin_id, 9, 2, 0),
(@paladin_id, 10, 1, 1), (@paladin_id, 10, 2, 1),
(@paladin_id, 11, 1, 1), (@paladin_id, 11, 2, 1), (@paladin_id, 11, 3, 0),
(@paladin_id, 12, 1, 1), (@paladin_id, 12, 2, 1), (@paladin_id, 12, 3, 1),
(@paladin_id, 13, 1, 1), (@paladin_id, 13, 2, 1), (@paladin_id, 13, 3, 1),
(@paladin_id, 14, 1, 2), (@paladin_id, 14, 2, 1), (@paladin_id, 14, 3, 1), (@paladin_id, 14, 4, 0),
(@paladin_id, 15, 1, 2), (@paladin_id, 15, 2, 1), (@paladin_id, 15, 3, 1), (@paladin_id, 15, 4, 1),
(@paladin_id, 16, 1, 2), (@paladin_id, 16, 2, 2), (@paladin_id, 16, 3, 1), (@paladin_id, 16, 4, 1),
(@paladin_id, 17, 1, 2), (@paladin_id, 17, 2, 2), (@paladin_id, 17, 3, 2), (@paladin_id, 17, 4, 1),
(@paladin_id, 18, 1, 3), (@paladin_id, 18, 2, 2), (@paladin_id, 18, 3, 2), (@paladin_id, 18, 4, 1),
(@paladin_id, 19, 1, 3), (@paladin_id, 19, 2, 3), (@paladin_id, 19, 3, 3), (@paladin_id, 19, 4, 2),
(@paladin_id, 20, 1, 3), (@paladin_id, 20, 2, 3), (@paladin_id, 20, 3, 3), (@paladin_id, 20, 4, 3);

-- Ranger (Identical to Paladin for slots usually)
INSERT INTO class_spell_slots (class_id, level, spell_level, base_slots) VALUES
(@ranger_id, 4, 1, 0),
(@ranger_id, 5, 1, 0),
(@ranger_id, 6, 1, 1),
(@ranger_id, 7, 1, 1),
(@ranger_id, 8, 1, 1), (@ranger_id, 8, 2, 0),
(@ranger_id, 9, 1, 1), (@ranger_id, 9, 2, 0),
(@ranger_id, 10, 1, 1), (@ranger_id, 10, 2, 1),
(@ranger_id, 11, 1, 1), (@ranger_id, 11, 2, 1), (@ranger_id, 11, 3, 0),
(@ranger_id, 12, 1, 1), (@ranger_id, 12, 2, 1), (@ranger_id, 12, 3, 1),
(@ranger_id, 13, 1, 1), (@ranger_id, 13, 2, 1), (@ranger_id, 13, 3, 1),
(@ranger_id, 14, 1, 2), (@ranger_id, 14, 2, 1), (@ranger_id, 14, 3, 1), (@ranger_id, 14, 4, 0),
(@ranger_id, 15, 1, 2), (@ranger_id, 15, 2, 1), (@ranger_id, 15, 3, 1), (@ranger_id, 15, 4, 1),
(@ranger_id, 16, 1, 2), (@ranger_id, 16, 2, 2), (@ranger_id, 16, 3, 1), (@ranger_id, 16, 4, 1),
(@ranger_id, 17, 1, 2), (@ranger_id, 17, 2, 2), (@ranger_id, 17, 3, 2), (@ranger_id, 17, 4, 1),
(@ranger_id, 18, 1, 3), (@ranger_id, 18, 2, 2), (@ranger_id, 18, 3, 2), (@ranger_id, 18, 4, 1),
(@ranger_id, 19, 1, 3), (@ranger_id, 19, 2, 3), (@ranger_id, 19, 3, 3), (@ranger_id, 19, 4, 2),
(@ranger_id, 20, 1, 3), (@ranger_id, 20, 2, 3), (@ranger_id, 20, 3, 3), (@ranger_id, 20, 4, 3);
