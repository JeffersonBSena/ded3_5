-- Populate Chapter 1: Abilities (PT-BR)

-- 1. Updates to existing Abilities (using Portuguese descriptions)
UPDATE abilities SET name='Força', abbreviation='FOR', description='A Força representa o potencial físico e a musculatura do personagem. O personagem aplica o modificador de Força em: Jogadas de ataque corporal, danos com armas brancas, Testes de Escalar, Natação e Saltar.' WHERE abbreviation='STR';
UPDATE abilities SET name='Destreza', abbreviation='DES', description='A Destreza indica a coordenação motora, a agilidade, os reflexos e o equilíbrio do personagem. O modificador se aplica em: Ataques à distância, Classe de Armadura (CA), Reflexos, e diversas perícias (Abrir Fechaduras, Esconder-se, etc).' WHERE abbreviation='DEX';
UPDATE abilities SET name='Constituição', abbreviation='CON', description='A Constituição representa a saúde e a resistência do personagem. O modificador se aplica em: Pontos de Vida (por dado), Fortitude e Concentração.' WHERE abbreviation='CON';
UPDATE abilities SET name='Inteligência', abbreviation='INT', description='A Inteligência determina a facilidade para aprender e raciocinar. Importante para Magos. Afeta: Idiomas iniciais, Pontos de Perícia por nível, e magias arcanas.' WHERE abbreviation='INT';
UPDATE abilities SET name='Sabedoria', abbreviation='SAB', description='A Sabedoria representa a força de vontade, bom senso, percepção e intuição. Importante para Clérigos e Druidas. Afeta: Vontade e perícias de percepção (Ouvir, Observar).' WHERE abbreviation='WIS';
UPDATE abilities SET name='Carisma', abbreviation='CAR', description='O Carisma representa a força do caráter, persuasão, liderança e beleza física. Importante para Bardos, Feiticeiros e Paladinos. Afeta: Perícias sociais e Expulsar Mortos-vivos.' WHERE abbreviation='CHA';

-- 2. Populate Ability Score Lookup (Table 1-1)
DELETE FROM ability_score_lookup;
-- Generating values from 1 to 45 based on the pattern provided
-- Score | Mod | Bonus Spells (1st, 2nd, 3rd, 4th, 5th, 6th, 7th, 8th, 9th)

-- Scores 1-9 (Penalties, no bonus spells)
INSERT INTO ability_score_lookup (score, modifier) VALUES
(1, -5), (2, -4), (3, -4), (4, -3), (5, -3), (6, -2), (7, -2), (8, -1), (9, -1);

-- Scores 10-11 (Average, 0 mod)
INSERT INTO ability_score_lookup (score, modifier) VALUES (10, 0), (11, 0);

-- Scores 12+ (Bonuses)
-- Note: Logic for bonus spells:
-- Score 12-19: See Text.
-- 12-13 (+1): 1st:1
-- 14-15 (+2): 1st:1, 2nd:1
-- 16-17 (+3): 1st:1, 2nd:1, 3rd:1
-- 18-19 (+4): 1st:1, 2nd:1, 3rd:1, 4th:1
-- 20-21 (+5): 1st:2, 2nd:1, 3rd:1, 4th:1, 5th:1
-- 22-23 (+6): 1st:2, 2nd:2, 3rd:1, 4th:1, 5th:1, 6th:1 
-- ... Pattern: Bonus spell of level L is granted if (Mod - L) >= 0.
-- Extra spells/day = (Mod - SpellLevel + 4) / 4 (integer math)? No, let's use explicit values from text inference or standard d20 rule.
-- Rule: "receberá magias adicionais... Tabela 1-1"
-- 12-13 (+1): 1 (Lvl1)
-- 14-15 (+2): 1 (Lvl1), 1 (Lvl2)
-- 20-21 (+5): 2 (Lvl1), 1 (Lvl2), 1 (Lvl3), 1 (Lvl4), 1 (Lvl5).
-- 22-23 (+6): 2 (Lvl1), 2 (Lvl2), 1 (Lvl3), 1 (Lvl4), 1 (Lvl5), 1 (Lvl6).
-- 28-29 (+9): 3 (Lvl1), 2, 2, 2, 1, 1, 1, 1, 1 (Lvl9).

INSERT INTO ability_score_lookup (score, modifier, bonus_spells_1st, bonus_spells_2nd, bonus_spells_3rd, bonus_spells_4th) VALUES
(12, 1, 1, 0, 0, 0),
(13, 1, 1, 0, 0, 0),
(14, 2, 1, 1, 0, 0),
(15, 2, 1, 1, 0, 0),
(16, 3, 1, 1, 1, 0),
(17, 3, 1, 1, 1, 0),
(18, 4, 1, 1, 1, 1),
(19, 4, 1, 1, 1, 1);

INSERT INTO ability_score_lookup (score, modifier, bonus_spells_1st, bonus_spells_2nd, bonus_spells_3rd, bonus_spells_4th, bonus_spells_5th) VALUES
(20, 5, 2, 1, 1, 1, 1),
(21, 5, 2, 1, 1, 1, 1);

INSERT INTO ability_score_lookup (score, modifier, bonus_spells_1st, bonus_spells_2nd, bonus_spells_3rd, bonus_spells_4th, bonus_spells_5th, bonus_spells_6th) VALUES
(22, 6, 2, 2, 1, 1, 1, 1),
(23, 6, 2, 2, 1, 1, 1, 1);

INSERT INTO ability_score_lookup (score, modifier, bonus_spells_1st, bonus_spells_2nd, bonus_spells_3rd, bonus_spells_4th, bonus_spells_5th, bonus_spells_6th, bonus_spells_7th) VALUES
(24, 7, 2, 2, 2, 1, 1, 1, 1),
(25, 7, 2, 2, 2, 1, 1, 1, 1);

INSERT INTO ability_score_lookup (score, modifier, bonus_spells_1st, bonus_spells_2nd, bonus_spells_3rd, bonus_spells_4th, bonus_spells_5th, bonus_spells_6th, bonus_spells_7th, bonus_spells_8th) VALUES
(26, 8, 2, 2, 2, 2, 1, 1, 1, 1),
(27, 8, 2, 2, 2, 2, 1, 1, 1, 1);

INSERT INTO ability_score_lookup (score, modifier, bonus_spells_1st, bonus_spells_2nd, bonus_spells_3rd, bonus_spells_4th, bonus_spells_5th, bonus_spells_6th, bonus_spells_7th, bonus_spells_8th, bonus_spells_9th) VALUES
(28, 9, 3, 2, 2, 2, 2, 1, 1, 1, 1),
(29, 9, 3, 2, 2, 2, 2, 1, 1, 1, 1),
(30, 10, 3, 3, 2, 2, 2, 2, 1, 1, 1),
(31, 10, 3, 3, 2, 2, 2, 2, 1, 1, 1),
(32, 11, 3, 3, 3, 2, 2, 2, 2, 1, 1),
(33, 11, 3, 3, 3, 2, 2, 2, 2, 1, 1),
(34, 12, 3, 3, 3, 3, 2, 2, 2, 2, 1),
(35, 12, 3, 3, 3, 3, 2, 2, 2, 2, 1),
(36, 13, 4, 3, 3, 3, 3, 2, 2, 2, 2),
(37, 13, 4, 3, 3, 3, 3, 2, 2, 2, 2),
(38, 14, 4, 4, 3, 3, 3, 3, 2, 2, 2),
(39, 14, 4, 4, 3, 3, 3, 3, 2, 2, 2),
(40, 15, 4, 4, 4, 3, 3, 3, 3, 2, 2),
(41, 15, 4, 4, 4, 3, 3, 3, 3, 2, 2),
(42, 16, 4, 4, 4, 4, 3, 3, 3, 3, 2),
(43, 16, 4, 4, 4, 4, 3, 3, 3, 3, 2),
(44, 17, 5, 4, 4, 4, 4, 3, 3, 3, 3),
(45, 17, 5, 4, 4, 4, 4, 3, 3, 3, 3);

-- 3. Rules Text (Rule Blocks)
INSERT INTO rule_blocks (slug, category, title, content, source_id) VALUES
('ability-generation', 'Abilities', 'Gerando Valores de Habilidade', 'Para definir um valor de habilidade para seu personagem, jogue quatro dados de seis faces (4d6). Descarte o menor resultado e some os outros três. Isso resultará em um valor entre 3 e 18. Repita 6 vezes e distribua conforme desejar.', 1),
('ability-modifiers', 'Abilities', 'Modificadores de Habilidade', 'O modificador é um número aplicado na jogada de dados quando seu personagem tenta realizar alguma tarefa relacionada com aquela habilidade. (Valor-10)/2 arredondado para baixo.', 1),
('ability-reroll', 'Abilities', 'Jogando Novamente (Mulligan)', 'Caso a soma dos modificadores seja igual ou inferior a 0, ou o valor mais elevado seja 13 ou menos, você pode descartar e rolar tudo novamente.', 1);

