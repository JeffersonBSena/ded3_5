
-- POPULATE CHAPTER 8: COMBATE
-- Covers: Combat Statistics, Actions, Rules (Initiative, AoO, Modifiers)

SET FOREIGN_KEY_CHECKS = 0;

-- ==========================================
-- 1. SIZES (Tabela 8-1)
-- ==========================================
INSERT INTO sizes (name, modifier, grapple_modifier, hide_modifier, carrying_capacity_multiplier) VALUES
('Colossal', -8, 16, -16, 16) ON DUPLICATE KEY UPDATE modifier = -8;
INSERT INTO sizes (name, modifier, grapple_modifier, hide_modifier, carrying_capacity_multiplier) VALUES
('Imenso', -4, 12, -12, 8) ON DUPLICATE KEY UPDATE modifier = -4; 
INSERT INTO sizes (name, modifier, grapple_modifier, hide_modifier, carrying_capacity_multiplier) VALUES
('Enorme', -2, 8, -8, 4) ON DUPLICATE KEY UPDATE modifier = -2;
INSERT INTO sizes (name, modifier, grapple_modifier, hide_modifier, carrying_capacity_multiplier) VALUES
('Grande', -1, 4, -4, 2) ON DUPLICATE KEY UPDATE modifier = -1;
INSERT INTO sizes (name, modifier, grapple_modifier, hide_modifier, carrying_capacity_multiplier) VALUES
('Médio', 0, 0, 0, 1) ON DUPLICATE KEY UPDATE modifier = 0;
INSERT INTO sizes (name, modifier, grapple_modifier, hide_modifier, carrying_capacity_multiplier) VALUES
('Pequeno', 1, -4, 4, 0.75) ON DUPLICATE KEY UPDATE modifier = 1;
INSERT INTO sizes (name, modifier, grapple_modifier, hide_modifier, carrying_capacity_multiplier) VALUES
('Miúdo', 2, -8, 8, 0.5) ON DUPLICATE KEY UPDATE modifier = 2;
INSERT INTO sizes (name, modifier, grapple_modifier, hide_modifier, carrying_capacity_multiplier) VALUES
('Diminuto', 4, -12, 12, 0.25) ON DUPLICATE KEY UPDATE modifier = 4;
INSERT INTO sizes (name, modifier, grapple_modifier, hide_modifier, carrying_capacity_multiplier) VALUES
('Minúsculo', 8, -16, 16, 0.125) ON DUPLICATE KEY UPDATE modifier = 8;

-- ==========================================
-- 2. COMBAT ACTIONS (Tabela 8-2 + Descriptions)
-- ==========================================
TRUNCATE TABLE combat_actions;

-- Standard Actions
INSERT INTO combat_actions (name, action_type, provokes_aoo, description) VALUES
('Ataque (corpo a corpo)', 'Standard', 0, 'Golpear um inimigo num raio de alcance.'),
('Ataque (à distância)', 'Standard', 1, 'Disparar ou arremessar contra um alvo. Provoca PdO.'),
('Ataque (desarmado)', 'Standard', 1, 'Atacar sem armas. Provoca PdO se não tiver talento.'),
('Ativar item mágico (uso)', 'Standard', 0, 'Usar poção, óleo ou item ativado por uso não provoca PdO se for simples.'),
('Ingerir poção', 'Standard', 1, 'Beber uma poção provoca PdO.'),
('Aplicar óleo', 'Standard', 1, 'Aplicar óleo em arma ou armadura provoca PdO.'),
('Prestar auxílio', 'Standard', 1, 'Concede +2 num teste ou CA de amigo. Provoca PdO? "Talvez". (Sim na tabela 8-2).'),
('Encontrão', 'Standard', 0, 'Empurrar oponente. (Bull Rush).'),
('Conjurar magia (1 ação)', 'Standard', 1, 'Lançar feitiço. Provoca PdO exceto na defensiva.'),
('Sustentar uma Magia', 'Standard', 0, 'Manter concentração.'),
('Cancelar uma magia', 'Standard', 0, 'Encerrar efeito ativo.'),
('Sacar arma oculta', 'Standard', 0, 'Requer Prestidigitação. Não provoca PdO.'),
('Escapar da Manobra Agarrar', 'Standard', 0, 'Tentar se soltar de um Grapple.'),
('Fintar', 'Standard', 0, 'Enganar oponente em combate (Bluff).'),
('Acender Tocha com Fósforo', 'Standard', 1, 'Acender fonte de luz.'),
('Neutralizar RM', 'Standard', 0, 'Baixar resistência a magia voluntariamente.'),
('Estabilizar Aliado', 'Standard', 1, 'Teste de Cura CD 15 em aliado morrendo.'),
('Atropelar', 'Standard', 0, 'Passar por cima de oponente (Overrun).'),
('Ler Pergaminho', 'Standard', 1, 'Ativação de item de conclusão de magia.'),
('Preparar (Ready)', 'Standard', 0, 'Aguarda um gatilho para agir.'),
('Separar (Sunder) - Arma', 'Standard', 1, 'Atacar arma do oponente. Provoca PdO.'),
('Separar (Sunder) - Objeto', 'Standard', 0, 'Atacar objeto carregado (talvez provoque).'),
('Defesa Total', 'Standard', 0, '+4 na CA, não ataca.'),
('Expulsar/Fascinar Mortos-Vivos', 'Standard', 0, 'Habilidade sobrenatural de clérigo/paladino.'),
('Usar Hab. Extraordinária', 'Standard', 0, 'Geralmente não provoca.'),
('Usar Hab. Similar à Magia', 'Standard', 1, 'Provoca PdO.'),
('Usar Hab. Sobrenatural', 'Standard', 0, 'Não provoca PdO.'),
('Usar Perícia (1 ação)', 'Standard', 1, 'Varia, geralmente sim.');

-- Move Actions
INSERT INTO combat_actions (name, action_type, provokes_aoo, description) VALUES
('Movimento', 'Move', 1, 'Percorrer deslocamento. Provoca PdO ao sair de quadrado ameaçado.'),
('Controlar Montaria Assustada', 'Move', 1, 'Teste de Cavalgar.'),
('Direcionar/Redirecionar Magia', 'Move', 0, 'Mudar alvo de magia ativa.'),
('Desembainhar uma Arma', 'Move', 0, 'Sacar arma. Se BBA +1 ou mais, pode ser livre com movimento.'),
('Recarregar Besta Leve', 'Move', 1, 'Recarregar provoca PdO.'),
('Recarregar Besta de Mão', 'Move', 1, 'Recarregar provoca PdO.'),
('Abrir/Fechar Porta', 'Move', 0, 'Manipular objeto simples.'),
('Montar/Desmontar', 'Move', 0, 'Subir ou descer de montaria.'),
('Mover um Objeto Pesado', 'Move', 1, 'Empurrar ou arrastar.'),
('Pegar Item (do chão)', 'Move', 1, 'Abaixar-se provoca PdO.'),
('Embainhar uma Arma', 'Move', 1, 'Guardar arma provoca PdO.'),
('Levantar do Chão', 'Move', 1, 'Ficar de pé.'),
('Preparar/Liberar Escudo', 'Move', 0, 'Afixar ou soltar escudo.'),
('Pegar/Guardar Item (mochila)', 'Move', 1, 'Manipular item guardado.');

-- Full-Round Actions
INSERT INTO combat_actions (name, action_type, provokes_aoo, description) VALUES
('Ataque Total', 'Full-Round', 0, 'Múltiplos ataques. Permite passo de ajuste.'),
('Investida', 'Full-Round', 0, 'Mover + ataque com +2 atk/-2 CA. Movimento linear.'),
('Golpe de Misericórdia', 'Full-Round', 1, 'Matar inimigo indefeso. Provoca PdO.'),
('Escapar de Rede', 'Full-Round', 1, 'Sair de rede ou emaranhado.'),
('Extinguir Chamas', 'Full-Round', 0, 'Apagar fogo no corpo.'),
('Acender uma Tocha', 'Full-Round', 1, 'Pederneira e isqueiro.'),
('Recarregar Besta Pesada', 'Full-Round', 1, 'Recarregar provoca PdO.'),
('Recarregar Besta de Repetição', 'Full-Round', 1, 'Recarregar provoca PdO.'),
('Travar/Destravar Manopla', 'Full-Round', 1, 'Manopla de segurança.'),
('Correr', 'Full-Round', 1, '4x deslocamento (ou 3x). Perde Dex na CA.'),
('Usar Perícia (1 rodada)', 'Full-Round', 1, 'Uso longo de perícia.'),
('Conjurar Magia de Toque (6 aliados)', 'Full-Round', 1, 'Tocar até 6 aliados.'),
('Recuar', 'Full-Round', 0, 'Sair do combate (primeiro quadrado não provoca PdO). (Withdraw).');

-- Free/No Actions
INSERT INTO combat_actions (name, action_type, provokes_aoo, description) VALUES
('Conjurar Magia Acelerada', 'Free', 0, 'Swift action na 3.5e, Free na descrição.'),
('Terminar Concentração', 'Free', 0, 'Parar de manter magia.'),
('Soltar Item', 'Free', 0, 'Largar no chão.'),
('Jogar-se no Chão', 'Free', 0, 'Provar. Não provoca PdO.'),
('Falar', 'Free', 0, 'Gritar ou falar brevemente.'),
('Passo de Ajuste (1,5 m)', 'Free', 0, 'Mover 1,5m sem provocar PdO se não houver outro movimento.'),
('Adiar Ação', 'Free', 0, 'Esperar iniciativa menor.');

-- Special/Varies
INSERT INTO combat_actions (name, action_type, provokes_aoo, description) VALUES
('Desarme', 'Standard', 1, 'Substitui ataque. Provoca PdO sem talento.'),
('Agarrar', 'Standard', 1, 'Iniciar Grapple. Provoca PdO sem talento.'),
('Imobilização (Trip)', 'Standard', 1, 'Derrubar. Provoca PdO sem talento.');

-- ==========================================
-- 3. CONDITIONS
-- ==========================================
INSERT IGNORE INTO conditions (name, description) VALUES 
('Surpreso', 'Não pode agir, perde bônus de Des na CA.'),
('Incapacitado', '0 PV. Apenas uma ação de mov ou padrão. Sofre 1 dano após ação padrão.'),
('Morrendo', '-1 a -9 PV. Inconsciente, perde 1 PV por rodada se não estabilizar.'),
('Morto', '-10 PV ou menos. Alma parte.'),
('Nocauteado', 'Dano por contusão iguala PV atuais. Inconsciente.'),
('Estável', 'Morrendo mas parou de perder PV. Inconsciente.'),
('Enredado', 'Sofre -2 ataque, -4 Des. Movimento metade.'),
('Ofuscado', '-1 ataque, -1 percepção.'),
('Abalado', '-2 ataques, perícias, testes.'),
('Amedrontado', 'Foge se possível. -2 em tudo.'),
('Cego', '-2 CA, perde Des na CA, mov reduzido, falha 50% em ataques.'),
('Surdo', 'Falha 20% magias verbais, -4 iniciativa.'),
('Imobilizado', 'Preso. (Pinned/Hold).'),
('Indefeso', 'Dex 0 (-5 CA), ataque recebe +4. Alvo de Golpe de Misericórdia.'),
('Caído', '-4 ataque corpo a corpo, +4 CA contra distãncia, -4 CA contra corpo a corpo.');

-- ==========================================
-- 4. RULE BLOCKS
-- ==========================================
-- Initiative
INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('iniciativa', 'Combat', 'Iniciativa', 
'# Iniciativa\n\nNo início do combate, todos jogam Iniciativa: **1d20 + Modificador de Destreza**.\n\n- Ordem do maior para o menor.\n- Em caso de empate, maior Destreza vence.\n- Se persistir, jogam novamente.\n- O valor se mantém por todo o combate.\n\n### Surpresa\nSe um lado não notar o outro, ocorre uma **Rodada Surpresa**.\n- Apenas quem notou age (Ação Padrão ou Movimento).\n- Quem não notou está **Surpreso** (sem Des na CA, não faz PdO).', 1);

-- Attacks of Opportunity
INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('ataques-oportunidade', 'Combat', 'Ataques de Oportunidade', 
'# Ataques de Oportunidade (PdO)\n\nVocê ameaça os quadrados adjacentes (1,5m) se estiver armado.\n\n**Provocam PdO:**\n1. **Sair de um quadrado ameaçado** (exceto Passo de Ajuste ou Recuar).\n2. **Ações distraídas**: Conjurar magia, atirar com arco, beber poção, etc.\n\n- Pode fazer 1 PdO por rodada (mais com Reflexos de Combate).\n- O ataque é feito com seu maior BBA.', 1);

-- Attack Bonus
INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('bonus-ataque', 'Combat', 'Bônus de Ataque', 
'# Cálculo de Ataque\n\n**Corpo a Corpo (Melee):**\nBBA + Força + Tamanho + Outros\n\n**À Distância (Ranged):**\nBBA + Destreza + Tamanho + Penalidade Distância + Outros\n\n- **1 Natural**: Erro automático.\n- **20 Natural**: Acerto automático e Ameaça de Crítico.\n- **Dano**: Arma + Força (x1 mão inábil, x0.5 mão secundária, x1.5 duas mãos).', 1);

-- AC
INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('classe-armadura', 'Combat', 'Classe de Armadura (CA)', 
'# CA = 10 + Armadura + Escudo + Destreza + Tamanho + Outros\n\n**Toque:** Ignora Armadura, Escudo e Natural.\n**Surpreso:** Perde Destreza.\n\n**Modificadores Comuns:**\n- **Flanqueado:** Atacante recebe +2.\n- **Ajuda:** +2 na CA.\n- **Investida:** -2 na CA.\n- **Defesa Total:** +4 na CA.\n- **Lutar na Defensiva:** +2 na CA (-4 ataque).', 1);

-- Modifiers Table
INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('modificadores-combate', 'Combat', 'Modificadores de Combate',
'# Tabela 8-5 e 8-6: Modificadores\n\n| Situação | Ataque (Melee) | Ataque (Ranged) | CA (Defensor) |\n|---|---|---|---|\n| Flanqueando | +2 | - | - |\n| Terreno Superior | +1 | - | - |\n| Caído (Atacante) | -4 | - (Besta OK) | - |\n| Caído (Defensor) | - | - | -4 (vs Melee) / +4 (vs Ranged) |\n| Invisível (Atacante)| +2 (e ignora Des) | +2 (e ignora Des) | - |\n| Cobertura | - | - | +4 |\n| Camuflagem | - | - | 20% falha |\n\n**Cobertura:** +4 CA, +2 Reflexos.\n**Camuflagem:** 20% chance de falha (não afeta CA, mas anula ataque).', 1);

-- Dying Guidelines
INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('ferimentos-morte', 'Combat', 'Ferimentos e Morte', 
'# Pontos de Vida (PV)\n\n- **0 PV (Incapacitado):** Age parcial, sofre 1 dano se agir.\n- **-1 a -9 PV (Morrendo):** Inconsciente, perde 1 PV/rodada. Teste 10% para estabilizar.\n- **-10 PV:** Morto.\n- **Dano por Contusão:** Se Dano Contusão > PV Atuais: Inconsciente (Nocauteado).\n\n**Recuperação Natural:** 1 PV/nível por 8 horas (2x se descanso completo 24h).', 1);

-- Movement
INSERT IGNORE INTO rule_blocks (slug, category, title, content, source_id) VALUES
('movimento-tatico', 'Combat', 'Movimento Tático', 
'# Movimentação\n\n- **Deslocamento:** Humano 9m (6 sq), Anão 6m (4 sq).\n- **Terreno Difícil:** Custo x2 (Diagonal x3).\n- **Atravessar Aliado:** Permitido (não pára).\n- **Atravessar Inimigo:** Não (exceto Acrobacia ou Diferença de Tamanho x3).\n- **Diagonais:** 1ª custa 1, 2ª custa 2 (1,5-3-4,5-6...).', 1);

SET FOREIGN_KEY_CHECKS = 1;
