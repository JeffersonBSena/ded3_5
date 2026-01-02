
-- POPULATE CHAPTER 9: AVENTURANDO-SE
-- Covers: Carrying Capacity, Movement, Exploration, Light, Breaking In

SET FOREIGN_KEY_CHECKS = 0;

-- ==========================================
-- 1. CARRYING CAPACITY (Tabela 9-1 & 9-2)
-- ==========================================

-- Alter columns to support decimals (Metric System uses 1.5 kg etc)
-- Since there are no FKs pointing here, this is safe.
ALTER TABLE carrying_capacity MODIFY light_load DECIMAL(10,3);
ALTER TABLE carrying_capacity MODIFY medium_load DECIMAL(10,3);
ALTER TABLE carrying_capacity MODIFY heavy_load DECIMAL(10,3);

TRUNCATE TABLE carrying_capacity;

-- Insert data from Tabela 9-1 (Metric)
INSERT INTO carrying_capacity (strength_score, light_load, medium_load, heavy_load) VALUES
(1, 1.5, 3.0, 5.0),
(2, 3.0, 6.5, 10.0),
(3, 5.0, 10.0, 15.0),
(4, 6.5, 13.0, 20.0),
(5, 8.0, 16.5, 25.0),
(6, 10.0, 20.0, 30.0),
(7, 11.5, 23.0, 35.0),
(8, 13.0, 26.5, 40.0),
(9, 15.0, 30.0, 45.0),
(10, 16.5, 33.0, 50.0),
(11, 19.0, 38.0, 57.5),
(12, 21.5, 43.0, 65.0),
(13, 25.0, 50.0, 75.0),
(14, 29.0, 58.0, 87.5),
(15, 33.0, 66.5, 100.0),
(16, 38.0, 76.5, 115.0),
(17, 43.0, 86.5, 130.0),
(18, 50.0, 100.0, 150.0),
(19, 58.0, 116.5, 175.0),
(20, 66.5, 133.0, 200.0),
(21, 76.5, 153.0, 230.0),
(22, 86.5, 173.0, 260.0),
(23, 100.0, 200.0, 300.0),
(24, 116.5, 233.0, 350.0),
(25, 133.0, 266.5, 400.0),
(26, 153.0, 306.5, 460.0),
(27, 173.0, 346.5, 520.0),
(28, 200.0, 400.0, 600.0),
(29, 233.0, 466.5, 700.0);

-- Rules regarding encumbrance penalties (Tabela 9-2 in text format)
INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('capacidade-carga', 'Adventuring', 'Capacidade de Carga', 
'# Capacidade de Carga\n\n**Carga Leve:** Até o valor listado. Sem penalidades.\n**Carga Média:** Até o valor listado. Max Des +3, Penalidade -3, Deslocamento reduzido (9m -> 6m).\n**Carga Pesada:** Até o valor listado. Max Des +1, Penalidade -6, Deslocamento reduzido (9m -> 6m, 6m -> 4.5m). Corrida x3 apenas.\n\n**Levantar e Arrastar:**\n- **Erguera acimar da cabeça:** Igual à Carga Máxima.\n- **Levantar do chão:** 2x Carga Máxima (Passo lento 1,5m, perde Des na CA).\n- **Empurrar/Arrastar:** 5x Carga Máxima.\n\n**Tamanho:**\n- Grande x2, Enorme x4, Imenso x8, Colossal x16.\n- Pequeno x3/4, Miúdo x1/2, Diminuto x1/4, Minúsculo x1/8.\n- Quadrúpedes: Mula (Médio) x1.5, Cavalo (Grande) x3.', 1);

-- ==========================================
-- 2. MOVEMENT (Tabela 9-3 to 9-6)
-- ==========================================
INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('movimento-aventura', 'Adventuring', 'Movimento e Viagem',
'# Escalas de Movimento\n\n**Tático (Combate):** Metros por rodada.\n**Local (Exploração):** Metros por minuto.\n**Viagem:** Km por hora/dia.\n\n### Tabela 9-3: Movimento e Distância\n| Deslocamento | 1 Rodada | 1 Minuto | 1 Hora | 1 Dia |\n|---|---|---|---|---|\n| 6m | 6m | 60m | 3km | 24km |\n| 9m | 9m | 90m | 4.5km | 36km |\n| 12m | 12m | 120m | 6km | 48km |\n\n**Marcha Forçada:** >8h por dia. Teste Con CD 10 + 2/h extra. Falha: 1d6 dano contusão e fadiga.\n\n### Terreno (Tabela 9-5)\n- **Estrada:** x1\n- **Trilha:** x1 (Floresta/Colina: x3/4)\n- **Sem Trilha:** Floresta x1/2, Montanha x1/2, Pântano x1/2, Selva x1/4.', 1);

INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('movimento-dificil', 'Adventuring', 'Movimento Difícil',
'# Movimento Difícil e Obstáculos\n\n- **Custo Dobrado (x2):** Terreno acidentado (vegetação, entulho), obstáculo, baixa visibilidade.\n- **Acumulativo:** Terreno acidentado + Escuridão = x4 custo.\n- **Impossível?** Se custo > deslocamento, ação completa para mover 1,5m (provoca PdO).\n- **Corrida/Investida:** Impossível em terreno difícil.', 1);

-- ==========================================
-- 3. EXPLORATION & LIGHT (Tabela 9-7)
-- ==========================================
INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('luz-vision', 'Adventuring', 'Visão e Luz',
'# Tabela 9-7: Fontes de Luz\n\n| Fonte | Luz Clara | Penumbra | Duração |\n|---|---|---|---|\n| Vela | - | 1.5m | 1h |\n| Tocha | 6m | 12m | 1h |\n| Lanterna (comum) | 4.5m | 9m | 6h/100ml |\n| Lanterna (furta-fogo) | 18m (Cone) | 36m (Cone) | 6h/100ml |\n| Bastão Solar | 9m | 18m | 6h |\n| Magia: Luz | 6m | 12m | 10 min |\n| Magia: Luz do Dia | 18m | 36m | 30 min |\n\n**Efeitos:**\n- **Penumbra:** Camuflagem (20% falha).\n- **Escuridão:** Cego (50% falha, -2 CA, perde Des, -4 Perícias).\n- **Visão na Penumbra:** Enxerga o dobro (Raio x2).\n- **Visão no Escuro:** 18m em P&B, ignora escuridão.', 1);

-- ==========================================
-- 4. BREAKING OBJECTS (Tabelas 9-8 to 9-11)
-- ==========================================
INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('quebrar-objetos', 'Adventuring', 'Quebrando Objetos',
'# Quebrando Itens\n\n**Classe de Armadura:** 10 + Tamanho + Des (0, logo -5) + Nat (-2 inanimado). CA Base de objeto ~3.\n**Dureza:** Subtrai do dano.\n**Pontos de Vida:** Se 0, destruído.\n**Energia:** Sônico/Ácido (Total), Fogo/Elétrico (Metade), Frio (1/4).\n\n### Dureza e PV (Tabela 9-9)\n- **Madeira:** Dureza 5, 10 PV/2.5cm.\n- **Pedra:** Dureza 8, 15 PV/2.5cm.\n- **Ferro/Aço:** Dureza 10, 30 PV/2.5cm.\n- **Mitral:** Dureza 15, 30 PV.\n- **Adamante:** Dureza 20, 40 PV.\n- **Corda:** Dureza 0, 2 PV.\n- **Vidro:** Dureza 1, 1 PV.\n\n### Exemplos (Tabela 9-11)\n- **Porta Madeira (Simples):** Dureza 5, 10 PV. (CD Força 13).\n- **Porta Madeira (Reforçada):** Dureza 5, 20 PV. (CD Força 23).\n- **Porta Ferro:** Dureza 10, 60 PV. (CD Força 28).\n- **Algemas:** Dureza 10, 10 PV. (CD Força 26).', 1);

-- ==========================================
-- 5. TREASURE
-- ==========================================
INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('tesouro-recompensas', 'Adventuring', 'Tesouro e Recompensas',
'# Tesouro\n\n- **Divisão:** Igualitária recomendada. Itens mágicos valem metade do preço se vendidos.\n- **Leilão:** Personagens podem "comprar" itens do grupo descontando de sua parte.\n- **Despesas:** Deduzir custos de cura/identificação antes da partilha.\n\n**Outras Recompensas:** Terras, Títulos, Seguidores, Reputação.', 1);

SET FOREIGN_KEY_CHECKS = 1;
