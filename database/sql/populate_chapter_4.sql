
-- POPULATE CHAPTER 4: SKILLS (DETAILED & COMPLETE)
-- Inserts or Updates all skills with Portuguese names and details.
-- UPDATED: Includes detailed descriptions from user text for Falsificação -> Usar Instrumento Mágico.

-- Set Variables for Abilities
SET @STR = (SELECT id FROM abilities WHERE abbreviation = 'STR');
SET @DEX = (SELECT id FROM abilities WHERE abbreviation = 'DEX');
SET @CON = (SELECT id FROM abilities WHERE abbreviation = 'CON');
SET @INT = (SELECT id FROM abilities WHERE abbreviation = 'INT');
SET @WIS = (SELECT id FROM abilities WHERE abbreviation = 'WIS');
SET @CHA = (SELECT id FROM abilities WHERE abbreviation = 'CHA');

-- CLEANUP dependencies first
DELETE FROM character_skills;
DELETE FROM class_skills;
DELETE FROM skills;
ALTER TABLE skills AUTO_INCREMENT = 1;

-- INSERT SKILLS
INSERT INTO skills (name, key_ability_id, trained_only, armor_check_penalty, description, synergy_text) VALUES
-- PART 1: Standard Summaries (A-E)
('Abrir Fechaduras', @DEX, 1, 0, 'O personagem é capaz de arrombar cadeados, fechaduras de combinação e descobrir segredos de trancas. Abrir uma fechadura exige uma ação de rodada completa. Especial: +2 com Dedos Lépidos.', NULL),
('Acrobacia', @DEX, 1, 1, 'O personagem é capaz de mergulhar, rolar, executar cambalhotas, rodopios e similares. É impossível utilizar esta perícia quando o deslocamento do personagem está reduzido.', '5 graduações concedem +2 em: Equilíbrio, Saltar.'),
('Adestrar Animais', @CHA, 1, 0, 'Essa perícia é utilizada para forçar um grupo de cavalos a puxar uma carroça, treinar um cão de guarda ou ensinar truques. Druidas e Rangers recebem +4 de bônus envolvendo companheiro animal.', '5 graduações concedem +2 em: Cavalgar, Empatia com a Natureza.'),
('Arte da Fuga', @DEX, 0, 1, 'Essa perícia é usada para escapar de amarras ou algemas, rastejar por espaços apertados ou fugir das garras de monstros que agarrem o personagem.', NULL),
('Atuação', @CHA, 0, 0, 'O personagem foi treinado em uma variedade de expressão artística (Dramaturgia, Música, etc). Bardos usam para inspirar coragem, competência, etc.', NULL),
('Avaliação', @INT, 0, 0, 'Essa perícia é usada para diferenciar uma antiguidade de uma velharia, estimar valores de gemas e obras de arte. Anões recebem +2 para pedra e metal.', NULL),
('Blefar', @CHA, 0, 0, 'Transformar fatos duvidosos em argumentos verossímeis, fintar em combate, criar distração para se esconder ou passar mensagens secretas.', '5 graduações concedem +2 em: Diplomacia, Disfarces (interpretar), Intimidação, Prestidigitação.'),
('Cavalgar', @DEX, 0, 0, 'Locomover-se sobre uma montaria. Guiar com os joelhos, permanecer na sela, combater montado, amortecer queda, etc. +2 com Afinidade com Animais.', NULL),
('Concentração', @CON, 0, 0, 'Utilizada para manter a atenção mental, conjurar magias em situações difíceis ou na defensiva para evitar ataques de oportunidade.', NULL),
('Conhecimento (Arcano)', @INT, 1, 0, 'Mistérios antigos, tradições mágicas, símbolos arcanos, dragões e bestas mágicas.', '5 graduações concedem +2 em: Identificar Magia.'),
('Conhecimento (Engenharia)', @INT, 1, 0, 'Construções, aquedutos, pontes, fortificações.', '5 graduações concedem +2 em: Procurar (portas secretas).'),
('Conhecimento (Masmorras)', @INT, 1, 0, 'Aberações, cavernas, limos, estudo das cavernas.', '5 graduações concedem +2 em: Sobrevivência (subterrâneo).'),
('Conhecimento (Geografia)', @INT, 1, 0, 'Terras, terrenos, climas, povos.', '5 graduações concedem +2 em: Sobrevivência (evitar perigos).'),
('Conhecimento (História)', @INT, 1, 0, 'Realeza, guerras, colônias, migrações, fundação de cidades.', '5 graduações concedem +2 em: Conhecimento de Bardo.'),
('Conhecimento (Local)', @INT, 1, 0, 'Lendas, personalidades, habitantes, leis, costumes, tradições, humanóides.', '5 graduações concedem +2 em: Obter Informação.'),
('Conhecimento (Natureza)', @INT, 1, 0, 'Animais, fadas, gigantes, humanóides monstruosos, plantas, estações.', '5 graduações concedem +2 em: Sobrevivência (superfície).'),
('Conhecimento (Nobreza)', @INT, 1, 0, 'Linhagens, heráldica, árvores genealógicas, realeza.', '5 graduações concedem +2 em: Diplomacia.'),
('Conhecimento (Religião)', @INT, 1, 0, 'Divindades, história mítica, tradições eclesiásticas, mortos-vivos.', '5 graduações concedem +2 em: Expulsar Mortos-vivos.'),
('Conhecimento (Planos)', @INT, 1, 0, 'Planos Interiores, Exteriores, Astral, Etéreo, extra-planares, magia planar.', '5 graduações concedem +2 em: Sobrevivência (outro plano).'),
('Cura', @WIS, 0, 0, 'Primeiros socorros (estabilizar), tratamento extenso (recuperação rápida), tratar ferimentos de estrepes, venenos e doenças.', NULL),
('Decifrar Escrita', @INT, 1, 0, 'Compreender runas, mensagens em idiomas desconhecidos ou códigos arcaicos. Exige 1 minuto.', '5 graduações concedem +2 em: Usar Instrumento Mágico (pergaminhos).'),
('Diplomacia', @CHA, 0, 0, 'Convencer, negociar e influenciar pessoas, alterando a atitude de PdMs (Hostil -> Amistoso etc).', NULL),
('Disfarces', @CHA, 0, 0, 'Alterar a aparência para se passar por outra pessoa. Resistido por Observar. +10 de bônus com magias de alteração de forma.', NULL),
('Equilíbrio', @DEX, 0, 1, 'Caminhar sobre superfícies estreitas ou instáveis. Se tiver 5 graduações, não fica surpreso enquanto se equilibra.', NULL),
('Escalar', @STR, 0, 1, 'Subir encostas ou muros. Deslocamento reduzido a 1/4. CD varia por superfície.', NULL),
('Esconder-se', @DEX, 0, 1, 'Desaparecer nas sombras e evitar ser visto. Resistido por Observar. Exige cobertura/camuflagem.', NULL),
('Falar Idioma', NULL, 1, 0, 'O personagem aprende um novo idioma a cada graduação. Não exige testes.', NULL),

-- PART 2: Detailed Descriptions from Text (F-U)
('Falsificação', @INT, 0, 0, 'Falsificar documentos ou detectar falsificações. Exige materiais de escrita, luz e tempo. Bônus: +8 para documentos genéricos, +4 para assinatura conhecida. Bônus com talento Fraudulento. Ação: 1 min (documento curto), 1d4 min/página (longo). O teste é feito em segredo pelo Mestre. Resistido por Falsificação do examinador. Restrição: Depende de idioma.', NULL),

('Furtividade', @DEX, 0, 1, 'Mover-se sem ser notado. Resistido por Ouvir. Metade do deslocamento sem penalidade; -5 para movimento maior (até normal). Impossível ao correr/atacar (-20). Penalidades por terreno barulhento (-2 a -5). Especial: +2 para Halflings; +2 com Talento Sorrateiro.', NULL),

('Identificar Magia', @INT, 1, 0, 'Identificar magias enquanto conjuradas (CD 15+Nível) ou ativas (CD 20+Nível). Identificar poções (CD 25, 1 min). Aprender magia de grimório (CD 15+Nível, 8h). Especial: +2 para magos na escola especialista; +2 com Aptidão Mágica. +2 se 5 grad. em Conhecimento (Arcano).', '5 graduações concedem +2 em: Usar Instrumento Mágico (pergaminhos).'),

('Intimidação', @CHA, 0, 0, 'Obrigar comportamento amigável (temporário) ou desmoralizar oponente em combate (abalado 1 rodada). Resistido por: 1d20 + Nível/DV + Sab + Mod. Medo. Efeito dura enquanto presente + 1d6x10 min. Ação: 1 min (interação), Padrão (combate). Tamanho afeta teste (+4/-4). Especial: +2 com Persuasivo. Imune a medo não pode ser intimidado.', '5 graduações em Blefar concedem +2 em: Intimidação.'),

('Natação', @STR, 0, 1, 'Nadar em águas calmas (CD 10), agitadas (CD 15) ou violentas (CD 20). Sucesso: 1/2 desl (ação completa) ou 1/4 (movimento). Falha por 5+ = submerge. Prender fôlego: Constituição rodadas. Sofre DOBRO da penalidade de armadura. +2 com Atlético.', NULL),

('Observar', @WIS, 0, 0, 'Notar criaturas escondidas (resistido por Esconder-se), ler labial (CD 15 base, requer idioma, 9m max). Penalidade de distância: -1 a cada 3m. Penalidade distraído: -5. Resultado 20+ nota invisível. Especial: +2 Elfos, +2 Prontidão. Rangers têm bônus contra inimigos.', NULL),

('Obter Informação', @CHA, 0, 0, 'Fazer contatos e recolher rumores. CD 10 (geral), 15-25+ (específico). Ação: 1d4+1 horas. Custa ouro. Especial: +2 Meio-Elfos, +2 Investigador. Sinergia: +2 se 5 grad. em Conhecimento (Local).', NULL),

('Ofícios', @INT, 0, 0, 'Fabricar itens (Armas, Armaduras, Alquimia, etc). CD varia (10 a 25+). Teste representa 1 semana. Progresso = Resultado * CD em Peças de Prata. Matéria-prima = 1/3 do preço. Falha por 5+ perde metade da matéria-prima. Obra-prima exige componente separado (CD 20). Especial: +2 Anões (pedra/metal), +2 Gnomos (alquimia).', '5 graduações concedem +2 em: Avaliação relacionada.'),

('Operar Mecanismo', @INT, 1, 0, 'Desativar armadilhas, emperrar fechaduras (CD 10), sabotar rodas (CD 15), desativar armadilhas mágicas (CD 25+Nível, só ladinos). Ação: varia (rodada completa a 2d4 rodadas). Sem ferramentas: -2. Ferramentas obra-prima: +2. Especial: +2 Dedos Lépidos.', NULL),

('Ouvir', @WIS, 0, 0, 'Escutar sons. Resistido por Furtividade ou CD fixa (Batalha -10, Falar 0, Sussurro 15). Penalidade distância: -1 a cada 3m. Através de porta +5, Parede +15. Dormindo sofre -10. Especial: +2 Elfos/Gnomos/Halflings; +2 Prontidão.', NULL),

('Prestidigitação', @DEX, 1, 1, 'Esconder objetos (CD 10+), furtar (CD 20). Resistido por Observar/Procurar. Objetos pequenos dão bônus (+4). Roupas largas (+2). Ação: Padrão (ou -20 como livre). Especial: +2 Mãos Leves. Bônus de sinergia de Blefar (+2).', NULL),

('Procurar', @INT, 0, 0, 'Encontrar portas secretas (CD 20+), armadilhas (CD 20+). Somente LADINOS acham armadilhas com CD > 20. Ação: Rodada completa por 1,5m². Especial: +2 Elfos, +2 Anões (pedra). +4 para achar armadilhas mágicas visuais (runas). Sinergia: +2 Conhecimento (Arquitetura) para portas secretas.', '5 graduações concedem +2 em: Sobrevivência (rastros).'),

('Profissão', @WIS, 1, 0, 'Exercer sustento (Cozinheiro, Marinheiro, etc). Ganha metade do teste em PO/semana. Ação: 1 semana. Sem treinamento ganha apenas 1 PP/dia (trabalho braçal).', NULL),

('Saltar', @STR, 0, 1, 'Salto em Distância (CD = Distância). Salto em Altura (CD = 4 x 30cm). Correr 6m antes evita dobrar a CD. Deslocamento afeta teste (+4 a cada 3m > 9m). Especial: +2 Halfling, +2 Acrobático, +4 Corrida (com corrida). Sinergia: +2 se 5 grad. em Acrobacia.', '5 graduações concedem +2 em: Acrobacia.'),

('Sentir Motivação', @WIS, 0, 0, 'Detectar blefe (Oposto), perceber encantamento (CD 25 ou 15), mensagem secreta (CD varia). Ação: 1 min (ou ação livre vs Blefe). Especial: +2 Negociador. Rangers têm bônus.', '5 graduações concedem +2 em: Diplomacia.'),

('Sobrevivência', @WIS, 0, 0, 'Rastrear (CD varia), evitar perigos/perder-se (CD 15), prever clima (CD 15). Sobreviver na natureza (CD 10, move 1/2). Rastrear CD alta requer TALENTO RASTREAR. Especial: +2 Auto-Suficiente. Sinergias de: Conhecimentos (Masmorras, Geografia, Natureza, Planos) e Procurar.', '5 graduações concedem +2 em: Conhecimento (Natureza).'),

('Usar Cordas', @DEX, 0, 0, 'Dar nós (CD 10), Arpéu (CD 10 + 2/3m). Amarrar criatura (Oposto vs Arte da Fuga + 10 bônus). Ação: Varia. Especial: +2 Seda, +2 Magia Animar Corda, +2 Mãos Leves. Sinergia para: Escalar e Arte da Fuga.', '5 graduações concedem +2 em: Escalar (corda), Arte da Fuga (corda).'),

('Usar Instrumento Mágico', @CHA, 1, 0, 'Ativar itens sem ter a classe (Varinha CD 20, Pergaminho CD 20+Nível). Simular habilidade (Nível-15), Raça (25), Tendência (30). Falha por 10+ = Fiasco (efeito errado/dano). Ativar às cegas (CD 25). Especial: +2 Aptidão Mágica. +2 se 5 grad. Decifrar Escrita/Identificar Magia (pergaminhos).', '5 graduações concedem +2 em: Identificar Magia (pergaminhos).');
