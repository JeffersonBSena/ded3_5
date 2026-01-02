
-- POPULATE CHAPTER 10: MAGIA (REGRAS)
-- Covers: Magic Schools, Components, Casting Rules, Counterspells, Special Abilities

SET FOREIGN_KEY_CHECKS = 0;

-- ==========================================
-- 1. MAGIC SCHOOLS
-- ==========================================
TRUNCATE TABLE magic_schools;

INSERT INTO magic_schools (name, description) VALUES
('Abjuração', 'Proteção, barreiras, anulação de magia. Ex: Dissipar Magia, Proteção contra o Mal.'),
('Conjuração', 'Criação ou convocação de criaturas/objetos. Sub-escolas: Invocação, Convocação, Criação, Cura, Teletransporte.'),
('Adivinhação', 'Revelar informações, prever futuro. Ex: Vidência, Identificação.'),
('Encantamento', 'Afetar a mente. Sub-escolas: Feitiço (Charme) e Compulsão.'),
('Evocação', 'Manipular energia e criar algo do nada. Ex: Bola de Fogo.'),
('Ilusão', 'Enganar sentidos. Tipos: Ideia, Sensação, Padrão, Fantasma, Sombra.'),
('Necromancia', 'Manipular vida e morte. Ex: Criar Mortos-Vivos.'),
('Transmutação', 'Alterar propriedades físicas. Ex: Metamorfose.'),
('Universal', 'Não pertence a nenhuma escola (Ex: Desejo, Prestidigitação).');

-- ==========================================
-- 2. SPELL COMPONENTS
-- ==========================================
TRUNCATE TABLE spell_components;

INSERT INTO spell_components (code, name, description) VALUES
('V', 'Verbal', 'Requer falar palavras de poder com clareza. Silêncio impede. Surdez: 20% falha.'),
('G', 'Gestual', 'Requer mão livre para gestos precisos. Armadura pode causar falha arcana.'),
('M', 'Material', 'Requer item físico consumido na conjuração. Assumido na bolsa de componentes se barato.'),
('F', 'Foco', 'Requer item físico não consumido (reutilizável).'),
('FD', 'Foco Divino', 'Símbolo sagrado (Clérigo/Paladino) ou natureza (Druida/Ranger).'),
('XP', 'Custo em XP', 'Requer gasto de pontos de experiência do conjurador. Vida = XP.');

-- ==========================================
-- 3. RULE BLOCKS: CASTING & MAGIC
-- ==========================================

-- Casting a Spell
INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('magia-conjuracao', 'Magic', 'Conjurando Magias',
'# Processo de Conjuração\n\n1. **Escolha:** Selecionar magia preparada (ou conhecida p/ Bardo/Sorcerer).\n2. **Requisitos:** Componentes (V, G, M), Foco (F, FD), XP. Se impedido (ex: amordaçado para V), a magia falha.\n3. **Concentração:** Se distraído (dano, movimento), precisa de teste de Vontade. Falha = Perda da magia.\n\n**Falha de Magia Arcana:** Armaduras atrapalham magias arcanas com componente Gestual (G). Verifique a % de falha da armadura.\n\n**Conjuração Defensiva:** CD 15 + Nível da Magia para não provocar Ataque de Oportunidade.', 1);

-- Concentration
INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('magia-concentracao', 'Magic', 'Concentração',
'# CDs de Concentração\n\n- **Conjurando na Defensiva:** CD 15 + Nível da Magia.\n- **Sofrendo Dano (durante conjuração):** CD 10 + Dano + Nível.\n- **Sofrendo Dano Contínuo:** CD 10 + 1/2 Dano + Nível.\n- **Movimento Vigoroso (Montaria):** CD 10 + Nível.\n- **Movimento Violento (Galope/Tempestade):** CD 15 + Nível.\n- **Área de Magia Atrapalhando:** CD = CD da Magia + Nível.\n- **Agarrado/Imobilizado:** CD 20 + Nível (apenas magias sem G).', 1);

-- Counterspells
INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('magia-contramagica', 'Magic', 'Contramágica',
'# Contramágica\n\n1. **Preparar Ação:** Declarar que vai anular o oponente.\n2. **Identificar:** Teste de Identificar Magia (CD 15 + Nível da Magia) ao ver a conjuração.\n3. **Conjurar:** Gastar a *mesma magia* (ou Diametralmente Oposta específica, ou Dissipar Magia) para anular.\n\n- **Dissipar Magia:** Pode ser usado como contramágica universal (requer teste de dissipar).\n- **Talentos Metamágicos:** Não impedem a contramágica (Bola de Fogo maximizada é anulada por Bola de Fogo normal).', 1);

-- Spell Results (Saving Throw, SR, Duration)
INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('magia-resultados', 'Magic', 'Resultados da Magia',
'# Parâmetros\n\n**Teste de Resistência:**\n- CD = 10 + Nível da Magia + Mod. Habilidade (Int/Sab/Car).\n- Tipos: Anula (sem efeito), Parcial (efeito reduzido), Metade (dano/2), Desacredita (ilusão).\n\n**Resistência à Magia (RM):**\n- O conjurador joga 1d20 + Nível de Conjurador vs RM do alvo. Se falhar, magia não afeta.\n\n**Duração:**\n- Instantânea (não dissipável), Permanente (dissipável), Concentração (enquanto focar).\n- (D) = Dissipável voluntariamente pelo conjurador.\n\n**Alcance:** Pessoal, Toque, Curto (7.5m + 1.5m/2 nv), Médio (30m + 3m/nv), Longo (120m + 12m/nv).', 1);

-- Special Abilities (Supernatural vs Spell-Like)
INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('habilidades-especiais', 'Magic', 'Habilidades Especiais',
'# Tipos de Habilidades\n\n1. **Similar a Magia (Sp):** Funciona como magia. Sujeita a RM e Dissipar. Provoca PdO. Sem componentes.\n2. **Sobrenatural (Su):** Mágica, mas não é magia. Ignora RM, não provoca PdO, não dissipável. Suprimida por Campo Antimagia.\n3. **Extraordinária (Ex):** Não mágica. Ignora RM, Dissipar e Campo Antimagia. (Ex: Regeneração de Troll).\n4. **Natural:** Física (Ex: Asas).', 1);

-- ==========================================
-- 4. DESCRIPTORS
-- ==========================================
INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('magia-descritores', 'Magic', 'Descritores de Magia',
'# Descritores\n\nClassificações que interagem com resistências e fraquezas.\n\n- **Elemental:** Ácido, Fogo, Frio, Eletricidade, Sônico.\n- **Alinhamento:** Bem, Mal, Ordem, Caos. (Afetam apenas alvos opostos ou detectam tal).\n- **Ação Mental:** Afeta apenas Inteligência 1+.\n- **Linguagem:** Requer que o alvo entenda o idioma.\n- **Luz/Escuridão:** Anulam-se.\n- **Medo/Morte:** Efeitos específicos.', 1);


SET FOREIGN_KEY_CHECKS = 1;
