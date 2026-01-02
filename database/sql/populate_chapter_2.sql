-- Populate Chapter 2: Races (PT-BR)
-- Based on the provided text.
-- Assumes Source ID 1 is 'Player''s Handbook' (PDL).

-- 0. Ensure Languages exist (Updating/Inserting based on text)
INSERT INTO languages (name, alphabet, description) VALUES
('Abissal', 'Infernal', 'Linguagem dos demônios e seres caóticos maus.'),
('Celestial', 'Celestial', 'Linguagem dos seres celestiais.'),
('Infernal', 'Infernal', 'Linguagem dos diabos e seres leais maus.'),
('Silvestre', 'Élfico', 'Linguagem das criaturas da floresta (dríades, pixies).'),
('Subterrâneo', 'Élfico', 'Linguagem dos drows e criaturas do subterrâneo. (Undercommon)'),
('Terran', 'Anão', 'Linguagem das criaturas da terra (Xorn, Elementais).'),
('Aquan', 'Élfico', 'Linguagem das criaturas aquáticas.')
ON DUPLICATE KEY UPDATE description=VALUES(description);

-- 1. RACES INSERTION
-- IDs: 1=Humano, 2=Anão, 3=Elfo, 4=Gnomo, 5=Meio-Elfo, 6=Meio-Orc, 7=Halfling

INSERT INTO races (id, name, size_id, base_speed, level_adjustment, description, source_id) VALUES
(1, 'Humano', 5, 30, 0, 'A raça humana é a mais adaptável, flexível e ambiciosa dentre todas as raças comuns.', 1),
(2, 'Anão', 5, 20, 0, 'Famosos por sua eficiência militar, resistência e habilidade com pedras e metais.', 1),
(3, 'Elfo', 5, 30, 0, 'Conhecidos pela poesia, dança, magia e liberdade. Vivem em harmonia com a natureza.', 1),
(4, 'Gnomo', 4, 20, 0, 'Técnicos, alquimistas e inventores que adoram piadas e gemas.', 1),
(5, 'Meio-Elfo', 5, 30, 0, 'Híbridos que combinam a curiosidade humana com os sentidos refinados dos elfos.', 1),
(6, 'Meio-Orc', 5, 30, 0, 'Criaturas tenazes e fortes, descendentes de humanos e orcs.', 1),
(7, 'Halfling', 4, 20, 0, 'Pequenos, ágeis e oportunistas, capazes de se adaptar a qualquer lugar.', 1)
ON DUPLICATE KEY UPDATE name=VALUES(name), description=VALUES(description);

-- 2. ABILITY ADJUSTMENTS (Tabela 2-1)
DELETE FROM race_ability_adjustments; -- Reset to ensure matching Table 2-1

-- Humano: Nenhum
-- Anão: +2 Con (3), -2 Car (6)
INSERT INTO race_ability_adjustments (race_id, ability_id, adjustment) VALUES (2, 3, 2), (2, 6, -2);
-- Elfo: +2 Des (2), -2 Con (3)
INSERT INTO race_ability_adjustments (race_id, ability_id, adjustment) VALUES (3, 2, 2), (3, 3, -2);
-- Gnomo: +2 Con (3), -2 For (1)
INSERT INTO race_ability_adjustments (race_id, ability_id, adjustment) VALUES (4, 3, 2), (4, 1, -2);
-- Meio-Elfo: Nenhum
-- Meio-Orc: +2 For (1), -2 Int (4), -2 Car (6)
INSERT INTO race_ability_adjustments (race_id, ability_id, adjustment) VALUES (6, 1, 2), (6, 4, -2), (6, 6, -2);
-- Halfling: +2 Des (2), -2 For (1)
INSERT INTO race_ability_adjustments (race_id, ability_id, adjustment) VALUES (7, 2, 2), (7, 1, -2);

-- 3. FAVORED CLASSES
-- Need to get Class IDs. Assuming standard ID order from populate_classes or inserting logic.
-- Since this is "Step by Step", I'll set them assuming class names exist or will serve as placeholders.
-- Actually table requires INT. I will use subqueries to be safe.

UPDATE races SET favored_class_id = (SELECT id FROM classes WHERE name = 'Guerreiro') WHERE id = 2; -- Anão
UPDATE races SET favored_class_id = (SELECT id FROM classes WHERE name = 'Mago') WHERE id = 3; -- Elfo
UPDATE races SET favored_class_id = (SELECT id FROM classes WHERE name = 'Bardo') WHERE id = 4; -- Gnomo
UPDATE races SET favored_class_id = (SELECT id FROM classes WHERE name = 'Bárbaro') WHERE id = 6; -- Meio-Orc
UPDATE races SET favored_class_id = (SELECT id FROM classes WHERE name = 'Ladino') WHERE id = 7; -- Halfling
-- Humano (1) e Meio-Elfo (5) = Qualquer (NULL)

-- 4. RACIAL TRAITS
DELETE FROM racial_traits;

-- HUMANO
INSERT INTO racial_traits (race_id, name, description) VALUES
(1, 'Talento Adicional', 'Recebem um talento adicional no 1° nível.'),
(1, 'Perícia Adicional', '4 pontos de perícia adicionais no 1° nível e 1 por nível subsequente.');

-- ANÃO
INSERT INTO racial_traits (race_id, name, description) VALUES
(2, 'Deslocamento sem Restrição', 'Podem percorrer seu deslocamento básico mesmo com armaduras médias/pesadas ou carga média/pesada.'),
(2, 'Visão no Escuro', '18 metros.'),
(2, 'Ligação com Pedras', '+2 em Procurar para trabalhos em pedra incomuns. Intuem profundidade.'),
(2, 'Familiaridade com Armas', 'Machado de guerra anão e urgrosh anão são armas comuns.'),
(2, 'Estabilidade', '+4 contra encontrão ou imobilização quando em pé no chão firme.'),
(2, 'Resistência a Veneno', '+2 racial nos testes de resistência contra venenos.'),
(2, 'Resistência a Magia', '+2 racial nos testes de resistência contra magias.'),
(2, 'Treinamento de Combate (Orcs/Goblins)', '+1 ataque contra orcs e goblinóides.'),
(2, 'Treinamento Defensivo (Gigantes)', '+4 esquiva na CA contra gigantes.'),
(2, 'Avaliação de Pedras/Metais', '+2 em Avaliação de objetos de pedra e metal.'),
(2, 'Ofícios com Pedras/Metais', '+2 em Ofícios com pedras e metais.');

-- ELFO
INSERT INTO racial_traits (race_id, name, description) VALUES
(3, 'Imunidade a Sono', 'Imune a magias e efeitos de sono.'),
(3, 'Resistência a Encantamento', '+2 em resistência contra magias de Encantamento.'),
(3, 'Visão na Penumbra', 'Enxergam o dobro dos humanos sob iluminação precária.'),
(3, 'Usar Armas', 'Sabem usar espada longa, sabre, arco longo e curto (e compostos).'),
(3, 'Sentidos Aguçados', '+2 Ouvir, Procurar e Observar. Busca ativa automática a 1,5m de portas secretas.');

-- GNOMO
INSERT INTO racial_traits (race_id, name, description) VALUES
(4, 'Pequeno', '+1 CA/Ataque, +4 Esconder-se, Carga 3/4, Armas menores.'),
(4, 'Visão na Penumbra', 'Enxergam o dobro dos humanos sob iluminação precária.'),
(4, 'Familiaridade com Armas', 'Martelo gnomo com gancho é arma comum.'),
(4, 'Resistência a Ilusão', '+2 em resistência contra ilusões.'),
(4, 'CD de Ilusão', '+1 na CD de magias de ilusão conjuradas pelo gnomo.'),
(4, 'Treinamento de Combate (Kobolds/Goblins)', '+1 ataque contra kobolds e goblinóides.'),
(4, 'Treinamento Defensivo (Gigantes)', '+4 esquiva na CA contra gigantes.'),
(4, 'Audição Aguçada', '+2 Ouvir.'),
(4, 'Olfato Alquímico', '+2 Ofícios (Alquimia).'),
(4, 'Falar com Animais', '1/dia (mamíferos terrestres, 1 min).'),
(4, 'Habilidades Similares a Magia', '1/dia: globos de luz, som fantasma, prestidigitação (se Carisma >= 10).');

-- MEIO-ELFO
INSERT INTO racial_traits (race_id, name, description) VALUES
(5, 'Imunidade a Sono', 'Imune a magias e efeitos de sono.'),
(5, 'Resistência a Encantamento', '+2 em resistência contra magias de Encantamento.'),
(5, 'Visão na Penumbra', 'Enxergam o dobro dos humanos sob iluminação precária.'),
(5, 'Sentidos Aguçados', '+1 Ouvir, Procurar e Observar.'),
(5, 'Sociabilidade', '+2 Diplomacia e Obter Informação.'),
(5, 'Sangue Élfico', 'Considerado elfo para todos os efeitos.');

-- MEIO-ORC
INSERT INTO racial_traits (race_id, name, description) VALUES
(6, 'Visão no Escuro', '18 metros.'),
(6, 'Sangue Orc', 'Considerado orc para todos os efeitos.');

-- HALFLING
INSERT INTO racial_traits (race_id, name, description) VALUES
(7, 'Pequeno', '+1 CA/Ataque, +4 Esconder-se, Carga 3/4, Armas menores.'),
(7, 'Atlético', '+2 Escalar, Saltar e Movimentação Silenciosa.'),
(7, 'Sorte dos Halflings', '+1 em todos os testes de resistência.'),
(7, 'Destemido', '+2 moral contra medo (acumula com Sorte).'),
(7, 'Mira', '+1 ataque com armas de arremesso e fundas.'),
(7, 'Audição Aguçada', '+2 Ouvir.');

-- 5. LANGUAGES (Rules)
DELETE FROM race_languages;
-- Human
INSERT IGNORE INTO race_languages (race_id, language_id, is_automatic) SELECT 1, id, TRUE FROM languages WHERE name = 'Comum';
-- Dwarf
INSERT INTO race_languages (race_id, language_id, is_automatic) SELECT 2, id, TRUE FROM languages WHERE name = 'Comum';
INSERT INTO race_languages (race_id, language_id, is_automatic) SELECT 2, id, TRUE FROM languages WHERE name = 'Anão';
INSERT INTO race_languages (race_id, language_id, is_automatic) SELECT 2, id, FALSE FROM languages WHERE name IN ('Gigante', 'Gnomo', 'Goblin', 'Orc', 'Terran', 'Subterrâneo');
-- Elf
INSERT INTO race_languages (race_id, language_id, is_automatic) SELECT 3, id, TRUE FROM languages WHERE name = 'Comum';
INSERT INTO race_languages (race_id, language_id, is_automatic) SELECT 3, id, TRUE FROM languages WHERE name = 'Élfico';
INSERT INTO race_languages (race_id, language_id, is_automatic) SELECT 3, id, FALSE FROM languages WHERE name IN ('Dracônico', 'Gnoll', 'Gnomo', 'Goblin', 'Orc', 'Silvestre');
-- Gnome
INSERT INTO race_languages (race_id, language_id, is_automatic) SELECT 4, id, TRUE FROM languages WHERE name = 'Comum';
INSERT INTO race_languages (race_id, language_id, is_automatic) SELECT 4, id, TRUE FROM languages WHERE name = 'Gnomo';
INSERT INTO race_languages (race_id, language_id, is_automatic) SELECT 4, id, FALSE FROM languages WHERE name IN ('Dracônico', 'Anão', 'Élfico', 'Gigante', 'Goblin', 'Orc');
-- Half-Elf
INSERT INTO race_languages (race_id, language_id, is_automatic) SELECT 5, id, TRUE FROM languages WHERE name = 'Comum';
INSERT INTO race_languages (race_id, language_id, is_automatic) SELECT 5, id, TRUE FROM languages WHERE name = 'Élfico';
-- Half-Orc
INSERT INTO race_languages (race_id, language_id, is_automatic) SELECT 6, id, TRUE FROM languages WHERE name = 'Comum';
INSERT INTO race_languages (race_id, language_id, is_automatic) SELECT 6, id, TRUE FROM languages WHERE name = 'Orc';
INSERT INTO race_languages (race_id, language_id, is_automatic) SELECT 6, id, FALSE FROM languages WHERE name IN ('Dracônico', 'Gigante', 'Gnoll', 'Goblin', 'Abissal');
-- Halfling
INSERT INTO race_languages (race_id, language_id, is_automatic) SELECT 7, id, TRUE FROM languages WHERE name = 'Comum';
INSERT INTO race_languages (race_id, language_id, is_automatic) SELECT 7, id, TRUE FROM languages WHERE name = 'Halfling';
INSERT IGNORE INTO race_languages (race_id, language_id, is_automatic) SELECT 7, id, FALSE FROM languages WHERE name IN ('Anão', 'Élfico', 'Gnomo', 'Goblin', 'Orc');


-- 6. RULE BLOCKS (For Text Display)
INSERT INTO rule_blocks (slug, category, title, content, source_id) VALUES
('choosing-race', 'Races', 'Escolhendo uma Raça', 'Depois de obter os valores das habilidades, mas antes de anotá-los na planilha, escolha a raça do seu personagem. A raça afetará seu desenvolvimento posterior.', 1),
('small-characters', 'Races', 'Personagens Pequenos', 'Os personagens Pequenos recebem +1 CA, +1 Ataque e +4 Esconder-se. Precisam usar armas menores e carregam 3/4 do peso.', 1)
ON DUPLICATE KEY UPDATE content=VALUES(content), title=VALUES(title);

