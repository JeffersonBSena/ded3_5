
-- POPULATE CHAPTER 5: FEATS
-- Inserts all feats from D&D 3.5 Player's Handbook (PT-BR)

-- 1. Ensure Feat Types Exist
INSERT IGNORE INTO feat_types (name) VALUES 
('Geral'), 
('Metamágico'), 
('Criação de Item'), 
('Especial');

SET @TYPE_GEN = (SELECT id FROM feat_types WHERE name = 'Geral');
SET @TYPE_META = (SELECT id FROM feat_types WHERE name = 'Metamágico');
SET @TYPE_ITEM = (SELECT id FROM feat_types WHERE name = 'Criação de Item');
SET @TYPE_SPEC = (SELECT id FROM feat_types WHERE name = 'Especial');

-- 2. Insert Feats
-- Note: Assuming source_id = 1 (Player's Handbook)
DELETE FROM feats WHERE source_id = 1;

INSERT INTO feats (name, feat_type_id, prerequisites_text, benefit, normal, special, source_id) VALUES

-- ACELERAR MAGIA [Metamágico]
('Acelerar Magia', @TYPE_META, NULL, 'Conjurar uma magia acelerada é uma ação livre. Seu personagem pode realizar qualquer outra ação (até mesmo lançar outra magia), na mesma rodada em que conjura uma magia acelerada. É possível utilizar apenas um efeito acelerado a cada rodada. Uma magia acelerada ocupa o lugar de uma magia quatro níveis superiores. Não provoca ataques de oportunidade.', NULL, 'Este talento não pode ser aplicado em qualquer magia conjurada espontaneamente (Feiticeiros, Bardos), pois isso aumenta o tempo de execução.', 1),

-- ACROBÁTICO [Geral]
('Acrobático', @TYPE_GEN, NULL, 'O personagem recebe +2 de bônus em todos os testes de Saltar e Acrobacia.', NULL, NULL, 1),

-- ACUIDADE COM ARMA [Geral]
('Acuidade com Arma', @TYPE_GEN, 'Bônus base de ataque +1', 'Quando estiver usando uma arma leve, um sabre, chicote ou corrente com cravos, pode usar o modificador de Destreza no lugar de Força nas jogadas de ataque.', NULL, 'Guerreiro pode escolher como talento adicional.', 1),

-- AFINIDADE COM ANIMAIS [Geral]
('Afinidade com Animais', @TYPE_GEN, NULL, 'O personagem recebe +2 de bônus em todos os testes de Adestrar Animais e Cavalgar.', NULL, NULL, 1),

-- AGARRAR APRIMORADO [Geral]
('Agarrar Aprimorado', @TYPE_GEN, 'Des 13, Ataque Desarmado Aprimorado', 'Não provoca ataque de oportunidade ao iniciar Agarrar. Recebe +4 de bônus em todos os testes de Agarrar.', 'Sem esse talento, provoca AdO ao iniciar Agarrar.', 'Guerreiro pode escolher como talento adicional. Monge recebe no 1° nível.', 1),

-- AMPLIA MAGIA [Metamágico]
('Ampliar Magia', @TYPE_META, NULL, 'Pode aumentar a área de efeito da magia em 100%. Ocupa vaga de magia três níveis superior.', NULL, NULL, 1),

-- APANHAR OBJETOS [Geral]
('Apanhar Objetos', @TYPE_GEN, 'Des 15, Desviar Objetos, Ataque Desarmado Aprimorado', 'Quando usar Desviar Objetos, pode apanhar a arma/projétil. Pode arremessar de volta imediatamente. Requer uma mão livre.', NULL, 'Guerreiro pode escolher como talento adicional.', 1),

-- APTIDÃO MÁGICA [Geral]
('Aptidão Mágica', @TYPE_GEN, NULL, 'Recebe +2 de bônus em testes de Identificar Magia e Usar Instrumento Mágico.', NULL, NULL, 1),

-- ARQUEARIA MONTADA [Geral]
('Arquearia Montada', @TYPE_GEN, '1 graduação em Cavalgar, Combate Montado', 'Penalidade para ataque à distância em montaria reduzida à metade (-2 movimento dobrado, -4 correndo).', NULL, 'Guerreiro pode escolher como talento adicional.', 1),

-- ATAQUE ATORDOANTE [Geral]
('Ataque Atordoante', @TYPE_GEN, 'Des 13, Sab 13, Ataque Desarmado Aprimorado, BBA +8', 'Pode atordoar oponente com ataque desarmado (Fort CD 10+1/2 nível+Sab). Atordoado por 1 rodada. 1 uso/4 níveis/dia. Imune a críticos não pode ser atordoado.', NULL, 'Guerreiro pode escolher como talento adicional. Monge pode escolher como bônus.', 1),

-- ATAQUE COM ESCUDO APRIMORADO [Geral]
('Ataque com Escudo Aprimorado', @TYPE_GEN, 'Usar Escudos', 'Quando atacar com escudo, conserva o bônus de escudo na CA.', 'Sem talento, perde bônus de CA ao atacar com escudo.', 'Guerreiro pode escolher como talento adicional.', 1),

-- ATAQUE DESARMADO APRIMORADO [Geral]
('Ataque Desarmado Aprimorado', @TYPE_GEN, NULL, 'Considerado armado mesmo desarmado (não provoca AdO). Pode causar dano letal ou contusão.', 'Ataque desarmado provoca AdO e causa apenas contusão.', 'Guerreiro pode escolher como talento adicional. Monge recebe automaticamente.', 1),

-- ATAQUE EM MOVIMENTO [Geral]
('Ataque em Movimento', @TYPE_GEN, 'Des 13, Esquiva, Mobilidade, BBA +4', 'Ao realizar ataque regular, pode se mover antes e depois do ataque, desde que o total não exceda o deslocamento.', NULL, 'Guerreiro pode escolher como talento adicional.', 1),

-- ATAQUE GIRATÓRIO [Geral]
('Ataque Giratório', @TYPE_GEN, 'Des 13, Int 13, Especialização em Combate, Esquiva, Mobilidade, Ataque em Movimento, BBA +4', 'Como ação de ataque total, desfere um único ataque contra cada oponente ao alcance.', NULL, 'Guerreiro pode escolher como talento adicional.', 1),

-- ATAQUE PODEROSO [Geral]
('Ataque Poderoso', @TYPE_GEN, 'For 13', 'Pode subtrair valor do ataque e adicionar ao dano (limitado pelo BBA). Armas de duas mãos: dobro do valor no dano.', NULL, 'Guerreiro pode escolher como talento adicional.', 1),

-- ATLÉTICO [Geral]
('Atlético', @TYPE_GEN, NULL, 'Recebe +2 de bônus em testes de Escalar e Natação.', NULL, NULL, 1),

-- ATROPELAR APRIMORADO [Geral]
('Atropelar Aprimorado', @TYPE_GEN, 'For 13, Ataque Poderoso', 'Vítima não pode evitar atropelamento. Recebe +4 de bônus no teste de Força para derrubar.', 'Vítima pode evitar ou bloquear.', 'Guerreiro pode escolher como talento adicional.', 1),

-- AUMENTAR MAGIA [Metamágico]
('Aumentar Magia', @TYPE_META, NULL, 'Aumenta o alcance da magia em 100%. Ocupa vaga de magia um nível superior.', NULL, NULL, 1),

-- AUTO-SUFICIENTE [Geral]
('Auto-Suficiente', @TYPE_GEN, NULL, 'Recebe +2 de bônus em testes de Cura e Sobrevivência.', NULL, NULL, 1),

-- BLOQUEIO AMBIDESTRO [Geral]
('Bloqueio Ambidestro', @TYPE_GEN, 'Des 15, Combater com Duas Armas', 'Recebe +1 bônus de escudo na CA ao usar duas armas (ou arma dupla). +2 se combatendo defensivamente.', NULL, 'Guerreiro pode escolher como talento adicional.', 1),

-- COMBATE MONTADO [Geral]
('Combate Montado', @TYPE_GEN, '1 graduação em Cavalgar', 'Uma vez por rodada, pode negar um ataque à montaria com um teste de Cavalgar superior à jogada de ataque.', NULL, 'Guerreiro pode escolher como talento adicional.', 1),

-- COMBATER COM DUAS ARMAS [Geral]
('Combater com Duas Armas', @TYPE_GEN, 'Des 15', 'Reduz penalidades de combate com duas armas (Mão hábil -2, Inábil -6).', 'Veja Tabela de Penalidades.', 'Guerreiro pode escolher como talento adicional. Ranger 2 recebe se usar armadura leve.', 1),

-- COMBATER COM DUAS ARMAS APRIMORADO [Geral]
('Combater com Duas Armas Aprimorado', @TYPE_GEN, 'Des 17, Combater com Duas Armas, BBA +6', 'Recebe segundo ataque com a mão inábil (penalidade -5).', NULL, 'Guerreiro pode escolher como talento adicional. Ranger 6 recebe.', 1),

-- COMBATER COM DUAS ARMAS MAIOR [Geral]
('Combater com Duas Armas Maior', @TYPE_GEN, 'Des 19, Combater com Duas Armas Aprimorado, BBA +11', 'Recebe terceiro ataque com a mão inábil (penalidade -10).', NULL, 'Guerreiro pode escolher como talento adicional. Ranger 11 recebe.', 1),

-- CONTRAMÁGICA APRIMORADA [Geral]
('Contramágica Aprimorada', @TYPE_GEN, NULL, 'Pode usar contramágica com qualquer magia da mesma escola de nível superior.', 'Só pode usar a mesma magia para contramágica.', NULL, 1),

-- CORRIDA [Geral]
('Corrida', @TYPE_GEN, NULL, 'Corre 5x deslocamento (leve/sem) ou 4x (média/pesada). +4 em Saltar com corrida. Mantém Des na CA correndo.', 'Corre 4x ou 3x e perde Des na CA.', NULL, 1),

-- CRIAR ARMADURAS E ARMAS MÁGICAS [Criação de Item]
('Criar Armaduras e Armas Mágicas', @TYPE_ITEM, '5° nível de conjurador', 'Pode criar armas, armaduras e escudos mágicos. Custo: 1/25 preço em XP, 1/2 em matéria-prima. Exige Obra-prima.', NULL, NULL, 1),

-- CRIAR BASTÃO [Criação de Item]
('Criar Bastão', @TYPE_ITEM, '9° nível de conjurador', 'Pode criar bastões mágicos.', NULL, NULL, 1),

-- CRIAR CAJADO [Criação de Item]
('Criar Cajado', @TYPE_ITEM, '12° nível de conjurador', 'Pode criar cajados mágicos.', NULL, NULL, 1),

-- CRIAR ITEM MARAVILHOSO [Criação de Item]
('Criar Item Maravilhoso', @TYPE_ITEM, '3° nível de conjurador', 'Pode criar itens maravilhosos.', NULL, NULL, 1),

-- CRIAR VARINHA [Criação de Item]
('Criar Varinha', @TYPE_ITEM, '5° nível de conjurador', 'Pode criar varinhas (magias até 4° nível).', NULL, NULL, 1),

-- DEDOS LÉPIDOS [Geral]
('Dedos Lépidos', @TYPE_GEN, NULL, 'Recebe +2 de bônus em testes de Operar Mecanismo e Abrir Fechaduras.', NULL, NULL, 1),

-- DESARME APRIMORADO [Geral]
('Desarme Aprimorado', @TYPE_GEN, 'Int 13, Especialização em Combate', 'Não provoca AdO ao desarmar. Oponente não pode contra-desarmar se falhar. Recebe +4 no teste.', 'Provoca AdO.', 'Guerreiro: Bônus.', 1),

-- DESVIAR OBJETOS [Geral]
('Desviar Objetos', @TYPE_GEN, 'Des 13, Ataque Desarmado Aprimorado', 'Uma vez por rodada, pode desviar uma arma de ataque à distância (dano 0). Requer mão livre.', NULL, 'Guerreiro: Bônus. Monge: Nível 2.', 1),

-- DILIGENTE [Geral]
('Diligente', @TYPE_GEN, NULL, 'Recebe +2 de bônus em testes de Avaliação e Decifrar Escrita.', NULL, NULL, 1),

-- DOMINAR MAGIA [Especial]
('Dominar Magia', @TYPE_SPEC, '1° nível de mago', 'Prepara Int magias sem grimório.', 'Mago precisa de grimório.', NULL, 1),

-- DURO DE MATAR [Geral]
('Duro de Matar', @TYPE_GEN, 'Tolerância', 'Estabiliza automaticamente entre -1 e -9. Pode agir incapacitado.', 'Inconsciente e morrendo entre -1 e -9.', NULL, 1),

-- ELEVAR MAGIA [Metamágico]
('Elevar Magia', @TYPE_META, NULL, 'Prepara magia como de nível superior (CD e efeitos baseados em nível aumentam).', NULL, NULL, 1),

-- ENCONTRÃO APRIMORADO [Geral]
('Encontrão Aprimorado', @TYPE_GEN, 'For 13, Ataque Poderoso', 'Não provoca AdO com Encontrão. Recebe +4 no teste de Força.', 'Provoca AdO.', 'Guerreiro: Bônus.', 1),

-- ESCREVER PERGAMINHO [Criação de Item]
('Escrever Pergaminho', @TYPE_ITEM, '1° nível de conjurador', 'Pode criar pergaminhos mágicos.', NULL, 'Mago recebe no 1° nível.', 1),

-- ESPECIALIZAÇÃO EM ARMA [Geral]
('Especialização em Arma', @TYPE_GEN, 'Usar Arma, Foco em Arma, Guerreiro 4', 'Recebe +2 de bônus no dano com a arma escolhida.', NULL, 'Pode escolher múltiplas vezes (armas diferentes). Exclusivo de Guerreiro.', 1),

-- ESPECIALIZAÇÃO EM ARMA MAIOR [Geral]
('Especialização em Arma Maior', @TYPE_GEN, 'Especialização em Arma, Foco em Arma Maior, Guerreiro 12', 'Recebe +2 de bônus no dano (cumulativo, total +4).', NULL, 'Guerreiro: Bônus.', 1),

-- ESPECIALIZAÇÃO EM COMBATE [Geral]
('Especialização em Combate', @TYPE_GEN, 'Int 13', 'Pode subtrair até 5 do ataque e adicionar à CA (esquiva).', NULL, 'Guerreiro: Bônus.', 1),

-- ESQUIVA [Geral]
('Esquiva', @TYPE_GEN, 'Des 13', 'Recebe +1 de bônus de esquiva na CA contra um oponente escolhido.', NULL, 'Guerreiro: Bônus.', 1),

-- ESTENDER MAGIA [Metamágico]
('Estender Magia', @TYPE_META, NULL, 'Duração da magia é dobrada. Ocupa vaga um nível superior.', NULL, NULL, 1),

-- EXPULSÃO ADICIONAL [Geral]
('Expulsão Adicional', @TYPE_GEN, 'Expulsar/Fascinar Criaturas', '+4 tentativas diárias de expulsão.', NULL, 'Cumulativo.', 1),

-- EXPULSÃO APRIMORADA [Geral]
('Expulsão Aprimorada', @TYPE_GEN, 'Expulsar/Fascinar Criaturas', '+1 nível efetivo para testes de expulsão.', NULL, NULL, 1),

-- FINTAR APRIMORADO [Geral]
('Fintar Aprimorado', @TYPE_GEN, 'Int 13, Especialização em Combate', 'Fintar é uma ação de movimento.', 'Fintar é ação padrão.', 'Guerreiro: Bônus.', 1),

-- FOCO EM ARMA [Geral]
('Foco em Arma', @TYPE_GEN, 'Usar Arma, BBA +1', 'Recebe +1 de bônus na jogada de ataque com a arma.', NULL, 'Guerreiro: Bônus.', 1),

-- FOCO EM ARMA MAIOR [Geral]
('Foco em Arma Maior', @TYPE_GEN, 'Foco em Arma, Guerreiro 8', 'Recebe +1 de bônus no ataque (cumulativo, total +2).', NULL, 'Guerreiro: Bônus.', 1),

-- FOCO EM MAGIA [Geral]
('Foco em Magia', @TYPE_GEN, NULL, '+1 na CD dos testes de resistência da escola escolhida.', NULL, NULL, 1),

-- FOCO EM MAGIA MAIOR [Geral]
('Foco em Magia Maior', @TYPE_GEN, 'Foco em Magia', '+1 na CD (cumulativo, total +2).', NULL, NULL, 1),

-- FOCO EM PERÍCIA [Geral]
('Foco em Perícia', @TYPE_GEN, NULL, '+3 de bônus nos testes da perícia escolhida.', NULL, NULL, 1),

-- FORJAR ANEL [Criação de Item]
('Forjar Anel', @TYPE_ITEM, '12° nível de conjurador', 'Pode criar anéis mágicos.', NULL, NULL, 1),

-- FORTITUDE MAIOR [Geral]
('Fortitude Maior', @TYPE_GEN, NULL, '+2 em testes de Fortitude.', NULL, NULL, 1),

-- FRAUDULENTO [Geral]
('Fraudulento', @TYPE_GEN, NULL, '+2 em testes de Disfarces e Falsificação.', NULL, NULL, 1),

-- IGNORAR COMPONENTES MATERIAIS [Geral]
('Ignorar Componentes Materiais', @TYPE_GEN, NULL, 'Conjura magias sem componentes materiais (custo <= 1 PO).', NULL, NULL, 1),

-- IMOBILIZAÇÃO APRIMORADA [Geral]
('Imobilização Aprimorada', @TYPE_GEN, 'Int 13, Especialização em Combate', 'Não provoca AdO ao Imobilizar. +4 no teste. Se tiver sucesso, pode atacar imediatamente.', 'Provoca AdO.', 'Guerreiro: Bônus.', 1),

-- INICIATIVA APRIMORADA [Geral]
('Iniciativa Aprimorada', @TYPE_GEN, NULL, '+4 em testes de Iniciativa.', NULL, 'Guerreiro: Bônus.', 1),

-- INVESTIDA IMPLACÁVEL [Geral]
('Investida Implacável', @TYPE_GEN, '1 grad em Cavalgar, Combate Montado, Investida Montada', 'Dano dobrado em investida montada (x3 com lança).', NULL, 'Guerreiro: Bônus.', 1),

-- INVESTIDA MONTADA [Geral]
('Investida Montada', @TYPE_GEN, '1 grad em Cavalgar, Combate Montado', 'Pode mover-se antes e depois de um ataque na investida montada.', NULL, 'Guerreiro: Bônus.', 1),

-- INVESTIGADOR [Geral]
('Investigador', @TYPE_GEN, NULL, '+2 em testes de Obter Informação e Procurar.', NULL, NULL, 1),

-- LIDERANÇA [Geral]
('Liderança', @TYPE_GEN, '6° nível', 'Atrai parceiros (cohort) e seguidores.', NULL, NULL, 1),

-- LUTAR ÀS CEGAS [Geral]
('Lutar às Cegas', @TYPE_GEN, NULL, 'Pode jogar novamente chance de falha por camuflagem. Não perde Des na CA contra invisíveis em corpo-a-corpo.', NULL, 'Guerreiro: Bônus.', 1),

-- MAGIA NATURAL [Geral]
('Magia Natural', @TYPE_GEN, 'Sab 13, Forma Selvagem', 'Pode conjurar magias na forma selvagem.', NULL, NULL, 1),

-- MAGIA PENETRANTE [Geral]
('Magia Penetrante', @TYPE_GEN, NULL, '+2 nos testes para superar Resistência à Magia.', NULL, NULL, 1),

-- MAGIA PENETRANTE MAIOR [Geral]
('Magia Penetrante Maior', @TYPE_GEN, 'Magia Penetrante', '+2 nos testes para superar RM (cumulativo, total +4).', NULL, NULL, 1),

-- MAGIA SEM GESTOS [Metamágico]
('Magia Sem Gestos', @TYPE_META, NULL, 'Conjura sem componente gestual. Vaga um nível superior.', NULL, NULL, 1),

-- MAGIA SILENCIOSA [Metamágico]
('Magia Silenciosa', @TYPE_META, NULL, 'Conjura sem componente verbal. Vaga um nível superior.', NULL, 'Bardo não pode usar.', 1),

-- MAGIAS EM COMBATE [Geral]
('Magias em Combate', @TYPE_GEN, NULL, '+4 em Concentração para conjurar na defensiva.', NULL, NULL, 1),

-- MÃOS LEVES [Geral]
('Mãos Leves', @TYPE_GEN, NULL, '+2 em Prestidigitação e Usar Cordas.', NULL, NULL, 1),

-- MAXIMIZAR MAGIA [Metamágico]
('Maximizar Magia', @TYPE_META, NULL, 'Variáveis numéricas maximizadas. Vaga três níveis superior.', NULL, NULL, 1),

-- MOBILIDADE [Geral]
('Mobilidade', @TYPE_GEN, 'Des 13, Esquiva', '+4 na CA contra AdO por movimento.', NULL, 'Guerreiro: Bônus.', 1),

-- NEGOCIADOR [Geral]
('Negociador', @TYPE_GEN, NULL, '+2 em Diplomacia e Sentir Motivação.', NULL, NULL, 1),

-- PERSUASIVO [Geral]
('Persuasivo', @TYPE_GEN, NULL, '+2 em Blefar e Intimidação.', NULL, NULL, 1),

-- PISOTEAR [Geral]
('Pisotear', @TYPE_GEN, '1 grad em Cavalgar, Combate Montado', 'Vítima não pode evitar atropelamento montado. Montaria faz ataque com cascos contra derrubados.', NULL, 'Guerreiro: Bônus.', 1),

-- POTENCIALIZAR INVOCAÇÃO [Geral]
('Potencializar Invocação', @TYPE_GEN, 'Foco em Magia (Conjuração)', 'Criaturas invocadas ganham +4 For e +4 Con.', NULL, NULL, 1),

-- POTENCIALIZAR MAGIA [Metamágico]
('Potencializar Magia', @TYPE_META, NULL, 'Efeitos numéricos aumentados em 50%. Vaga dois níveis superior.', NULL, NULL, 1),

-- PREPARAR POÇÃO [Criação de Item]
('Preparar Poção', @TYPE_ITEM, '3° nível de conjurador', 'Pode criar poções (até 3° nível).', NULL, NULL, 1),

-- PRONTIDÃO [Geral]
('Prontidão', @TYPE_GEN, NULL, '+2 em Ouvir e Observar.', NULL, 'Mestre de familiar ganha se próximo.', 1),

-- RAPIDEZ DE RECARGA [Geral]
('Rapidez de Recarga', @TYPE_GEN, 'Usar Besta', 'Recarrega bestas mais rápido (Livre/Movimento). Permite ataques múltiplos.', NULL, 'Guerreiro: Bônus.', 1),

-- RASTREAR [Geral]
('Rastrear', @TYPE_GEN, NULL, 'Usa Sobrevivência para seguir rastros difíceis (CD > 10).', 'Sem talento, CD máx 10.', 'Ranger recebe.', 1),

-- REFLEXOS DE COMBATE [Geral]
('Reflexos de Combate', @TYPE_GEN, NULL, 'AdO adicionais igual mod Des. Pode fazer AdO surpreso.', 'Apenas 1 AdO/rodada.', 'Guerreiro: Bônus. Monge: Nível 2.', 1),

-- REFLEXOS RÁPIDOS [Geral]
('Reflexos Rápidos', @TYPE_GEN, NULL, '+2 em testes de Reflexos.', NULL, NULL, 1),

-- SAQUE RÁPIDO [Geral]
('Saque Rápido', @TYPE_GEN, 'BBA +1', 'Saca arma como ação livre.', 'Ação de movimento.', 'Guerreiro: Bônus.', 1),

-- SEPARAR APRIMORADO [Geral]
('Separar Aprimorado', @TYPE_GEN, 'For 13, Ataque Poderoso', 'Não provoca AdO ao Separar. +4 no ataque.', 'Provoca AdO.', 'Guerreiro: Bônus.', 1),

-- SORRATEIRO [Geral]
('Sorrateiro', @TYPE_GEN, NULL, '+2 em Esconder-se e Furtividade.', NULL, NULL, 1),

-- SUCESSO DECISIVO APRIMORADO [Geral]
('Sucesso Decisivo Aprimorado', @TYPE_GEN, 'Usar Arma, BBA +8', 'Dobra a margem de ameaça da arma.', NULL, 'Guerreiro: Bônus.', 1),

-- TIRO CERTEIRO [Geral]
('Tiro Certeiro', @TYPE_GEN, NULL, '+1 ataque e dano à distância até 9m.', NULL, 'Guerreiro: Bônus.', 1),

-- TIRO EM MOVIMENTO [Geral]
('Tiro em Movimento', @TYPE_GEN, 'Des 13, Esquiva, Mobilidade, Tiro Certeiro, BBA +4', 'Pode mover-se antes e depois de ataque à distância.', NULL, 'Guerreiro: Bônus.', 1),

-- TIRO LONGO [Geral]
('Tiro Longo', @TYPE_GEN, 'Tiro Certeiro', 'Incremento de distância aumenta 50% (projéteis) ou 100% (arremesso).', NULL, 'Guerreiro: Bônus.', 1),

-- TIRO MÚLTIPLO [Geral]
('Tiro Múltiplo', @TYPE_GEN, 'Des 17, Tiro Certeiro, Tiro Rápido, BBA +6', 'Dispara duas ou mais flechas simultaneamente (penalidades aplicam). Ação Padrão.', NULL, 'Guerreiro: Bônus. Ranger 6 recebe.', 1),

-- TIRO PRECISO [Geral]
('Tiro Preciso', @TYPE_GEN, 'Tiro Certeiro', 'Não sofre -4 por atirar em combate corpo-a-corpo.', NULL, 'Guerreiro: Bônus.', 1),

-- TIRO PRECISO APRIMORADO [Geral]
('Tiro Preciso Aprimorado', @TYPE_GEN, 'Des 19, Tiro Preciso, BBA +11', 'Ignora cobertura e camuflagem (exceto totais).', NULL, 'Guerreiro: Bônus. Ranger 11 recebe.', 1),

-- TIRO RÁPIDO [Geral]
('Tiro Rápido', @TYPE_GEN, 'Des 13, Tiro Certeiro', 'Um ataque extra à distância na ação de ataque total (-2 em todos).', NULL, 'Guerreiro: Bônus. Ranger 2 recebe.', 1),

-- TOLERÂNCIA [Geral]
('Tolerância', @TYPE_GEN, NULL, '+4 em testes de resistência física (natação, corrida, fome, etc). Dorme de armadura leve/média.', NULL, 'Ranger 3 recebe.', 1),

-- TRESPASSAR [Geral]
('Trespassar', @TYPE_GEN, 'For 13, Ataque Poderoso', 'Se derrubar oponente, ganha ataque extra imediato.', NULL, 'Guerreiro: Bônus.', 1),

-- TRESPASSAR MAIOR [Geral]
('Trespassar Maior', @TYPE_GEN, 'For 13, Trespassar, BBA +4', 'Sem limite de ataques extras por trespassar na rodada.', NULL, 'Guerreiro: Bônus.', 1),

-- USAR ARMA COMUM [Geral]
('Usar Arma Comum', @TYPE_GEN, NULL, 'Sabe usar arma comum escolhida.', '-4 ataque sem talento.', 'Classes combatentes já possuem todas.', 1),

-- USAR ARMAS EXÓTICAS [Geral]
('Usar Armas Exóticas', @TYPE_GEN, 'BBA +1', 'Sabe usar arma exótica escolhida.', '-4 ataque sem talento.', 'Guerreiro: Bônus.', 1),

-- USAR ARMAS SIMPLES [Geral]
('Usar Armas Simples', @TYPE_GEN, NULL, 'Sabe usar todas armas simples.', '-4 ataque sem talento.', 'Quase todos possuem.', 1),

-- USAR ARMADURA (LEVE) [Geral]
('Usar Armadura (Leve)', @TYPE_GEN, NULL, 'Penalidade de armadura aplica apenas em perícias de movimento.', 'Penalidade aplica em ataques e todas pericias.', 'Quase todos possuem.', 1),

-- USAR ARMADURA (MÉDIA) [Geral]
('Usar Armadura (Média)', @TYPE_GEN, 'Usar Armadura (Leve)', 'Sabe usar armadura média.', NULL, 'Combatentes/Clérigos possuem.', 1),

-- USAR ARMADURA (PESADA) [Geral]
('Usar Armadura (Pesada)', @TYPE_GEN, 'Usar Armadura (Média)', 'Sabe usar armadura pesada.', NULL, 'Guerreiro/Paladino/Clérigo possuem.', 1),

-- USAR ESCUDO [Geral]
('Usar Escudo', @TYPE_GEN, NULL, 'Sabe usar escudos (pequeno, grande, broquel).', 'Penalidade aplica em ataques.', 'Padrão para muitas classes.', 1),

-- USAR ESCUDO DE CORPO [Geral]
('Usar Escudo de Corpo', @TYPE_GEN, 'Usar Escudo', 'Sabe usar escudo de corpo.', 'Penalidade aplica em ataques.', 'Guerreiro recebe.', 1),

-- VITALIDADE [Geral]
('Vitalidade', @TYPE_GEN, NULL, 'Recebe +3 PV.', NULL, 'Pode pegar múltiplas vezes.', 1),

-- VONTADE DE FERRO [Geral]
('Vontade de Ferro', @TYPE_GEN, NULL, '+2 em testes de Vontade.', NULL, NULL, 1);
