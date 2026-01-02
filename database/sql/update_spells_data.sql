SET FOREIGN_KEY_CHECKS=0;

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Abençoar Água', 'Esta transmutação imbui um frasco (0,5 litro)
de água com energia positiva, transformando-a em
água benta.
Componente Material: 2,5 kg de prata em pó (que
valem 25 PO).', 8, '', '[Bem]', '1 minuto', 'Toque', 'Alvo: Frasco de água tocado', 'Instantânea', 'Vontade anula (objeto)', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Esta transmutação imbui um frasco (0,5 litro)
de água com energia positiva, transformando-a em
água benta.
Componente Material: 2,5 kg de prata em pó (que
valem 25 PO).', 
    school_id=8, 
    subschool='', 
    descriptors='[Bem]', 
    casting_time='1 minuto',
    range_text='Toque',
    area_target_effect_text='Alvo: Frasco de água tocado',
    duration='Instantânea',
    saving_throw='Vontade anula (objeto)',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Abençoar Água');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Abençoar Água'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Abençoar Água'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Abençoar Água'), 3, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Abençoar Água'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (7, (SELECT id FROM spells WHERE name='Abençoar Água'), 1);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Abençoar Arma', 'Essa transmutação faz com que uma arma acerte
inimigos malignos com verdadeira precisão. A arma é
tratada como se tivesse +1 de bônus de melhoria para
ultrapassar a Redução de Dano de criatura malignas
ou para atacar criaturas incorpóreas malignas (embora
esta magia não conceda nenhum bônus de melhoria).
Além disso, a arma é considerada sagrada, possuindo
efeitos especiais contra cenas criaturas, particularmente
contra seres planares malignos (esse efeito neutraliza
e se sobrepõe a qualquer outra tendência que a arma
possui). As flechas ou virotes individuais podem ser
transmutadas, mas as armas de projétil (como os arcos)
transmutadas não conferem os benefícios aos projéteis
que disparam.
Além disso, todas as avaliações de sucessos decisivos
contra inimigos maus são automaticamente bem-suce-
didas (portanto, toda ameaça é um sucesso decisivo).
Esta transmutação não pode afetar armas que já tenham
efeitos mágicos relacionados a sucessos decisivos, como
uma arma afiada ou uma espada vorpal.', 8, '', '', '1 ação padrão', 'Toque', 'Alvo: Arma tocada', '1 minuto/nível', 'Nenhum', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='Essa transmutação faz com que uma arma acerte
inimigos malignos com verdadeira precisão. A arma é
tratada como se tivesse +1 de bônus de melhoria para
ultrapassar a Redução de Dano de criatura malignas
ou para atacar criaturas incorpóreas malignas (embora
esta magia não conceda nenhum bônus de melhoria).
Além disso, a arma é considerada sagrada, possuindo
efeitos especiais contra cenas criaturas, particularmente
contra seres planares malignos (esse efeito neutraliza
e se sobrepõe a qualquer outra tendência que a arma
possui). As flechas ou virotes individuais podem ser
transmutadas, mas as armas de projétil (como os arcos)
transmutadas não conferem os benefícios aos projéteis
que disparam.
Além disso, todas as avaliações de sucessos decisivos
contra inimigos maus são automaticamente bem-suce-
didas (portanto, toda ameaça é um sucesso decisivo).
Esta transmutação não pode afetar armas que já tenham
efeitos mágicos relacionados a sucessos decisivos, como
uma arma afiada ou uma espada vorpal.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Toque',
    area_target_effect_text='Alvo: Arma tocada',
    duration='1 minuto/nível',
    saving_throw='Nenhum',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Abençoar Arma');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Abençoar Arma'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Abençoar Arma'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (7, (SELECT id FROM spells WHERE name='Abençoar Arma'), 1);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Abrir/Fechar', 'O personagem pode abrir ou fechar (à sua escolha)
uma porta, baú, caixa, janela, sacola, bolsa, garrafa,
barril ou outro recipiente. Se qualquer coisa impedir
(como uma tranca na porta ou no baú), a magia
fracassa. Além disso, a magia só pode abrir ou fechar
objetos pesando 15 kg ou menos. Então portas, baús ou
objetos similares feitos para criaturas enormes podem
estar além da capacidade do efeito dessa magia. Foco:
Uma chave de bronze.', 8, '', '', '1 ação padrão', 'Curto (7,5 m + 1,5 m/2 níveis)', 'Alvo: Objeto pesando até 15 kg ou um portal', 'Instantânea', 'Vontade anula (objeto)', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='O personagem pode abrir ou fechar (à sua escolha)
uma porta, baú, caixa, janela, sacola, bolsa, garrafa,
barril ou outro recipiente. Se qualquer coisa impedir
(como uma tranca na porta ou no baú), a magia
fracassa. Além disso, a magia só pode abrir ou fechar
objetos pesando 15 kg ou menos. Então portas, baús ou
objetos similares feitos para criaturas enormes podem
estar além da capacidade do efeito dessa magia. Foco:
Uma chave de bronze.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Curto (7,5 m + 1,5 m/2 níveis)',
    area_target_effect_text='Alvo: Objeto pesando até 15 kg ou um portal',
    duration='Instantânea',
    saving_throw='Vontade anula (objeto)',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Abrir/Fechar');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Abrir/Fechar'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Abrir/Fechar'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Abrir/Fechar'), 4, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Abrir/Fechar'), 0);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Abrir/Fechar'), 0);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Abrir/Fechar'), 0);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Acalmar Animais', 'Esta magia acalma e aquieta animais, deixando-os
dóceis e inofensivos. Somente criaturas com Inteligência
de 1 ou 2 podem ser afetadas. Todos os alvos devem
ser da mesma espécie e estarem a menos de 9 m entre
si. Jogue 2d4 + nível de conjurador para determinar a
quantidade total de DV afetados. Os animais atrozes
ou treinados para atacar ou guardar podem realizar
um teste de resistência. Os animais que não tenham
sido treinados não têm direito ao teste (um druida
poderia acamar um urso ou lobo normal sem maiores
problemas, mas seria mais difícil afetar um cão de
guarda treinado).
As criaturas afetadas permanecem no local onde
estão e não atacam ou fogem. Elas não estão indefesas
e se defendem normalmente se forem atacadas. Qual-
quer ameaça (fogo, um predador faminto, um ataque
iminente) dissipa a magia.', 4, 'Compulsão', '[Ação Mental]', '1 ação padrão', 'Curto (7,5 m + 1,5 m/2 níveis)', 'Alvo: Animais a menos de 9 m entre si', '1 minuto/nível', 'Vontade anula (veja texto)', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Esta magia acalma e aquieta animais, deixando-os
dóceis e inofensivos. Somente criaturas com Inteligência
de 1 ou 2 podem ser afetadas. Todos os alvos devem
ser da mesma espécie e estarem a menos de 9 m entre
si. Jogue 2d4 + nível de conjurador para determinar a
quantidade total de DV afetados. Os animais atrozes
ou treinados para atacar ou guardar podem realizar
um teste de resistência. Os animais que não tenham
sido treinados não têm direito ao teste (um druida
poderia acamar um urso ou lobo normal sem maiores
problemas, mas seria mais difícil afetar um cão de
guarda treinado).
As criaturas afetadas permanecem no local onde
estão e não atacam ou fogem. Elas não estão indefesas
e se defendem normalmente se forem atacadas. Qual-
quer ameaça (fogo, um predador faminto, um ataque
iminente) dissipa a magia.', 
    school_id=4, 
    subschool='Compulsão', 
    descriptors='[Ação Mental]', 
    casting_time='1 ação padrão',
    range_text='Curto (7,5 m + 1,5 m/2 níveis)',
    area_target_effect_text='Alvo: Animais a menos de 9 m entre si',
    duration='1 minuto/nível',
    saving_throw='Vontade anula (veja texto)',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Acalmar Animais');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Acalmar Animais'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Acalmar Animais'), 2, '');

INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Acalmar Animais'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Acalmar Animais'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (8, (SELECT id FROM spells WHERE name='Acalmar Animais'), 1);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Acalmar Emoções', 'Esta magia acalma as criaturas agitadas. O conjura-
dor não tem controle sobre as criaturas afetadas, mas a
magia pode impedir que criaturas enraivecidas ataquem
ou que criaturas calmas se agitem. As criaturas afetadas
não podem realizar ações violentas (mas são capazes
de se defender) ou qualquer coisa destrutiva, exceto se
proteger. Qualquer ação agressiva ou dano que ameace
a vida da criatura dissipa a magia imediatamente.
Esta magia neutraliza imediatamente (mas não
dissipa) qualquer bônus de moral concedido por magias
como benção, boa esperança e fúria, além de anular a
habilidade de bardo de inspirar coragem e a fúria do
bárbaro. Ela também anula quaisquer efeitos de medo e
remove a condição de confusão dos seus alvos. Enquan-
to a magia permanecer ativa, as magias neutralizadas
não surtem efeito. Quando amimar emoções terminar,
a magia original volta a ser eficaz sobre a criatura – caso', 4, 'Compulsão', '[Ação Mental]', '1 ação padrão', 'Médio (30 m + 3 m/nível)', 'Área: Criaturas numa dispersão de 6 m de raio', 'Concentração, até 1 rodada/nível (D)', 'Vontade anula', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Esta magia acalma as criaturas agitadas. O conjura-
dor não tem controle sobre as criaturas afetadas, mas a
magia pode impedir que criaturas enraivecidas ataquem
ou que criaturas calmas se agitem. As criaturas afetadas
não podem realizar ações violentas (mas são capazes
de se defender) ou qualquer coisa destrutiva, exceto se
proteger. Qualquer ação agressiva ou dano que ameace
a vida da criatura dissipa a magia imediatamente.
Esta magia neutraliza imediatamente (mas não
dissipa) qualquer bônus de moral concedido por magias
como benção, boa esperança e fúria, além de anular a
habilidade de bardo de inspirar coragem e a fúria do
bárbaro. Ela também anula quaisquer efeitos de medo e
remove a condição de confusão dos seus alvos. Enquan-
to a magia permanecer ativa, as magias neutralizadas
não surtem efeito. Quando amimar emoções terminar,
a magia original volta a ser eficaz sobre a criatura – caso', 
    school_id=4, 
    subschool='Compulsão', 
    descriptors='[Ação Mental]', 
    casting_time='1 ação padrão',
    range_text='Médio (30 m + 3 m/nível)',
    area_target_effect_text='Área: Criaturas numa dispersão de 6 m de raio',
    duration='Concentração, até 1 rodada/nível (D)',
    saving_throw='Vontade anula',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Acalmar Emoções');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Acalmar Emoções'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Acalmar Emoções'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Acalmar Emoções'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Acalmar Emoções'), 2);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Acalmar Emoções'), 2);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (16, (SELECT id FROM spells WHERE name='Acalmar Emoções'), 2);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('sua duração não tenha terminado.', '', 3, '', '', '', '', '', '', '', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=3, 
    subschool='', 
    descriptors='', 
    casting_time='',
    range_text='',
    area_target_effect_text='',
    duration='',
    saving_throw='',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='sua duração não tenha terminado.');

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Adivinhação', '', 3, '', '', '10 minutos', 'Pessoal', 'Alvo: Você', 'Instantânea', '', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=3, 
    subschool='', 
    descriptors='', 
    casting_time='10 minutos',
    range_text='Pessoal',
    area_target_effect_text='Alvo: Você',
    duration='Instantânea',
    saving_throw='',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Adivinhação');
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Adivinhação'), 4);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (6, (SELECT id FROM spells WHERE name='Adivinhação'), 4);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Agilidade do Gato', 'A criatura transmutada se torna mais graciosa, ágil
e adquire maior coordenação. Esta magia concede +4
de bônus de aprimoramento na Destreza, adicionando
os benefícios normais na CA, testes de resistência de
Reflexos e outros usos do modificador de Destreza.
Componente Material: Um pouco de pêlo de
gato.', 8, '', '', '1 ação padrão', 'Toque', 'Alvo: Criatura tocada', 'l min/nível', 'Vontade anula (inofensiva)', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='A criatura transmutada se torna mais graciosa, ágil
e adquire maior coordenação. Esta magia concede +4
de bônus de aprimoramento na Destreza, adicionando
os benefícios normais na CA, testes de resistência de
Reflexos e outros usos do modificador de Destreza.
Componente Material: Um pouco de pêlo de
gato.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Toque',
    area_target_effect_text='Alvo: Criatura tocada',
    duration='l min/nível',
    saving_throw='Vontade anula (inofensiva)',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Agilidade do Gato');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Agilidade do Gato'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Agilidade do Gato'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Agilidade do Gato'), 3, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Agilidade do Gato'), 2);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Agilidade do Gato'), 2);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (8, (SELECT id FROM spells WHERE name='Agilidade do Gato'), 2);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Agilidade do Gato'), 2);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Agilidade do Gato'), 2);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Agilidade do Gato em Massa', '', 8, '', '', '', 'Curto (7,5 m + 1,5 m/2 níveis)', 'Alvo: 1 criatura/nível, todas a menos de 9 m', '', '', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='',
    range_text='Curto (7,5 m + 1,5 m/2 níveis)',
    area_target_effect_text='Alvo: 1 criatura/nível, todas a menos de 9 m',
    duration='',
    saving_throw='',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Agilidade do Gato em Massa');
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Agilidade do Gato em Massa'), 6);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Agilidade do Gato em Massa'), 6);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Agilidade do Gato em Massa'), 6);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Agilidade do Gato em Massa'), 6);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Ajuda', 'Essa magia concede ao alvo +1 de bônus de moral
para jogadas de ataque e testes de resistência contra
efeitos de medo, além de 1d8 + nível do conjurador
(máximo de +10) pontos de vida temporários.', 4, 'Compulsão', '[Ação-Mental]', '1 ação padrão', 'Toque', 'Alvo: Criatura viva tocada', '1 minuto/nível', 'Nenhum', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Essa magia concede ao alvo +1 de bônus de moral
para jogadas de ataque e testes de resistência contra
efeitos de medo, além de 1d8 + nível do conjurador
(máximo de +10) pontos de vida temporários.', 
    school_id=4, 
    subschool='Compulsão', 
    descriptors='[Ação-Mental]', 
    casting_time='1 ação padrão',
    range_text='Toque',
    area_target_effect_text='Alvo: Criatura viva tocada',
    duration='1 minuto/nível',
    saving_throw='Nenhum',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Ajuda');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Ajuda'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Ajuda'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Ajuda'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Ajuda'), 2);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Ajuda'), 2);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (20, (SELECT id FROM spells WHERE name='Ajuda'), 2);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Alarme', 'Essa magia emite um aviso mental ou audível
sempre que uma criatura de tamanho Miúdo ou maior
invadir ou tocar a área protegida. Uma criatura que
fale a senha (determinada no momento da conjuração)
não dispara o alarme. É preciso decidir se o alarme será
mental ou audível no momento da conjuração.
Alarme Mental: Um alarme mental alerta o conju-
rador (e somente ele) desde que esteja a menos de 1,5
km da área protegida. Ele receberá um aviso mental que
o acordará se estiver dormindo, mas não perturbará sua
concentração. Uma magia silêncio não tem efeito sobre
um alarme mental.
Alarme Audível: Um alarme audível produz o som
de uma sineta; qualquer criatura a menos de 18 m da
área protegida poderá ouvi-lo claramente. Reduza a
distância em 3 m para cada porta fechada e em 6 m a
cada parede entre a pessoa e o alarme. Em condições
silenciosas, o som pode ser ouvido a até 54 m de distân-
cia. O alarme continua durante 1 rodada. As criaturas
dentro da área de uma magia silêncio não conseguem
ouvir o alarme.
As criaturas etéreas ou astrais não disparam o
alarme.
O alarme pode se tornar permanente através da
magia permanência.
Focos: Um pequeno sino e um fio de prata bem
fino.', 1, '', '', '1 ação padrão', 'Curto (7,5 m +1,5 m/2 níveis)', 'Área: Emanação de 6 m de raio centrada em um', '2 horas/nível (D)', 'Nenhum', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='Essa magia emite um aviso mental ou audível
sempre que uma criatura de tamanho Miúdo ou maior
invadir ou tocar a área protegida. Uma criatura que
fale a senha (determinada no momento da conjuração)
não dispara o alarme. É preciso decidir se o alarme será
mental ou audível no momento da conjuração.
Alarme Mental: Um alarme mental alerta o conju-
rador (e somente ele) desde que esteja a menos de 1,5
km da área protegida. Ele receberá um aviso mental que
o acordará se estiver dormindo, mas não perturbará sua
concentração. Uma magia silêncio não tem efeito sobre
um alarme mental.
Alarme Audível: Um alarme audível produz o som
de uma sineta; qualquer criatura a menos de 18 m da
área protegida poderá ouvi-lo claramente. Reduza a
distância em 3 m para cada porta fechada e em 6 m a
cada parede entre a pessoa e o alarme. Em condições
silenciosas, o som pode ser ouvido a até 54 m de distân-
cia. O alarme continua durante 1 rodada. As criaturas
dentro da área de uma magia silêncio não conseguem
ouvir o alarme.
As criaturas etéreas ou astrais não disparam o
alarme.
O alarme pode se tornar permanente através da
magia permanência.
Focos: Um pequeno sino e um fio de prata bem
fino.', 
    school_id=1, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Curto (7,5 m +1,5 m/2 níveis)',
    area_target_effect_text='Área: Emanação de 6 m de raio centrada em um',
    duration='2 horas/nível (D)',
    saving_throw='Nenhum',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Alarme');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Alarme'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Alarme'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Alarme'), 4, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Alarme'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Alarme'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (8, (SELECT id FROM spells WHERE name='Alarme'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Alarme'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Alarme'), 1);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Aliado Extra-Planar', '', 2, 'Convocação', '[veja o texto para aliado', '', '', 'Efeito: Um ou dois elementais ou criaturas plana-', '', '', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=2, 
    subschool='Convocação', 
    descriptors='[veja o texto para aliado', 
    casting_time='',
    range_text='',
    area_target_effect_text='Efeito: Um ou dois elementais ou criaturas plana-',
    duration='',
    saving_throw='',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Aliado Extra-Planar');
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Aliado Extra-Planar'), 6);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Aliado Extra-Planar Maior', '', 2, 'Convocação', '[veja o texto para', '', '', 'Efeito: Até três elementais ou criaturas planares', '', '', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=2, 
    subschool='Convocação', 
    descriptors='[veja o texto para', 
    casting_time='',
    range_text='',
    area_target_effect_text='Efeito: Até três elementais ou criaturas planares',
    duration='',
    saving_throw='',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Aliado Extra-Planar Maior');
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Aliado Extra-Planar Maior'), 8);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Aliado Extra-Planar Menor', 'Através dessa magia, o personagem solicita que sua
divindade envie um elemental ou criatura planar (de
6 DV ou menos), a escolha da divindade. Se o perso-
nagem não servir a nenhum deus específico, a magia
é um pedido genérico atendido por uma criatura que
compartilhe a mesma tendência filosófica que ele. Se
souber o nome de uma criatura específica, o persona-
gem pode solicitá-la dizendo seu nome durante a magia
(embora seja possível obter uma criatura diferente de
qualquer forma).
O personagem solicita à criatura que realize uma
tarefa em troca de um pagamento. As tarefas podem se
simples (leve-nos voando através do abismo ou ajude-
nos na batalha) ou complexas (espione nosso inimigo
ou proteja-nos em nossa aventura nessa masmorra).
O personagem deve ser capaz de se comunicar com a
criatura para realizar os acordos sobre as tarefas.
A criatura convocada requisita um pagamento por
seus serviços. Esse pagamento pode ter várias formas:
uma doação de ouro ou itens mágicos a um templo
aliado, um presente diretamente à criatura ou alguma
outra ação por parte do personagem que combine com
a tendência e os objetivos da criatura. Independente
disso, esse pagamento deve ser feito antes da criatura
concordar em realizar qualquer serviço. Essa negocia-
ção exige pelo menos 1 rodada, então qualquer ação
realizada pela criatura começa uma rodada depois de
sua convocação.
Uma tarefa que gaste 1 minuto por nível de
conjurador requer um pagamento de 100 PO por
DV da criatura convocada. Para as tarefas que exijam
mais de uma hora por nível do conjurador, a criatura
solicita um pagamento de 500 PO por Dado de Vida.
Uma tarefa muito longa, que demore até um dia por
nível do conjurador, exigirá um pagamento de 1.000
PO por DV.
Uma tarefa sem riscos exige apenas metade desse
pagamento, enquanto uma especialmente arriscada re-
quer um presente maior. Poucas criaturas aceitam uma
tarefa que pareça suicídio (lembre-se que as criaturas
convocadas realmente são eliminadas quando morrem,
diferente das criaturas invocadas). Entretanto, se uma
tarefa está fortemente relacionada com a ética da cria-
tura, o Mestre poderia reduzir ou mesmo não solicitar
um pagamento. Por exemplo, uma criatura celestial
convocada para lutar contra demônios poderia exigir
um presente com apenas metade do valor normal.
No final da tarefa ou quando a duração do acordo
terminar, a criatura retorna para seu plano de origem
(depois de informar o personagem caso seja apropriado
e possível).
Observação: Quando o personagem utiliza essa
magia para convocar uma criatura do ar, do caos, da
terra, do mal, do fogo, do bem, da ordem ou da água,
a magia se torna uma magia do tipo da criatura. Por
exemplo, aliado extra-planar menor é uma magia de
fogo quando convoca um elemental do fogo.
Custo de XP: 100 XP.', 2, 'Convocação', '[veja texto]', '10 minutos', 'Curto (7,5 metros + 1,5 metro/2', 'Efeito: Um elemental ou criatura planar convo-', 'Instantânea', 'Nenhum', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='Através dessa magia, o personagem solicita que sua
divindade envie um elemental ou criatura planar (de
6 DV ou menos), a escolha da divindade. Se o perso-
nagem não servir a nenhum deus específico, a magia
é um pedido genérico atendido por uma criatura que
compartilhe a mesma tendência filosófica que ele. Se
souber o nome de uma criatura específica, o persona-
gem pode solicitá-la dizendo seu nome durante a magia
(embora seja possível obter uma criatura diferente de
qualquer forma).
O personagem solicita à criatura que realize uma
tarefa em troca de um pagamento. As tarefas podem se
simples (leve-nos voando através do abismo ou ajude-
nos na batalha) ou complexas (espione nosso inimigo
ou proteja-nos em nossa aventura nessa masmorra).
O personagem deve ser capaz de se comunicar com a
criatura para realizar os acordos sobre as tarefas.
A criatura convocada requisita um pagamento por
seus serviços. Esse pagamento pode ter várias formas:
uma doação de ouro ou itens mágicos a um templo
aliado, um presente diretamente à criatura ou alguma
outra ação por parte do personagem que combine com
a tendência e os objetivos da criatura. Independente
disso, esse pagamento deve ser feito antes da criatura
concordar em realizar qualquer serviço. Essa negocia-
ção exige pelo menos 1 rodada, então qualquer ação
realizada pela criatura começa uma rodada depois de
sua convocação.
Uma tarefa que gaste 1 minuto por nível de
conjurador requer um pagamento de 100 PO por
DV da criatura convocada. Para as tarefas que exijam
mais de uma hora por nível do conjurador, a criatura
solicita um pagamento de 500 PO por Dado de Vida.
Uma tarefa muito longa, que demore até um dia por
nível do conjurador, exigirá um pagamento de 1.000
PO por DV.
Uma tarefa sem riscos exige apenas metade desse
pagamento, enquanto uma especialmente arriscada re-
quer um presente maior. Poucas criaturas aceitam uma
tarefa que pareça suicídio (lembre-se que as criaturas
convocadas realmente são eliminadas quando morrem,
diferente das criaturas invocadas). Entretanto, se uma
tarefa está fortemente relacionada com a ética da cria-
tura, o Mestre poderia reduzir ou mesmo não solicitar
um pagamento. Por exemplo, uma criatura celestial
convocada para lutar contra demônios poderia exigir
um presente com apenas metade do valor normal.
No final da tarefa ou quando a duração do acordo
terminar, a criatura retorna para seu plano de origem
(depois de informar o personagem caso seja apropriado
e possível).
Observação: Quando o personagem utiliza essa
magia para convocar uma criatura do ar, do caos, da
terra, do mal, do fogo, do bem, da ordem ou da água,
a magia se torna uma magia do tipo da criatura. Por
exemplo, aliado extra-planar menor é uma magia de
fogo quando convoca um elemental do fogo.
Custo de XP: 100 XP.', 
    school_id=2, 
    subschool='Convocação', 
    descriptors='[veja texto]', 
    casting_time='10 minutos',
    range_text='Curto (7,5 metros + 1,5 metro/2',
    area_target_effect_text='Efeito: Um elemental ou criatura planar convo-',
    duration='Instantânea',
    saving_throw='Nenhum',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Aliado Extra-Planar Menor');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aliado Extra-Planar Menor'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aliado Extra-Planar Menor'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aliado Extra-Planar Menor'), 5, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aliado Extra-Planar Menor'), 6, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Aliado Extra-Planar Menor'), 4);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Alterar Forma', '', 8, '', '', '1 ação padrão', 'Pessoal', 'Alvo: Você', '10 minutos/nível (D)', '', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Pessoal',
    area_target_effect_text='Alvo: Você',
    duration='10 minutos/nível (D)',
    saving_throw='',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Alterar Forma');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Alterar Forma'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Alterar Forma'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Alterar Forma'), 4, '');

INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Alterar Forma'), 9);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Alterar Forma'), 9);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Alterar Forma'), 9);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Alterar Forma'), 9);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Alterar-se', '', 8, '', '', '1 ação padrão', 'Pessoal', 'Alvo: O conjurador', '10 minutos/nível (D)', '', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Pessoal',
    area_target_effect_text='Alvo: O conjurador',
    duration='10 minutos/nível (D)',
    saving_throw='',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Alterar-se');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Alterar-se'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Alterar-se'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Alterar-se'), 2);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Alterar-se'), 2);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Alterar-se'), 2);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Amaldiçoar Água', 'Esta transmutação infunde energia negativa num
frasco (500 ml) com água, transformando-a em água
profana. A água profana causa dano a seres planares
Bons, do mesmo modo que a água benta causa dano
aos mortos-vivos.
Componente Material: 2,5 kg de prata em pó (25
PO).', 7, '', '[Mal]', '1 minuto', 'Toque', 'Alvo: Frasco de água tocado', 'Instantânea', 'Vontade anula (objeto)', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Esta transmutação infunde energia negativa num
frasco (500 ml) com água, transformando-a em água
profana. A água profana causa dano a seres planares
Bons, do mesmo modo que a água benta causa dano
aos mortos-vivos.
Componente Material: 2,5 kg de prata em pó (25
PO).', 
    school_id=7, 
    subschool='', 
    descriptors='[Mal]', 
    casting_time='1 minuto',
    range_text='Toque',
    area_target_effect_text='Alvo: Frasco de água tocado',
    duration='Instantânea',
    saving_throw='Vontade anula (objeto)',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Amaldiçoar Água');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Amaldiçoar Água'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Amaldiçoar Água'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Amaldiçoar Água'), 3, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Amaldiçoar Água'), 1);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Amolecer Terra e Pedra', 'Quando esta magia é conjurada, toda a terra ou
pedra natural não trabalhada na região afetada amole-
ce. A terra molhada se torna lama grossa, terra seca se
torna areia ou pó e a pedra se torna argila macia, que
é facilmente partida ou moldada. O personagem afeta
um quadrado de 3 metros de área com uma profundi-
dade entre 30 a 120 cm, dependendo da dureza e da
elasticidade do terreno no local escolhido (decisão do
Mestre). As pedras mágicas, encantadas, lapidadas ou
trabalhadas não são afetadas. As criaturas de terra ou
pedra também não são afetadas.
Uma criatura na lama precisa obter sucesso em um
teste de resistência de Reflexos ou ficará presa durante
1d2 rodadas, incapaz de se mover, atacar ou conjurar
magias. Uma criatura que obtenha sucesso no teste de
resistência pode mover-se através da lama com metade
de seu deslocamento, mas não pode realizar uma In-
vestida ou correr.
A terra solta não é tão incômoda quanto a lama,
mas todas as criaturas na área têm seu deslocamento
reduzido à metade e não podem correr ou realizar
uma Investida.
A pedra transformada em argila não atrapalha o
movimento, mas lhe permite cortar, moldar ou escavar
uma área que não seria possível antes. Por exemplo, um
grupo de aventureiros tentando sair de uma caverna
pode usar esta magia para amolecer uma parede. Apesar
de amolecer terra e pedra não afetar pedras trabalhadas
ou lapidadas, os tetos das cavernas ou as paredes de uma
colina podem ser afetados. Normalmente, isso causa um
deslizamento de terra ou um desabamento quando o
material se solta da parede ou do teto.
Uma quantidade considerável de dano estrutural
pode ser causado a uma construção (como uma parede
ou torre) amolecendo a terra sob ela, fazendo-a afundar.
Porém, a maior parte das estruturas bem construídas
sofrerá apenas dano com essa magia, mas não serão
destruídas.', 8, '', '[Terra]', '1 ação padrão', 'Curto (7,5 metros + 1,5 metro/2', 'Área: Um quadrado de 3 metros/nível; veja texto', 'Instantânea', 'Nenhum', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='Quando esta magia é conjurada, toda a terra ou
pedra natural não trabalhada na região afetada amole-
ce. A terra molhada se torna lama grossa, terra seca se
torna areia ou pó e a pedra se torna argila macia, que
é facilmente partida ou moldada. O personagem afeta
um quadrado de 3 metros de área com uma profundi-
dade entre 30 a 120 cm, dependendo da dureza e da
elasticidade do terreno no local escolhido (decisão do
Mestre). As pedras mágicas, encantadas, lapidadas ou
trabalhadas não são afetadas. As criaturas de terra ou
pedra também não são afetadas.
Uma criatura na lama precisa obter sucesso em um
teste de resistência de Reflexos ou ficará presa durante
1d2 rodadas, incapaz de se mover, atacar ou conjurar
magias. Uma criatura que obtenha sucesso no teste de
resistência pode mover-se através da lama com metade
de seu deslocamento, mas não pode realizar uma In-
vestida ou correr.
A terra solta não é tão incômoda quanto a lama,
mas todas as criaturas na área têm seu deslocamento
reduzido à metade e não podem correr ou realizar
uma Investida.
A pedra transformada em argila não atrapalha o
movimento, mas lhe permite cortar, moldar ou escavar
uma área que não seria possível antes. Por exemplo, um
grupo de aventureiros tentando sair de uma caverna
pode usar esta magia para amolecer uma parede. Apesar
de amolecer terra e pedra não afetar pedras trabalhadas
ou lapidadas, os tetos das cavernas ou as paredes de uma
colina podem ser afetados. Normalmente, isso causa um
deslizamento de terra ou um desabamento quando o
material se solta da parede ou do teto.
Uma quantidade considerável de dano estrutural
pode ser causado a uma construção (como uma parede
ou torre) amolecendo a terra sob ela, fazendo-a afundar.
Porém, a maior parte das estruturas bem construídas
sofrerá apenas dano com essa magia, mas não serão
destruídas.', 
    school_id=8, 
    subschool='', 
    descriptors='[Terra]', 
    casting_time='1 ação padrão',
    range_text='Curto (7,5 metros + 1,5 metro/2',
    area_target_effect_text='Área: Um quadrado de 3 metros/nível; veja texto',
    duration='Instantânea',
    saving_throw='Nenhum',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Amolecer Terra e Pedra');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Amolecer Terra e Pedra'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Amolecer Terra e Pedra'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Amolecer Terra e Pedra'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Amolecer Terra e Pedra'), 2);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (21, (SELECT id FROM spells WHERE name='Amolecer Terra e Pedra'), 2);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Ampliar Animais', 'Os animais selecionados aumentam até o dobro de
seu tamanho e pesam oito vezes mais que o normal.
Este aumento de tamanho gera vários efeitos: o
tamanho da criatura aumenta em uma categoria (de
Grande para Enorme, por exemplo), concede +8 de
bônus de tamanho na Força e +4 de bônus de tama-
nho na Constituição (e, por conta disso, 2 pontos de
vida adicionais por DV) e impõe -2 de penalidade de
tamanho na Destreza. O bônus de armadura natural da
criatura aumenta em 2 pontos. A mudança de tamanho
também afeta os modificadores na CA, jogadas de
ataque e dano do animal, como indica a Tabela 2-2 no
conforme indicado na Tabela 8-4, mas seu deslocamen-
to não é afetado.
A magia também concede a cada alvo Redução
de Dano 10/mágica e +4 de bônus de resistência nos
testes de resistência.
Caso o espaço seja insuficiente para o crescimento,
a criatura cresce o máximo possível e pode realizar um
teste de Força (usando sua Força recém-aumentada)
para romper qualquer obstáculo nesse processo. Se
fracassar no teste, ela diminuirá sem se ferir pelos ma-
teriais que a estão obstruindo – esta magia não pode
ser usada para esmagar uma criatura aumentando o
seu tamanho.
Todo equipamento vestido ou carregado por
um animal será similarmente aumentado pela magia,
embora essa mudança não afete nenhuma propriedade
mágica de qualquer equipamento. Qualquer item
aumentado que se separe da criatura retorna instanta-
neamente ao seu tamanho normal.
Essa magia não comanda ou influencia os ani-
mais.
Múltiplos efeitos mágicos que aumentam o tama-
nho não se acumulam, o que significa (entre outras
coisas) que é impossível usar uma segunda conjuração
dessa magia para aumentar ainda mais o tamanho
de um animal que já esteja sob o efeito da primeira
conjuração.', 8, '', '', '1 ação padrão', 'Médio (30 m + 3 m/nível)', 'Alvo: Até um animal (Imenso ou menor)/2', '1 minuto/nível', 'Fortitude anula', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Os animais selecionados aumentam até o dobro de
seu tamanho e pesam oito vezes mais que o normal.
Este aumento de tamanho gera vários efeitos: o
tamanho da criatura aumenta em uma categoria (de
Grande para Enorme, por exemplo), concede +8 de
bônus de tamanho na Força e +4 de bônus de tama-
nho na Constituição (e, por conta disso, 2 pontos de
vida adicionais por DV) e impõe -2 de penalidade de
tamanho na Destreza. O bônus de armadura natural da
criatura aumenta em 2 pontos. A mudança de tamanho
também afeta os modificadores na CA, jogadas de
ataque e dano do animal, como indica a Tabela 2-2 no
conforme indicado na Tabela 8-4, mas seu deslocamen-
to não é afetado.
A magia também concede a cada alvo Redução
de Dano 10/mágica e +4 de bônus de resistência nos
testes de resistência.
Caso o espaço seja insuficiente para o crescimento,
a criatura cresce o máximo possível e pode realizar um
teste de Força (usando sua Força recém-aumentada)
para romper qualquer obstáculo nesse processo. Se
fracassar no teste, ela diminuirá sem se ferir pelos ma-
teriais que a estão obstruindo – esta magia não pode
ser usada para esmagar uma criatura aumentando o
seu tamanho.
Todo equipamento vestido ou carregado por
um animal será similarmente aumentado pela magia,
embora essa mudança não afete nenhuma propriedade
mágica de qualquer equipamento. Qualquer item
aumentado que se separe da criatura retorna instanta-
neamente ao seu tamanho normal.
Essa magia não comanda ou influencia os ani-
mais.
Múltiplos efeitos mágicos que aumentam o tama-
nho não se acumulam, o que significa (entre outras
coisas) que é impossível usar uma segunda conjuração
dessa magia para aumentar ainda mais o tamanho
de um animal que já esteja sob o efeito da primeira
conjuração.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Médio (30 m + 3 m/nível)',
    area_target_effect_text='Alvo: Até um animal (Imenso ou menor)/2',
    duration='1 minuto/nível',
    saving_throw='Fortitude anula',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Ampliar Animais');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Ampliar Animais'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Ampliar Animais'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Ampliar Animais'), 5);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (8, (SELECT id FROM spells WHERE name='Ampliar Animais'), 4);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Ampliar Animais'), 5);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Ampliar Animais'), 5);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Ampliar Plantas', 'A magia ampliar plantas tem efeitos diferentes
dependendo da versão escolhida:
Crescimento: Esse efeito faz uma vegetação normal
(grama, urzes, arbustos, trepadeiras, espinhos, árvores,
vinhas) em um alcance Longo (120 metros + 12 metros/
nível) se tornar espessa e alta. As plantas se emaranham
para formar um bosque cerrado ou uma selva, onde
as criaturas precisam abrir caminho para prosseguir.
O deslocamento cai para 1,5 metro ou 3 metros para
criaturas Grandes (ou maiores). O Mestre pode permitir
um deslocamento maior para criaturas muito pequenas
ou muito grandes. A área deve ter arbustos e árvores
para que essa magia funcione.
Se o personagem preferir, a área pode ser uma
circunferência de 30 metros de raio, um hemisfério de
45 metros de raio ou um quarto de circunferência com
60 metros de raio. Ele pode também escolher lugares
dentro da área que não serão afetados.
Enriquecer: Esse efeito afeta plantas com um
alcance de 750 km, aumentando seu potencial de
produtividade durante o próximo ano em um terço
acima do normal.
Em várias comunidades rurais, clérigos ou druidas
conjuram essa magia na época da plantação como parte
dos festivais de primavera.
Ampliar plantas serve como contra mágica e dissipa
enfraquecer plantas.
Essa magia não tem efeito em criaturas plantas.', 8, '', '', '1 ação padrão', 'Veja texto', '', 'Instantânea', 'Nenhum', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='A magia ampliar plantas tem efeitos diferentes
dependendo da versão escolhida:
Crescimento: Esse efeito faz uma vegetação normal
(grama, urzes, arbustos, trepadeiras, espinhos, árvores,
vinhas) em um alcance Longo (120 metros + 12 metros/
nível) se tornar espessa e alta. As plantas se emaranham
para formar um bosque cerrado ou uma selva, onde
as criaturas precisam abrir caminho para prosseguir.
O deslocamento cai para 1,5 metro ou 3 metros para
criaturas Grandes (ou maiores). O Mestre pode permitir
um deslocamento maior para criaturas muito pequenas
ou muito grandes. A área deve ter arbustos e árvores
para que essa magia funcione.
Se o personagem preferir, a área pode ser uma
circunferência de 30 metros de raio, um hemisfério de
45 metros de raio ou um quarto de circunferência com
60 metros de raio. Ele pode também escolher lugares
dentro da área que não serão afetados.
Enriquecer: Esse efeito afeta plantas com um
alcance de 750 km, aumentando seu potencial de
produtividade durante o próximo ano em um terço
acima do normal.
Em várias comunidades rurais, clérigos ou druidas
conjuram essa magia na época da plantação como parte
dos festivais de primavera.
Ampliar plantas serve como contra mágica e dissipa
enfraquecer plantas.
Essa magia não tem efeito em criaturas plantas.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Veja texto',
    area_target_effect_text='',
    duration='Instantânea',
    saving_throw='Nenhum',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Ampliar Plantas');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Ampliar Plantas'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Ampliar Plantas'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Ampliar Plantas'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Ampliar Plantas'), 3);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (17, (SELECT id FROM spells WHERE name='Ampliar Plantas'), 3);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (8, (SELECT id FROM spells WHERE name='Ampliar Plantas'), 3);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Analisar Encantamento', 'O conjurador descobre magias e propriedades má-
gicas presentes num determinado número de objetos ou
criaturas. A cada rodada, ele pode examinar uma única
criatura ou objeto visível usando uma ação livre. No
caso de itens mágicos, o personagem descobre como ele
funciona, como ativá-lo e quantas cargas ainda restam
(caso seja apropriado). Para objetos e criaturas com
magias ativas sobre si, ele determina cada magia, seu
efeito e seu nível de conjurador.
Um objeto portado por outra criatura pode realizar
um teste de resistência de Vontade (se o portador dese-
jar). Caso obtenha sucesso, o conjurador não descobre
nada sobre o objeto além daquilo que seus olhos podem
distinguir. Um objeto que obtenha sucesso no teste de
resistência não pode ser afetado por outra magia analisar
encantamento durante as próximas 24 horas.
Analisar encantamento não funciona quando é
usado em artefatos (veja o Livro do Mestre para obter
detalhes sobre artefatos).
Foco: Uma pequena lente de rubi ou safira em
uma armação de ouro. A gema deve custar ao menos
1.500 PO.', 3, '', '', '1 ação padrão', 'Curto (7,5 m + 1,5 m/2 níveis)', 'Alvo: Um objeto ou criatura por nível de con-', '1 rodada/nível (D)', 'Nenhum ou Vontade', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='O conjurador descobre magias e propriedades má-
gicas presentes num determinado número de objetos ou
criaturas. A cada rodada, ele pode examinar uma única
criatura ou objeto visível usando uma ação livre. No
caso de itens mágicos, o personagem descobre como ele
funciona, como ativá-lo e quantas cargas ainda restam
(caso seja apropriado). Para objetos e criaturas com
magias ativas sobre si, ele determina cada magia, seu
efeito e seu nível de conjurador.
Um objeto portado por outra criatura pode realizar
um teste de resistência de Vontade (se o portador dese-
jar). Caso obtenha sucesso, o conjurador não descobre
nada sobre o objeto além daquilo que seus olhos podem
distinguir. Um objeto que obtenha sucesso no teste de
resistência não pode ser afetado por outra magia analisar
encantamento durante as próximas 24 horas.
Analisar encantamento não funciona quando é
usado em artefatos (veja o Livro do Mestre para obter
detalhes sobre artefatos).
Foco: Uma pequena lente de rubi ou safira em
uma armação de ouro. A gema deve custar ao menos
1.500 PO.', 
    school_id=3, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Curto (7,5 m + 1,5 m/2 níveis)',
    area_target_effect_text='Alvo: Um objeto ou criatura por nível de con-',
    duration='1 rodada/nível (D)',
    saving_throw='Nenhum ou Vontade',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Analisar Encantamento');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Analisar Encantamento'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Analisar Encantamento'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Analisar Encantamento'), 4, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Analisar Encantamento'), 6);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Analisar Encantamento'), 6);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Analisar Encantamento'), 6);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Âncora Dimensional', 'Um raio esverdeado parte da mão do conjurador.
Ele precisa realizar um ataque de toque à distância para
atingir o alvo. Qualquer criatura ou objeto atingido
é envolvido por um campo esmeralda brilhante que
bloqueia completamente o movimento dimensional. As
formas de movimento bloqueadas por âncora dimen-
sional incluem projeção astral, piscar, porta dimensional,
passeio etéreo, forma etérea, portal, labirinto, viagem
planar, andar nas sombras, teletransporte e as habilidades
mágicas ou psíquicas similares. Ela também impede a
utilização de um portal ou círculo de teletransporte
enquanto a magia permanecer ativa.
A âncora dimensional não prejudica o movimento
de criaturas que já estejam na forma astral ou etérea e
não bloqueia a percepção ou os ataques extra-dimen-
sionais, como o olhar de um basilisco. Além disso, não
impede que as criaturas invocadas desapareçam quando
a duração de sua invocação terminar.', 1, '', '', '1 ação padrão', 'Médio (30 m + 3 m/nível)', 'Efeito: Raio', '1 min/nível', 'Nenhum', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Um raio esverdeado parte da mão do conjurador.
Ele precisa realizar um ataque de toque à distância para
atingir o alvo. Qualquer criatura ou objeto atingido
é envolvido por um campo esmeralda brilhante que
bloqueia completamente o movimento dimensional. As
formas de movimento bloqueadas por âncora dimen-
sional incluem projeção astral, piscar, porta dimensional,
passeio etéreo, forma etérea, portal, labirinto, viagem
planar, andar nas sombras, teletransporte e as habilidades
mágicas ou psíquicas similares. Ela também impede a
utilização de um portal ou círculo de teletransporte
enquanto a magia permanecer ativa.
A âncora dimensional não prejudica o movimento
de criaturas que já estejam na forma astral ou etérea e
não bloqueia a percepção ou os ataques extra-dimen-
sionais, como o olhar de um basilisco. Além disso, não
impede que as criaturas invocadas desapareçam quando
a duração de sua invocação terminar.', 
    school_id=1, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Médio (30 m + 3 m/nível)',
    area_target_effect_text='Efeito: Raio',
    duration='1 min/nível',
    saving_throw='Nenhum',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Âncora Dimensional');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Âncora Dimensional'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Âncora Dimensional'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Âncora Dimensional'), 4);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Âncora Dimensional'), 4);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Âncora Dimensional'), 4);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Âncora Planar', '', 2, 'Convocação', '[veja o texto para', '', '', 'Efeito: Até três elementais ou criaturas planares,', '', '', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=2, 
    subschool='Convocação', 
    descriptors='[veja o texto para', 
    casting_time='',
    range_text='',
    area_target_effect_text='Efeito: Até três elementais ou criaturas planares,',
    duration='',
    saving_throw='',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Âncora Planar');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Âncora Planar'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Âncora Planar'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Âncora Planar'), 6);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Âncora Planar'), 6);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Âncora Planar Maior', '', 2, 'Convocação', '[veja texto para ânco-', '', '', 'Efeito: Até três elementais ou criaturas planares,', '', '', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=2, 
    subschool='Convocação', 
    descriptors='[veja texto para ânco-', 
    casting_time='',
    range_text='',
    area_target_effect_text='Efeito: Até três elementais ou criaturas planares,',
    duration='',
    saving_throw='',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Âncora Planar Maior');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Âncora Planar Maior'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Âncora Planar Maior'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Âncora Planar Maior'), 8);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Âncora Planar Maior'), 8);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Âncora Planar Menor', 'Conjurar esta magia é um ato perigoso: ela atrairá
uma criatura de outro plano para uma armadilha
especialmente preparada, que deve estar dentro do
alcance da magia. A criatura convocada é mantida na
armadilha até concordar em realizar uma tarefa em
troca de sua Uberdade.
Para criar a armadilha, o personagem precisa usar
a magia círculo mágico com o foco voltado para o
interior. O tipo de criatura a ser capturado deve ser co-
nhecido e declarado. Se o personagem desejar convocar
uma criatura específica, ele deve usar o nome próprio
dessa criatura quando estiver conjurando a magia.
A criatura deve realizar um teste de resistência de
Vontade. Se obtiver um sucesso, ela resiste à magia.
Caso contrário, ela é imediatamente transportada a
armadilha (a Resistência à Magia não impede a cria-
tura de ser convocada). Ela pode escapar da armadilha
contrapondo sua Resistência à Magia contra o teste de
conjurador do personagem, usando qualquer viagem
dimensional ou com um teste de Carisma (CD 15 +1/2
do nível do conjurador + modificador de Carisma).
Ela pode tentar cada método uma vez por dia. Caso se
liberte, pode fugir ou atacar o conjurador. Uma âncora
dimensional conjurada sobre a criatura impediria fugas
através da viagem dimensional. Também é possível em-
pregar um diagrama de convocação (veja circulo mágico
contra o mal) para tomar a armadilha mais segura.
Se a criatura não escapar da armadilha, o perso-
nagem pode mantê-la presa durante algum tempo. Ele
tentará convencê-la a realizar uma tarefa, descrevendo-a
e talvez oferecendo algum ripo de recompensa. Deve ser
realizado um teste de Carisma resistido pelo Carisma
da criatura. O Mestre determina um bônus entre +0
e +6 ao teste do personagem baseado no serviço e na
recompensa. Se a criatura vencer o teste, ela recusará
o serviço. A cada 24 horas, novas ofertas, subornos e
coisas do tipo podem ser oferecidos (ou os antigos ofere-
cidos novamente). Isso pode se repetir até que a criatura
concorde, se liberte ou até o personagem decidir se
livrar dela usando outra magia. As tarefas impossíveis
ou comandos fora de propósito nunca serão aceitos. Se
o personagem obtiver 1 no teste de Carisma, a criatura
se liberta e poderá escapar ou atacá-lo.
Quando a tarefa terminar, a criatura só precisa
informar o conjurador para ser instantaneamente
enviada ao seu plano de origem. Ela pode se vingar
depois. Se a instruções envolverem alguma tarefa ampla,
que o alvo não pode completar usando seus próprios
recursos (como espere aqui ou defenda esta área contra
ataques), a magia permanece ativa durante 1 dia por
nível do conjurador e a criatura adquire uma chance
imediata de se libertar. Observe que um alvo esperto
pode subverter algumas instruções.
Quando o personagem usa uma magia desse tipo
para convocar uma criatura do ar, caos, terra, mal, fogo,
bem, ordem ou água, ela se torna uma magia desse tipo.
Por exemplo, âncora planar menor é uma magia da água
quando usada para convocar um elemental da água.', 2, 'Convocação', '[veja texto]', '10 minutos', 'Curto (7,5 metros + 1,5 metro/2', 'Efeito: Um elemental ou criatura planar convo-', 'Instantânea', 'Vontade anula', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='Conjurar esta magia é um ato perigoso: ela atrairá
uma criatura de outro plano para uma armadilha
especialmente preparada, que deve estar dentro do
alcance da magia. A criatura convocada é mantida na
armadilha até concordar em realizar uma tarefa em
troca de sua Uberdade.
Para criar a armadilha, o personagem precisa usar
a magia círculo mágico com o foco voltado para o
interior. O tipo de criatura a ser capturado deve ser co-
nhecido e declarado. Se o personagem desejar convocar
uma criatura específica, ele deve usar o nome próprio
dessa criatura quando estiver conjurando a magia.
A criatura deve realizar um teste de resistência de
Vontade. Se obtiver um sucesso, ela resiste à magia.
Caso contrário, ela é imediatamente transportada a
armadilha (a Resistência à Magia não impede a cria-
tura de ser convocada). Ela pode escapar da armadilha
contrapondo sua Resistência à Magia contra o teste de
conjurador do personagem, usando qualquer viagem
dimensional ou com um teste de Carisma (CD 15 +1/2
do nível do conjurador + modificador de Carisma).
Ela pode tentar cada método uma vez por dia. Caso se
liberte, pode fugir ou atacar o conjurador. Uma âncora
dimensional conjurada sobre a criatura impediria fugas
através da viagem dimensional. Também é possível em-
pregar um diagrama de convocação (veja circulo mágico
contra o mal) para tomar a armadilha mais segura.
Se a criatura não escapar da armadilha, o perso-
nagem pode mantê-la presa durante algum tempo. Ele
tentará convencê-la a realizar uma tarefa, descrevendo-a
e talvez oferecendo algum ripo de recompensa. Deve ser
realizado um teste de Carisma resistido pelo Carisma
da criatura. O Mestre determina um bônus entre +0
e +6 ao teste do personagem baseado no serviço e na
recompensa. Se a criatura vencer o teste, ela recusará
o serviço. A cada 24 horas, novas ofertas, subornos e
coisas do tipo podem ser oferecidos (ou os antigos ofere-
cidos novamente). Isso pode se repetir até que a criatura
concorde, se liberte ou até o personagem decidir se
livrar dela usando outra magia. As tarefas impossíveis
ou comandos fora de propósito nunca serão aceitos. Se
o personagem obtiver 1 no teste de Carisma, a criatura
se liberta e poderá escapar ou atacá-lo.
Quando a tarefa terminar, a criatura só precisa
informar o conjurador para ser instantaneamente
enviada ao seu plano de origem. Ela pode se vingar
depois. Se a instruções envolverem alguma tarefa ampla,
que o alvo não pode completar usando seus próprios
recursos (como espere aqui ou defenda esta área contra
ataques), a magia permanece ativa durante 1 dia por
nível do conjurador e a criatura adquire uma chance
imediata de se libertar. Observe que um alvo esperto
pode subverter algumas instruções.
Quando o personagem usa uma magia desse tipo
para convocar uma criatura do ar, caos, terra, mal, fogo,
bem, ordem ou água, ela se torna uma magia desse tipo.
Por exemplo, âncora planar menor é uma magia da água
quando usada para convocar um elemental da água.', 
    school_id=2, 
    subschool='Convocação', 
    descriptors='[veja texto]', 
    casting_time='10 minutos',
    range_text='Curto (7,5 metros + 1,5 metro/2',
    area_target_effect_text='Efeito: Um elemental ou criatura planar convo-',
    duration='Instantânea',
    saving_throw='Vontade anula',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Âncora Planar Menor');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Âncora Planar Menor'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Âncora Planar Menor'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Âncora Planar Menor'), 5);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Âncora Planar Menor'), 5);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Andar no Ar', 'A criatura afetada pode caminhar pelo ar como se
estivesse em terreno sólido. O maior ângulo possível
de subida ou descida é de 45°, usando metade do
deslocamento normal.
Um vento forte (30 km/h ou mais) pode empur-
rar uma criatura caminhando no ar. No final de sua
rodada, o vento empurra a criatura 1,5 m para cada
7,5 km por hora de velocidade. O Mestre define se a
criatura sofre penalidades adicionais devido a ventos
excepcionalmente fortes ou turbulentos, como perda
de controle sobre o movimento ou dano físico ao ser
atirada de um lado para o outro.
Caso a magia termine enquanto a criatura estiver
suspensa, a magia o fará pousar suavemente. A criatura
flutuará para baixo a 18 m/rodada durante 1d6 roda-
das. Se atingir o solo nesse período, aterrissará com
segurança. Caso contrário, cairá a distância restante,
sofrendo 1d6 pontos de dano a cada 3 m de queda.
Quando um efeito de dissipar visar essa magia, a cria-
tura também aterrissa dessa forma, como se a duração
tivesse acabado. Isso não acontece se ela for anulada por
um campo antimagia.
É possível conjurar andar no ar sobre uma monta-
ria especialmente treinada, para que ela possa cavalgar
no ar. Essa montaria deve ser treinada com a perícia
Adestrar Animais (conta como um truque). Isso exige
uma semana de trabalho e um teste de Adestrar Ani-
mais (CD 25).', 8, '', '[Ar]', '1 ação padrão', 'Toque', 'Alvo: Criatura tocada (Imensa ou menor)', '10 minutos/nível', 'Nenhum', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='A criatura afetada pode caminhar pelo ar como se
estivesse em terreno sólido. O maior ângulo possível
de subida ou descida é de 45°, usando metade do
deslocamento normal.
Um vento forte (30 km/h ou mais) pode empur-
rar uma criatura caminhando no ar. No final de sua
rodada, o vento empurra a criatura 1,5 m para cada
7,5 km por hora de velocidade. O Mestre define se a
criatura sofre penalidades adicionais devido a ventos
excepcionalmente fortes ou turbulentos, como perda
de controle sobre o movimento ou dano físico ao ser
atirada de um lado para o outro.
Caso a magia termine enquanto a criatura estiver
suspensa, a magia o fará pousar suavemente. A criatura
flutuará para baixo a 18 m/rodada durante 1d6 roda-
das. Se atingir o solo nesse período, aterrissará com
segurança. Caso contrário, cairá a distância restante,
sofrendo 1d6 pontos de dano a cada 3 m de queda.
Quando um efeito de dissipar visar essa magia, a cria-
tura também aterrissa dessa forma, como se a duração
tivesse acabado. Isso não acontece se ela for anulada por
um campo antimagia.
É possível conjurar andar no ar sobre uma monta-
ria especialmente treinada, para que ela possa cavalgar
no ar. Essa montaria deve ser treinada com a perícia
Adestrar Animais (conta como um truque). Isso exige
uma semana de trabalho e um teste de Adestrar Ani-
mais (CD 25).', 
    school_id=8, 
    subschool='', 
    descriptors='[Ar]', 
    casting_time='1 ação padrão',
    range_text='Toque',
    area_target_effect_text='Alvo: Criatura tocada (Imensa ou menor)',
    duration='10 minutos/nível',
    saving_throw='Nenhum',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Andar no Ar');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Andar no Ar'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Andar no Ar'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Andar no Ar'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Andar no Ar'), 4);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Andar nas Sombras', 'Para utilizar a magia andar nas sombras, o perso-
nagem deve estar em uma área bastante escura. Ele
e qualquer criatura tocada são transportados através
das sombras até o limite do Plano Material, onde ele
se encontra com o Plano das Sombras. O efeito é em
grande parte ilusório, mas o caminho é semi-real. O
personagem pode levar mais de uma criatura consigo
(de acordo com seu nível), mas todas devem estar em
contato físico.
Na região das sombras, o personagem pode se des-
locar a 75 km por hora, movendo-se normalmente na
fronteira do Plano das Sombras, embora rapidamente
em relação ao Plano Material. Dessa forma, essa magia
pode ser usada para realizar uma viagem rápida, per-
correndo a distância desejada no Plano das Sombras e
então retornando ao Plano Material.
Por causa da realidade nublada entre o Plano das
Sombras e o Plano Material, o personagem não percebe
os detalhes dos terrenos ou áreas pelas quais passou
e nem sabe perfeitamente onde a viagem acabará. É
impossível julgar a distância certa, tornando a magia
virtualmente inútil para um batedor ou espião. Além
disso, quando a magia terminar, o personagem é desvia-
do em 1d10x300 metros para uma direção horizontal
aleatória do destino da viagem. Se isso posicionar o
conjurador dentro de um objeto sólido, ele será desvia-
do a 1d10x300 metros na mesma direção. Se isso ainda
deixar o personagem (e qualquer criatura com ele) den-
tro de um objeto sólido, ele será desviado para o espaço
disponível mais próximo, mas essa atividade deixa todas
as criaturas fatigadas (sem teste de resistência).
Andar nas sombras: também pode ser usado para
viajar até outros planos que se encontram com o
Plano das Sombras, mas isso exige caminhar no Plano
das Sombras até atingir a fronteira do outro plano de
existência. A jornada pelo Plano das Sombras exige
1d4 horas.
Qualquer criatura tocada pelo personagem quan-
do andar nas sombras for conjurada pode viajar até a
fronteira do Plano das Sombras. Elas podem optar por
segui-lo, explorar o plano ou retornar para o Plano Ma-
terial (50% de chance para cada umas das duas últimas
caso elas fiquem perdidas ou sejam abandonadas pelo
personagem). As criaturas que não desejam acompanhá-
lo podem realizar um teste de resistência de Vontade, e
não serão afetadas se obtiverem sucesso.', 6, 'Sombra', '', '1 ação padrão', 'Toque', 'Alvo: Até uma criatura tocada/nível', '1 hora/nível (D)', 'Vontade anula', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Para utilizar a magia andar nas sombras, o perso-
nagem deve estar em uma área bastante escura. Ele
e qualquer criatura tocada são transportados através
das sombras até o limite do Plano Material, onde ele
se encontra com o Plano das Sombras. O efeito é em
grande parte ilusório, mas o caminho é semi-real. O
personagem pode levar mais de uma criatura consigo
(de acordo com seu nível), mas todas devem estar em
contato físico.
Na região das sombras, o personagem pode se des-
locar a 75 km por hora, movendo-se normalmente na
fronteira do Plano das Sombras, embora rapidamente
em relação ao Plano Material. Dessa forma, essa magia
pode ser usada para realizar uma viagem rápida, per-
correndo a distância desejada no Plano das Sombras e
então retornando ao Plano Material.
Por causa da realidade nublada entre o Plano das
Sombras e o Plano Material, o personagem não percebe
os detalhes dos terrenos ou áreas pelas quais passou
e nem sabe perfeitamente onde a viagem acabará. É
impossível julgar a distância certa, tornando a magia
virtualmente inútil para um batedor ou espião. Além
disso, quando a magia terminar, o personagem é desvia-
do em 1d10x300 metros para uma direção horizontal
aleatória do destino da viagem. Se isso posicionar o
conjurador dentro de um objeto sólido, ele será desvia-
do a 1d10x300 metros na mesma direção. Se isso ainda
deixar o personagem (e qualquer criatura com ele) den-
tro de um objeto sólido, ele será desviado para o espaço
disponível mais próximo, mas essa atividade deixa todas
as criaturas fatigadas (sem teste de resistência).
Andar nas sombras: também pode ser usado para
viajar até outros planos que se encontram com o
Plano das Sombras, mas isso exige caminhar no Plano
das Sombras até atingir a fronteira do outro plano de
existência. A jornada pelo Plano das Sombras exige
1d4 horas.
Qualquer criatura tocada pelo personagem quan-
do andar nas sombras for conjurada pode viajar até a
fronteira do Plano das Sombras. Elas podem optar por
segui-lo, explorar o plano ou retornar para o Plano Ma-
terial (50% de chance para cada umas das duas últimas
caso elas fiquem perdidas ou sejam abandonadas pelo
personagem). As criaturas que não desejam acompanhá-
lo podem realizar um teste de resistência de Vontade, e
não serão afetadas se obtiverem sucesso.', 
    school_id=6, 
    subschool='Sombra', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Toque',
    area_target_effect_text='Alvo: Até uma criatura tocada/nível',
    duration='1 hora/nível (D)',
    saving_throw='Vontade anula',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Andar nas Sombras');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Andar nas Sombras'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Andar nas Sombras'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Andar nas Sombras'), 5);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Andar nas Sombras'), 6);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Andar nas Sombras'), 6);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Animação Ilusória', 'Tempo de Execução: 1 ação padrão
Alcance: Médio (30 m + 3 m/nível)
Alvo: Objeto similar a uma corda, tamanho
máximo 15 m +1,5 m/nível (veja texto)
Duração: 1 rodada/nível
Teste de Resistência: Nenhum
Resistência à Magia: Não
O conjurador pode animar um objeto mundano
similar a uma corda, incluindo cordões, fios, linhas e
cabos. O tamanho máximo considera uma corda de 2,5
cm de diâmetro. Reduza o tamanho em 50% para cada
2,5 cm de diâmetro adicionais e aumente o tamanho em
50% cada vez que a espessura se dividir pela metade.
Os comandos possíveis são enrolar (formar uma pilha
arrumada), enrolar e dar nó, laço, laço e nó e os opostos
de todos eles (desenrolar, etc.). Um comando pode ser
dado a cada rodada usando uma ação de movimento,
como se estivesse direcionando uma magia ativa.
A corda pode enredar uma criatura que estiver a
menos de 30 cm – o alcance máximo da corda para
atacar – portanto, ela deve ser atirada próxima ao alvo.
Isso exige um ataque de toque à distância bem-sucedido.
A corda possui um incremento de distância de 3 m; a
corda típica possui 2 PV, CA 10 e pode ser rompida com
um teste de Força (CD 23). A corda não causará dano,
mas pode ser utilizada para enredar ou imobilizar um
oponente que fracassar em um teste de resistência de
Reflexos. Os conjuradores enredados precisam realizar
um teste de Concentração (CD 15) para lançar magias.
Uma criatura enredada é capaz de escapar com um teste
de Arte da Fuga (CD 20).
Nem a corda nem seus nós são considerados
mágicos.
A magia fornece um bônus de +2 a qualquer teste
de Usar Cordas realizado com uma corda animada.
Esta magia não anima objetos carregados ou usados
por uma criatura.', 6, 'Sensação', '', '10 minutos', 'Curto (7,5 m + 1,5 m/2 níveis)', 'Área: Um cubo de 9 metros/nível (M)', '24 horas', 'Nenhum ou Vontade', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='Tempo de Execução: 1 ação padrão
Alcance: Médio (30 m + 3 m/nível)
Alvo: Objeto similar a uma corda, tamanho
máximo 15 m +1,5 m/nível (veja texto)
Duração: 1 rodada/nível
Teste de Resistência: Nenhum
Resistência à Magia: Não
O conjurador pode animar um objeto mundano
similar a uma corda, incluindo cordões, fios, linhas e
cabos. O tamanho máximo considera uma corda de 2,5
cm de diâmetro. Reduza o tamanho em 50% para cada
2,5 cm de diâmetro adicionais e aumente o tamanho em
50% cada vez que a espessura se dividir pela metade.
Os comandos possíveis são enrolar (formar uma pilha
arrumada), enrolar e dar nó, laço, laço e nó e os opostos
de todos eles (desenrolar, etc.). Um comando pode ser
dado a cada rodada usando uma ação de movimento,
como se estivesse direcionando uma magia ativa.
A corda pode enredar uma criatura que estiver a
menos de 30 cm – o alcance máximo da corda para
atacar – portanto, ela deve ser atirada próxima ao alvo.
Isso exige um ataque de toque à distância bem-sucedido.
A corda possui um incremento de distância de 3 m; a
corda típica possui 2 PV, CA 10 e pode ser rompida com
um teste de Força (CD 23). A corda não causará dano,
mas pode ser utilizada para enredar ou imobilizar um
oponente que fracassar em um teste de resistência de
Reflexos. Os conjuradores enredados precisam realizar
um teste de Concentração (CD 15) para lançar magias.
Uma criatura enredada é capaz de escapar com um teste
de Arte da Fuga (CD 20).
Nem a corda nem seus nós são considerados
mágicos.
A magia fornece um bônus de +2 a qualquer teste
de Usar Cordas realizado com uma corda animada.
Esta magia não anima objetos carregados ou usados
por uma criatura.', 
    school_id=6, 
    subschool='Sensação', 
    descriptors='', 
    casting_time='10 minutos',
    range_text='Curto (7,5 m + 1,5 m/2 níveis)',
    area_target_effect_text='Área: Um cubo de 9 metros/nível (M)',
    duration='24 horas',
    saving_throw='Nenhum ou Vontade',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Animação Ilusória');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Animação Ilusória'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Animação Ilusória'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Animação Ilusória'), 8);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Animação Ilusória'), 8);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (9, (SELECT id FROM spells WHERE name='Animação Ilusória'), 7);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Animar Objetos', 'Esta magia combina vários elementos para criar
uma poderosa proteção contra espionagem mágica ou
observação direta. Quando conjurar a magia, o persona-
gem define o que pode ou não ser observado na área. A
ilusão criada deve ser descrita em termos gerais. Assim,
é possível determinar que a ilusão mostrará o próprio
personagem e outra criatura jogando xadrez enquanto
a magia permanecer ativa, mas não se pode determinar
que haverá uma pausa no jogo de xadrez, um jantar, e
depois a partida continuará. O personagem é capaz de
fazer uma encruzilhada parecer vazia e quieta, mesmo
com um exército marchando por ela. Ele pode dizer
que ninguém será observado (inclusive estranhos que
passem pela área), que as tropas não sejam detectadas
ou mesmo que uma a cada cinco pessoas ou unidades
seja visível. Depois de determinar as condições, elas não
podem ser alteradas.
As tentativas de observar a área detectam automati-
camente a imagem criada e nenhum teste de resistência
é permitido para revelar a ilusão. Cria-se uma visão e
som apropriado à ilusão. Por exemplo, um grupo de
pessoas sob as árvores pode ser mostrado como um
local tranqüilo com pássaros cantando.
A observação direta permite um teste de resistência
(como qualquer ilusão normal), se existir uma causa
para não se acreditar nela. Certamente, os observado-
res na área suspeitariam se um exército desaparecesse
em um local e aparece em outro. Nem mesmo entrar
na área garante o direito a um teste de resistência ou
cancela a ilusão, desde que as criaturas escondidas
tenham a cautela de evitar aquelas que estejam sob
efeito da magia.Com esta magia, o personagem concede mobilida-
de e algo similar à vida aos objetos inanimados. Depois,
o objeto (ou objetos) animado ataca qualquer alvo indi-
cado imediatamente. O objeto pode ser feito de qual-
quer material mundano – madeira, metal, pedra, tecido,
couro, cerâmica, vidro, etc. É possível animar um objeto
Pequeno ou menor (como uma cadeira) por nível de
conjurador ou uma quantidade equivalente de objetos
maiores. Considere que um objeto Médio (como um
gaveteiro) equivale a dois objetos Pequenos, um objeto
Grande (como uma mesa) equivale a quatro, um objeto
Enorme a oito, um Imenso a dezesseis e um Colossal a
trinta e dois. O conjurador pode mudar o alvo ou alvos
dessa magia usando uma ação de movimento, como se
estivesse direcionando uma magia ativa.
As estatísticas dos objetos animados podem ser
encontradas no Livro dos Monstros.
A magia não pode animar objetos usados ou car-
regados por uma criatura.
Um objeto animado pode se tornar permanente
através da magia permanência.', 8, '', '', '1 ação padrão', 'Médio (30 m + 3 m/nível)', 'Alvo: Um objeto Pequeno/nível de conjurador', '1 rodada/nível', 'Nenhum', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='Esta magia combina vários elementos para criar
uma poderosa proteção contra espionagem mágica ou
observação direta. Quando conjurar a magia, o persona-
gem define o que pode ou não ser observado na área. A
ilusão criada deve ser descrita em termos gerais. Assim,
é possível determinar que a ilusão mostrará o próprio
personagem e outra criatura jogando xadrez enquanto
a magia permanecer ativa, mas não se pode determinar
que haverá uma pausa no jogo de xadrez, um jantar, e
depois a partida continuará. O personagem é capaz de
fazer uma encruzilhada parecer vazia e quieta, mesmo
com um exército marchando por ela. Ele pode dizer
que ninguém será observado (inclusive estranhos que
passem pela área), que as tropas não sejam detectadas
ou mesmo que uma a cada cinco pessoas ou unidades
seja visível. Depois de determinar as condições, elas não
podem ser alteradas.
As tentativas de observar a área detectam automati-
camente a imagem criada e nenhum teste de resistência
é permitido para revelar a ilusão. Cria-se uma visão e
som apropriado à ilusão. Por exemplo, um grupo de
pessoas sob as árvores pode ser mostrado como um
local tranqüilo com pássaros cantando.
A observação direta permite um teste de resistência
(como qualquer ilusão normal), se existir uma causa
para não se acreditar nela. Certamente, os observado-
res na área suspeitariam se um exército desaparecesse
em um local e aparece em outro. Nem mesmo entrar
na área garante o direito a um teste de resistência ou
cancela a ilusão, desde que as criaturas escondidas
tenham a cautela de evitar aquelas que estejam sob
efeito da magia.Com esta magia, o personagem concede mobilida-
de e algo similar à vida aos objetos inanimados. Depois,
o objeto (ou objetos) animado ataca qualquer alvo indi-
cado imediatamente. O objeto pode ser feito de qual-
quer material mundano – madeira, metal, pedra, tecido,
couro, cerâmica, vidro, etc. É possível animar um objeto
Pequeno ou menor (como uma cadeira) por nível de
conjurador ou uma quantidade equivalente de objetos
maiores. Considere que um objeto Médio (como um
gaveteiro) equivale a dois objetos Pequenos, um objeto
Grande (como uma mesa) equivale a quatro, um objeto
Enorme a oito, um Imenso a dezesseis e um Colossal a
trinta e dois. O conjurador pode mudar o alvo ou alvos
dessa magia usando uma ação de movimento, como se
estivesse direcionando uma magia ativa.
As estatísticas dos objetos animados podem ser
encontradas no Livro dos Monstros.
A magia não pode animar objetos usados ou car-
regados por uma criatura.
Um objeto animado pode se tornar permanente
através da magia permanência.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Médio (30 m + 3 m/nível)',
    area_target_effect_text='Alvo: Um objeto Pequeno/nível de conjurador',
    duration='1 rodada/nível',
    saving_throw='Nenhum',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Animar Objetos');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Animar Objetos'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Animar Objetos'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Animar Objetos'), 6);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (5, (SELECT id FROM spells WHERE name='Animar Objetos'), 6);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Animar Objetos'), 6);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Animar CordaAnimar Plantas', '', 8, '', '', '', '', '', '', '', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='',
    range_text='',
    area_target_effect_text='',
    duration='',
    saving_throw='',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Animar CordaAnimar Plantas');
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Animar CordaAnimar Plantas'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Animar CordaAnimar Plantas'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Animar CordaAnimar Plantas'), 1);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Componentes: V, G', 'Essa ma magia concede mobilidade e algo similar
à vida a plantas inanimadas. Depois, cada planta
animada ataca qualquer alvo indicado imediatamente,
como se fosse um objeto animado pertencente à cate-
goria de tamanho apropriada. É possível animar uma
planta Grande (como uma árvore) a cada 3 níveis de
conjurador ou uma quantidade equivalente de plantas
maiores. Considere que uma planta Enorme equivale a
duas plantas Grandes ou menores, uma planta Imensa
equivale a quatro e uma planta Colossal a oito. O
conjurador pode mudar o alvo ou alvos dessa magia
usando uma ação de movimento, como se estivesse
direcionando uma magia ativa.
As estatísticas dos objetos animados podem ser
encontradas no Livro dos Monstros, embora as plantas
menores que Grande não possuem dureza, a menos que
o Mestre determine o contrário.
Esta magia não afeta criaturas do tipo planta
(como Entes), assim como também não afeta material
vegetal morto (como uma túnica de algodão ou uma
corda de cânhamo).
Constrição: Como alternativa, é possível imbuir um
grau de mobilidade a todas as plantas dentro do alcance,
permitindo que elas se entrelacem nas criaturas na área
afetada. Este uso da magia duplica o efeito da magia
contrição. A Resistência à Magia não impede que as
criaturas sejam enredadas. Esse efeito permanece ativo
durante uma hora por nível de conjurador.', 8, '', '', '1 ação padrão', 'Curto (7,5 m + 1,5 m/2 níveis)', 'Alvo: Uma planta Grande/3 níveis de conjura-', '1 rodada/nível ou 1 hora/nível (veja', 'Nenhum', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='Essa ma magia concede mobilidade e algo similar
à vida a plantas inanimadas. Depois, cada planta
animada ataca qualquer alvo indicado imediatamente,
como se fosse um objeto animado pertencente à cate-
goria de tamanho apropriada. É possível animar uma
planta Grande (como uma árvore) a cada 3 níveis de
conjurador ou uma quantidade equivalente de plantas
maiores. Considere que uma planta Enorme equivale a
duas plantas Grandes ou menores, uma planta Imensa
equivale a quatro e uma planta Colossal a oito. O
conjurador pode mudar o alvo ou alvos dessa magia
usando uma ação de movimento, como se estivesse
direcionando uma magia ativa.
As estatísticas dos objetos animados podem ser
encontradas no Livro dos Monstros, embora as plantas
menores que Grande não possuem dureza, a menos que
o Mestre determine o contrário.
Esta magia não afeta criaturas do tipo planta
(como Entes), assim como também não afeta material
vegetal morto (como uma túnica de algodão ou uma
corda de cânhamo).
Constrição: Como alternativa, é possível imbuir um
grau de mobilidade a todas as plantas dentro do alcance,
permitindo que elas se entrelacem nas criaturas na área
afetada. Este uso da magia duplica o efeito da magia
contrição. A Resistência à Magia não impede que as
criaturas sejam enredadas. Esse efeito permanece ativo
durante uma hora por nível de conjurador.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Curto (7,5 m + 1,5 m/2 níveis)',
    area_target_effect_text='Alvo: Uma planta Grande/3 níveis de conjura-',
    duration='1 rodada/nível ou 1 hora/nível (veja',
    saving_throw='Nenhum',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Componentes: V, G');
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Componentes: V, G'), 7);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (17, (SELECT id FROM spells WHERE name='Componentes: V, G'), 7);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Antipatia', 'Essa magia é capaz de fazer um objeto ou local
emanar vibrações que repelem um tipo específico de
criatura ou as criaturas inteligentes de uma determinada
tendência. O tipo escolhido de criatura a ser afetado
deve ser especificado – sejam dragões vermelhos, gigan-
tes da colina, homens-ratos, lammasu ou vampiros. Os
grupos maiores, como goblinóides, não são específicos
o bastante. Do mesmo modo, uma tendência específica
precisa ser definida – por exemplo, Caótico e Mau,
Caótico e Bom, Leal e Neutro ou Neutro.
As criaturas do tipo ou da tendência escolhida
sentem uma ânsia desesperada para abandonar a área
ou evitar o item afetado. Essa compulsão as obriga a
abandonar a área ou o objeto, evitando-a e não re-
tornando até que a magia termine. Uma criatura que
obtenha sucesso em um teste de resistência poderá ficar
na área ou tocar o item, mas se sentirá desconfortável.
Este desconforto reduz o valor de Destreza da criatura
em 4 pontos.
Antipatia serve de contramágica e dissipa sim-
patia.
Componente Material Arcano: Um pedaço de
alumínio mergulhado em vinagre.', 4, 'Compulsão', '[Ação mental]', '1 hora Alcance: Curto', '', 'Alvo: Um local (até um cubo de 3 m/nível) ou', '2 horas/nível (D)', 'Vontade parcial', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Essa magia é capaz de fazer um objeto ou local
emanar vibrações que repelem um tipo específico de
criatura ou as criaturas inteligentes de uma determinada
tendência. O tipo escolhido de criatura a ser afetado
deve ser especificado – sejam dragões vermelhos, gigan-
tes da colina, homens-ratos, lammasu ou vampiros. Os
grupos maiores, como goblinóides, não são específicos
o bastante. Do mesmo modo, uma tendência específica
precisa ser definida – por exemplo, Caótico e Mau,
Caótico e Bom, Leal e Neutro ou Neutro.
As criaturas do tipo ou da tendência escolhida
sentem uma ânsia desesperada para abandonar a área
ou evitar o item afetado. Essa compulsão as obriga a
abandonar a área ou o objeto, evitando-a e não re-
tornando até que a magia termine. Uma criatura que
obtenha sucesso em um teste de resistência poderá ficar
na área ou tocar o item, mas se sentirá desconfortável.
Este desconforto reduz o valor de Destreza da criatura
em 4 pontos.
Antipatia serve de contramágica e dissipa sim-
patia.
Componente Material Arcano: Um pedaço de
alumínio mergulhado em vinagre.', 
    school_id=4, 
    subschool='Compulsão', 
    descriptors='[Ação mental]', 
    casting_time='1 hora Alcance: Curto',
    range_text='',
    area_target_effect_text='Alvo: Um local (até um cubo de 3 m/nível) ou',
    duration='2 horas/nível (D)',
    saving_throw='Vontade parcial',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Antipatia');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Antipatia'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Antipatia'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Antipatia'), 3, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Antipatia'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Antipatia'), 9);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Antipatia'), 8);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Antipatia'), 8);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Apagar', 'Apagar remove um texto, mágico ou mundano, de
um pergaminho ou de até duas páginas de papel, papiro
ou superfícies similares. Ela remove runas explosivas,
símbolo de proteção, o selo da serpente sépia, marca arcana
mas não remove escrita ilusória ou símbolo. As escritas
comuns são imediatamente apagadas se o conjurador
tocá-las e ninguém mais estiver segurando o objeto
– nesse último caso, há 90% de chance de apagar a
inscrição. As escritas mágicas precisam ser tocadas e o
personagem deve obter sucesso num teste de conjurador
(1d20 + nível de conjurador) contra CD 15. Um resul-
tado 1 ou 2 natural sempre representa uma falha. Se o
conjurador fracassar em apagar as runas explosivas, um
símbolo de proteção ou o selo da serpente sépia, a magia
será ativada acidentalmente.', 8, '', '', '1 ação padrão', 'Curto (7,5 m + 1,5 m/2 níveis)', 'Alvo: Um pergaminho ou duas páginas', 'Instantânea', 'Veja texto', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='Apagar remove um texto, mágico ou mundano, de
um pergaminho ou de até duas páginas de papel, papiro
ou superfícies similares. Ela remove runas explosivas,
símbolo de proteção, o selo da serpente sépia, marca arcana
mas não remove escrita ilusória ou símbolo. As escritas
comuns são imediatamente apagadas se o conjurador
tocá-las e ninguém mais estiver segurando o objeto
– nesse último caso, há 90% de chance de apagar a
inscrição. As escritas mágicas precisam ser tocadas e o
personagem deve obter sucesso num teste de conjurador
(1d20 + nível de conjurador) contra CD 15. Um resul-
tado 1 ou 2 natural sempre representa uma falha. Se o
conjurador fracassar em apagar as runas explosivas, um
símbolo de proteção ou o selo da serpente sépia, a magia
será ativada acidentalmente.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Curto (7,5 m + 1,5 m/2 níveis)',
    area_target_effect_text='Alvo: Um pergaminho ou duas páginas',
    duration='Instantânea',
    saving_throw='Veja texto',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Apagar');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Apagar'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Apagar'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Apagar'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Apagar'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Apagar'), 1);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Aprisionamento', 'Quando o personagem conjura aprisionamento e
toca uma criatura, ela é enterrada num estado de ani-
mação suspensa (veja a magia estase temporal) em uma
pequena esfera abaixo da superfície da terra. O alvo
permanecerá nesse local, a menos que a magia libertação
seja conjurada no local onde ocorreu o aprisionamento.
Uma investigação mágica com uma bola de cristal, a
magia localizar objeto ou outras adivinhações similares
não revelam o fato da criatura estar aprisionada, mas
discernir localização revela. Uma magia desejo ou mi-
lagre não libertará o alvo, mas indicará onde ele está
enterrado. Se o personagem souber o nome da vítima
e alguns detalhes sobre a vida dela, o alvo sofre -4 de
penalidade em seu teste de resistência.', 1, '', '', '1 ação padrão', 'Toque', 'Alvo: Criatura tocada', 'Instantânea', 'Vontade anula; veja texto', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Quando o personagem conjura aprisionamento e
toca uma criatura, ela é enterrada num estado de ani-
mação suspensa (veja a magia estase temporal) em uma
pequena esfera abaixo da superfície da terra. O alvo
permanecerá nesse local, a menos que a magia libertação
seja conjurada no local onde ocorreu o aprisionamento.
Uma investigação mágica com uma bola de cristal, a
magia localizar objeto ou outras adivinhações similares
não revelam o fato da criatura estar aprisionada, mas
discernir localização revela. Uma magia desejo ou mi-
lagre não libertará o alvo, mas indicará onde ele está
enterrado. Se o personagem souber o nome da vítima
e alguns detalhes sobre a vida dela, o alvo sofre -4 de
penalidade em seu teste de resistência.', 
    school_id=1, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Toque',
    area_target_effect_text='Alvo: Criatura tocada',
    duration='Instantânea',
    saving_throw='Vontade anula; veja texto',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Aprisionamento');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aprisionamento'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aprisionamento'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Aprisionamento'), 9);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Aprisionamento'), 9);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Aprisionar a Alma', 'Aprisionar a alma absorve a força vital de uma
criatura (e seu corpo material) para o interior de uma
gema.
A gema mantém a entidade aprisionada indefini-
damente ou até ser quebrada e a força vital ser liberada,
o que permite a materialização de seu corpo. Se a
criatura aprisionada for um uma criatura poderosa de
outro plano (o que poderia significar um personagem
aprisionado por um habitante de outro plano quando
ele não estiver no Plano Material), pode-se exigir o
cumprimento de uma tarefa em troca da liberdade.
Caso contrário, a criatura somente conseguirá partir
depois que a gema for quebrada.
Dependendo da versão selecionada, a magia pode
ser ativada de duas formas.
Magia Completa: Primeiro, a magia deve ser com-
pletada pronunciando sua palavra de ativação, usando
uma ação padrão como uma magia normal conjurada
sobre o alvo. Isso permite a utilização da Resistência à
Magia (se houver) e um teste de resistência de Vontade
para anular ao efeito. Se o nome da criatura também for
pronunciado, qualquer Resistência à Magia é ignorada
e a CD do teste de resistência aumenta em 2 pontos.
Se o alvo obtiver sucesso no teste de resistência ou na
Resistência à Magia, a gema se quebra.
Objeto Armadilha: O segundo método é mais
traiçoeiro, pois depende do alvo aceitar um objeto com
a palavra de ativação da magia inscrita, aprisionando a
alma dela imediatamente na armadilha. Para usar este
método, o nome da criatura e a palavra de ativação da
magia devem estar inscritos no objeto quando a gema é
encantada. Uma magia simpatia também pode ser usada
sobre o objeto. Assim que o alvo tocar o objeto, sua
força vital é transferida para a gema, sem aplicar a Re-
sistência à Magia ou realizar um teste de resistência.
Componente Material: Antes de conjurar a magia,
o personagem precisa encontrar uma gema de pelo
menos 1.000 PO para cada Dado de Vida da criatura
a ser aprisionada (por exemplo, uma gema de 10,000
PO para aprisionar uma criatura de 10 DV). Se a gema
não for valiosa o bastante, ela se quebrará quando a
magia for conjurada. (Apesar dos personagens não
conhecerem os conceitos de nível ou Dado de Vida, o
valor da gema necessária para aprisionar um indivíduo
pode ser pesquisado. Lembre-se que esse valor pode
mudar com o tempo, conforme a criatura adquira mais
Dados de Vida.)
Foco (Somente para Objeto Armadilha): Se o mé-
todo de objeto armadilha for usado, um objeto de
ativação especial, preparado conforme descrito acima,
será necessário.', 2, 'Invocação', '', '1 ação padrão ou veja', 'Curto (7,5 m + 1,5 m/2 níveis)', 'Alvo: Uma criatura', 'Permanente; veja texto', 'Veja texto', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Aprisionar a alma absorve a força vital de uma
criatura (e seu corpo material) para o interior de uma
gema.
A gema mantém a entidade aprisionada indefini-
damente ou até ser quebrada e a força vital ser liberada,
o que permite a materialização de seu corpo. Se a
criatura aprisionada for um uma criatura poderosa de
outro plano (o que poderia significar um personagem
aprisionado por um habitante de outro plano quando
ele não estiver no Plano Material), pode-se exigir o
cumprimento de uma tarefa em troca da liberdade.
Caso contrário, a criatura somente conseguirá partir
depois que a gema for quebrada.
Dependendo da versão selecionada, a magia pode
ser ativada de duas formas.
Magia Completa: Primeiro, a magia deve ser com-
pletada pronunciando sua palavra de ativação, usando
uma ação padrão como uma magia normal conjurada
sobre o alvo. Isso permite a utilização da Resistência à
Magia (se houver) e um teste de resistência de Vontade
para anular ao efeito. Se o nome da criatura também for
pronunciado, qualquer Resistência à Magia é ignorada
e a CD do teste de resistência aumenta em 2 pontos.
Se o alvo obtiver sucesso no teste de resistência ou na
Resistência à Magia, a gema se quebra.
Objeto Armadilha: O segundo método é mais
traiçoeiro, pois depende do alvo aceitar um objeto com
a palavra de ativação da magia inscrita, aprisionando a
alma dela imediatamente na armadilha. Para usar este
método, o nome da criatura e a palavra de ativação da
magia devem estar inscritos no objeto quando a gema é
encantada. Uma magia simpatia também pode ser usada
sobre o objeto. Assim que o alvo tocar o objeto, sua
força vital é transferida para a gema, sem aplicar a Re-
sistência à Magia ou realizar um teste de resistência.
Componente Material: Antes de conjurar a magia,
o personagem precisa encontrar uma gema de pelo
menos 1.000 PO para cada Dado de Vida da criatura
a ser aprisionada (por exemplo, uma gema de 10,000
PO para aprisionar uma criatura de 10 DV). Se a gema
não for valiosa o bastante, ela se quebrará quando a
magia for conjurada. (Apesar dos personagens não
conhecerem os conceitos de nível ou Dado de Vida, o
valor da gema necessária para aprisionar um indivíduo
pode ser pesquisado. Lembre-se que esse valor pode
mudar com o tempo, conforme a criatura adquira mais
Dados de Vida.)
Foco (Somente para Objeto Armadilha): Se o mé-
todo de objeto armadilha for usado, um objeto de
ativação especial, preparado conforme descrito acima,
será necessário.', 
    school_id=2, 
    subschool='Invocação', 
    descriptors='', 
    casting_time='1 ação padrão ou veja',
    range_text='Curto (7,5 m + 1,5 m/2 níveis)',
    area_target_effect_text='Alvo: Uma criatura',
    duration='Permanente; veja texto',
    saving_throw='Veja texto',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Aprisionar a Alma');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aprisionar a Alma'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aprisionar a Alma'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aprisionar a Alma'), 3, '(F); veja texto');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Aprisionar a Alma'), 8);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Aprisionar a Alma'), 8);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Área Escorregadia', 'A magia área escorregadia recobre a superfície
afetada com uma substância gordurosa e escorregadia.
Qualquer criatura na área quando a magia for conju-
rada precisa obter sucesso em um teste de resistência
de Reflexos ou cairá. Esse teste de resistência deve ser
realizado no turno da criatura em todas as rodadas que
ela permanecer na área. Uma criatura pode andar ou
atravessar a área escorregadia usando metade de seu
deslocamento com um teste de Equilíbrio (CD 10).
Um fracasso nesse teste significa que a criatura não
poderá se deslocar naquela rodada (e deverá realizar
um teste de resistência de Reflexos ou cairá), enquanto
um fracasso com uma margem igual ou superior a 5
pontos indica uma queda (veja a perícia Equilíbrio para
obter detalhes).
O Mestre deve ajustar o teste de resistência de acor-
do com as circunstâncias. Por exemplo, uma criatura
realizando uma Investida em uma encosta teria poucas
chances de evitar o efeito, mas sua chance de sair da
área é quase total (quer queira, quer não).
A magia também pode ser utilizada para tornar
um item escorregadio – por exemplo, uma corda, uma
escada ou o cabo de uma espada. Os objetos que não
estejam em uso são sempre afetados, mas os objetos
que estiverem em uso por criaturas usam o teste de
resistência de Reflexos do portador para evitar o efeito.
Se esse teste fracassar, a criatura derruba imediatamente
o item. É necessário realizar o teste de resistência a cada
rodada que a criatura tentar segurar ou usar o objeto
afetado. Uma criatura usando uma armadura ou roupa
escorregadia tem +10 de bônus de circunstância nos
testes de Arte da Fuga e Agarrar para resistir ou escapar
das manobras Agarrar ou Imobilização.
Componente Material: Couro de porco ou man-
teiga.', 2, 'Criação', '', '1 ação padrão', 'Curto (7,5 m + 1,5 m/2 níveis)', '', '1 rodada/nível (D)', 'Veja texto', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='A magia área escorregadia recobre a superfície
afetada com uma substância gordurosa e escorregadia.
Qualquer criatura na área quando a magia for conju-
rada precisa obter sucesso em um teste de resistência
de Reflexos ou cairá. Esse teste de resistência deve ser
realizado no turno da criatura em todas as rodadas que
ela permanecer na área. Uma criatura pode andar ou
atravessar a área escorregadia usando metade de seu
deslocamento com um teste de Equilíbrio (CD 10).
Um fracasso nesse teste significa que a criatura não
poderá se deslocar naquela rodada (e deverá realizar
um teste de resistência de Reflexos ou cairá), enquanto
um fracasso com uma margem igual ou superior a 5
pontos indica uma queda (veja a perícia Equilíbrio para
obter detalhes).
O Mestre deve ajustar o teste de resistência de acor-
do com as circunstâncias. Por exemplo, uma criatura
realizando uma Investida em uma encosta teria poucas
chances de evitar o efeito, mas sua chance de sair da
área é quase total (quer queira, quer não).
A magia também pode ser utilizada para tornar
um item escorregadio – por exemplo, uma corda, uma
escada ou o cabo de uma espada. Os objetos que não
estejam em uso são sempre afetados, mas os objetos
que estiverem em uso por criaturas usam o teste de
resistência de Reflexos do portador para evitar o efeito.
Se esse teste fracassar, a criatura derruba imediatamente
o item. É necessário realizar o teste de resistência a cada
rodada que a criatura tentar segurar ou usar o objeto
afetado. Uma criatura usando uma armadura ou roupa
escorregadia tem +10 de bônus de circunstância nos
testes de Arte da Fuga e Agarrar para resistir ou escapar
das manobras Agarrar ou Imobilização.
Componente Material: Couro de porco ou man-
teiga.', 
    school_id=2, 
    subschool='Criação', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Curto (7,5 m + 1,5 m/2 níveis)',
    area_target_effect_text='',
    duration='1 rodada/nível (D)',
    saving_throw='Veja texto',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Área Escorregadia');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Área Escorregadia'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Área Escorregadia'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Área Escorregadia'), 3, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Área Escorregadia'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Área Escorregadia'), 1);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Arca Secreta de Leomund', 'O personagem é capaz de esconder uma arca no
Plano Etéreo e invocá-la conforme desejar durante
sessenta dias. A arca pode comportar até 30 cm³ de
material por nível do conjurador (independente do ta-
manho da arca, que deve ser 90 cm x 60 cm x 60 cm). Se
houver uma criatura viva na arca, existe 75% de chance
da magia simplesmente fracassar. Uma vez escondida, o
personagem conseguirá invocá-la se concentrando (uma
ação padrão) e ela aparecerá adjacente a ele.
A arca deve ser muito bem construída e cara,
fabricada pelos melhores mestres artesãos. Caso seja
de madeira, deve-se utilizar ébano, sândalo ou similar,
com as cantoneiras, ferragens e pregos de platina. Caso
seja de marfim as partes de metal devem ser de ouro. As
arcas de bronze, cobre ou prata devem ter ferragens de
prata ou electrum (um metal valioso). O custo da arca
nunca é inferior a 5.000 peças de ouro. Uma vez cons-
truída, o personagem precisa criar uma pequena réplica
(dos mesmos materiais e perfeita em cada detalhe), de
modo que a miniatura seja uma cópia exata da arca. A
réplica custa 50 PO. O personagem somente é capaz
de possuir 1 par dessas arcas simultaneamente – mesmo
desejo não permite criar mais. Esses recipientes não
são mágicos e podem ser fabricados com fechaduras,
proteções e similares, como um arca normal.
Para esconder a arca, o personagem conjura a ma-
gia tocando a arca e a réplica, escondendo a primeira
no Plano Etéreo. O conjurador precisa da réplica para
invocar a arca. Após sessenta dias, existe 5% de chance
cumulativa por dia do baú ser irrecuperavelmente
perdido. Se a miniatura da arca se perder ou ser des-
truída, não existe chance alguma, mesmo com a magia
desejo, de recuperar a arca, exceto com uma expedição
extra-planar
Seres vivos na arca comem, dormem e envelhecem
normalmente e morrem caso fiquem sem comida, ar,
água ou qualquer coisa que precisem para sobreviver.
Foco: A arca e a réplica.', 2, 'Invocação', '', '10 minutos', 'Veja texto', 'Alvo: Um baú e até 30 cm de objetos/nível do', 'Sessenta dias ou até ser dissipada', 'Nenhum', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='O personagem é capaz de esconder uma arca no
Plano Etéreo e invocá-la conforme desejar durante
sessenta dias. A arca pode comportar até 30 cm³ de
material por nível do conjurador (independente do ta-
manho da arca, que deve ser 90 cm x 60 cm x 60 cm). Se
houver uma criatura viva na arca, existe 75% de chance
da magia simplesmente fracassar. Uma vez escondida, o
personagem conseguirá invocá-la se concentrando (uma
ação padrão) e ela aparecerá adjacente a ele.
A arca deve ser muito bem construída e cara,
fabricada pelos melhores mestres artesãos. Caso seja
de madeira, deve-se utilizar ébano, sândalo ou similar,
com as cantoneiras, ferragens e pregos de platina. Caso
seja de marfim as partes de metal devem ser de ouro. As
arcas de bronze, cobre ou prata devem ter ferragens de
prata ou electrum (um metal valioso). O custo da arca
nunca é inferior a 5.000 peças de ouro. Uma vez cons-
truída, o personagem precisa criar uma pequena réplica
(dos mesmos materiais e perfeita em cada detalhe), de
modo que a miniatura seja uma cópia exata da arca. A
réplica custa 50 PO. O personagem somente é capaz
de possuir 1 par dessas arcas simultaneamente – mesmo
desejo não permite criar mais. Esses recipientes não
são mágicos e podem ser fabricados com fechaduras,
proteções e similares, como um arca normal.
Para esconder a arca, o personagem conjura a ma-
gia tocando a arca e a réplica, escondendo a primeira
no Plano Etéreo. O conjurador precisa da réplica para
invocar a arca. Após sessenta dias, existe 5% de chance
cumulativa por dia do baú ser irrecuperavelmente
perdido. Se a miniatura da arca se perder ou ser des-
truída, não existe chance alguma, mesmo com a magia
desejo, de recuperar a arca, exceto com uma expedição
extra-planar
Seres vivos na arca comem, dormem e envelhecem
normalmente e morrem caso fiquem sem comida, ar,
água ou qualquer coisa que precisem para sobreviver.
Foco: A arca e a réplica.', 
    school_id=2, 
    subschool='Invocação', 
    descriptors='', 
    casting_time='10 minutos',
    range_text='Veja texto',
    area_target_effect_text='Alvo: Um baú e até 30 cm de objetos/nível do',
    duration='Sessenta dias ou até ser dissipada',
    saving_throw='Nenhum',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Arca Secreta de Leomund');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Arca Secreta de Leomund'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Arca Secreta de Leomund'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Arca Secreta de Leomund'), 4, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Arca Secreta de Leomund'), 5);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Arca Secreta de Leomund'), 5);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Arma Abençoada', 'A própria clava de carvalho ou bordão de madeira
do conjurador se torna uma arma com +1 de bônus de
melhoria para jogadas de ataque e dano. Um bordão
recebe esse bônus de melhoria em suas duas extremi-
dades. Ele causa dano como se fosse uma arma de duas
categorias de tamanho maior (uma clava ou bordão
Pequeno transmutado causaria 1d8 pontos de dano,
um Médio infligiria 2d6 e um Grande causaria 3d6),
+1 devido ao bônus de melhoria. Esse efeito só ocorre
quando a arma for empunhada pelo conjurador. Caso
contrário, a arma funcionará como um objeto comum,
que não foi alvo dessa magia.', 8, '', '', '1 ação padrão', 'Toque', 'Alvo: Uma clava de carvalho ou bordão mun-', '1 minuto/nível', 'Vontade anula (objeto)', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='A própria clava de carvalho ou bordão de madeira
do conjurador se torna uma arma com +1 de bônus de
melhoria para jogadas de ataque e dano. Um bordão
recebe esse bônus de melhoria em suas duas extremi-
dades. Ele causa dano como se fosse uma arma de duas
categorias de tamanho maior (uma clava ou bordão
Pequeno transmutado causaria 1d8 pontos de dano,
um Médio infligiria 2d6 e um Grande causaria 3d6),
+1 devido ao bônus de melhoria. Esse efeito só ocorre
quando a arma for empunhada pelo conjurador. Caso
contrário, a arma funcionará como um objeto comum,
que não foi alvo dessa magia.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Toque',
    area_target_effect_text='Alvo: Uma clava de carvalho ou bordão mun-',
    duration='1 minuto/nível',
    saving_throw='Vontade anula (objeto)',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Arma Abençoada');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Arma Abençoada'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Arma Abençoada'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Arma Abençoada'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Arma Abençoada'), 1);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Arma Espiritual', 'Uma arma feita de energia surge e ataca os opo-
nentes a distância, da forma que o conjurador dire-
cioná-la, causando 1d8 pontos de dano de energia
por golpe, +1 ponto a cada três níveis de conjurador
(máximo +5 no 15° nível). A arma assume a forma da
arma predileta da divindade do conjurador ou de uma
arma com algum significado ou simbolismo espiritual
para ele (veja abaixo) e possui a mesma margem de
ameaça e multiplicador de sucesso decisivo da arma
real Ela ataca o oponente escolhido, realizando um
ataque na rodada da conjuração e outro a cada rodada
subseqüente em seu turno. Ela utiliza o bônus base de
ataque do conjurador (permitindo ataques múltiplos
nas rodadas seguintes) mais o modificador de Sabedoria
como bônus de ataque. Ela é considerada uma magia e
não uma arma, portanto afeta as criaturas que possuem
Redução de Dano. Como um efeito de energia, ela
consegue atingir criaturas incorpóreas sem a chance de
falha normalmente associada à elas. Ela sempre ataca
a partir da direção do personagem e não recebe ou
concede bônus de flanquear a outro combatente. Os
talentos do conjurador (como Foco em Arma) ou ações
de combate (como Investida) não têm efeito na arma. Se
a arma ultrapassar o alcance da magia, a linha de visão
do conjurador ou não receber comandos, ela retornará
para o lado do personagem e ficará flutuando.
A cada rodada depois da primeira, é possível
utilizar uma ação padrão para redirecionar a arma para
um novo alvo. Caso contrário, ela continuara a atacar
o mesmo alvo anterior Cada vez que a arma mudar de
alvo, ela desfere somente um ataque. Nas rodadas subse-
qüentes em que golpear o mesmo adversário, ela poderá
realizar ataques múltiplos, se o bônus base de ataque
do conjurador permitir. Mesmo se a arma espiritual for
uma arma de ataque à distância, utilize o alcance da
magia e não o incremento de distância da arma normal;
mudar o alvo ainda exige uma ação padrão.
A arma espiritual não pode ser atacada ou sofrer
dano de ataques físicos, mas dissipar magia, desintegrar,
esfera da aniquilação e um bastão de cancelamento a
afetam. A CA da arma espiritual contra ataques de
toque é 12 (10 + bônus de tamanho de um objeto
Miúdo).
Se uma criatura atacada possuir Resistência à
Magia o personagem realiza um teste de conjurador
(1d20 + nível do conjurador) contra a Resistência à
Magia na primeira vez que a arma espiritual golpear o
alvo. Caso não supere a RM da criatura, a arma será
dissipada. Caso contrário, a arma afetará normalmente
essa criatura enquanto a magia permanecer ativa.
Normalmente, a arma criada é uma réplica de
energia da arma pessoal da divindade do personagem e
muitas vezes possui um nome próprio. Um clérigo que
não adore uma divindade criará uma arma baseada em
sua tendência. Um clérigo Neutro que não venere um
deus criará uma arma de qualquer tendência, de acordo
com a tendência adequada ao momento. As armas de
cada deus e tendência são:
Deus
Arma
Tendência
Espiritual
Boccob:
Bordão; “Cajado de Boccob”
Corellon Larethian: Espada longa, “Sahandrian”
Ehlonna:
Arco longo, “Jenevier”
Erythnul:
Maça-estrela, “Agonia”
Fharlanghn:
Bordão, “Amigo do Viajante”
Garl Glittergold: Machado de batalha,
“Arumdina”
Gruumsh:
Heironeous:
Hextor:
Kord:
Moradin:
Nerull:
Obad-Hai:
Olidammara:
Pelor:
St. Cuthbert:
Vecna:
Wee Jas:
Yondalla:
Caos:
Mal:
Bem:
Ordem:
Lança, “Lança Sangrenta”
Espada longa, “Arauto da
Justiça”
Mangual, “Executor”
Espada Larga, “Kelmar”
Martelo de Guerra, “Martelo
Espiritual”
Foice Longa, “Ceifadora da
Vida”
Bordão, “Toque da
Tempestade”
Sabre, “Ataque Rápido”
Maça, “Cetro Solar”
Maça, “A Maça de Cuthbert”
Adaga, “Arrependimento”
Adaga, “Discrição”
Espada curta, “Lâmina da
Cornucópia”
Machado de Batalha, “A
Lâmina da Mudança”
Mangual Leve, “O Flagelo das
Almas”
Martelo de Guerra, “O Martelo
da justiça”
Espada longa, “A Espada da
Verdade”', 5, '', '[Energia]', '1 ação padrão', 'Médio (30 metros + 3 metros/nível)', 'Efeito: Uma arma mágica de energia', '1 rodada/nível (D)', 'Nenhum', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Uma arma feita de energia surge e ataca os opo-
nentes a distância, da forma que o conjurador dire-
cioná-la, causando 1d8 pontos de dano de energia
por golpe, +1 ponto a cada três níveis de conjurador
(máximo +5 no 15° nível). A arma assume a forma da
arma predileta da divindade do conjurador ou de uma
arma com algum significado ou simbolismo espiritual
para ele (veja abaixo) e possui a mesma margem de
ameaça e multiplicador de sucesso decisivo da arma
real Ela ataca o oponente escolhido, realizando um
ataque na rodada da conjuração e outro a cada rodada
subseqüente em seu turno. Ela utiliza o bônus base de
ataque do conjurador (permitindo ataques múltiplos
nas rodadas seguintes) mais o modificador de Sabedoria
como bônus de ataque. Ela é considerada uma magia e
não uma arma, portanto afeta as criaturas que possuem
Redução de Dano. Como um efeito de energia, ela
consegue atingir criaturas incorpóreas sem a chance de
falha normalmente associada à elas. Ela sempre ataca
a partir da direção do personagem e não recebe ou
concede bônus de flanquear a outro combatente. Os
talentos do conjurador (como Foco em Arma) ou ações
de combate (como Investida) não têm efeito na arma. Se
a arma ultrapassar o alcance da magia, a linha de visão
do conjurador ou não receber comandos, ela retornará
para o lado do personagem e ficará flutuando.
A cada rodada depois da primeira, é possível
utilizar uma ação padrão para redirecionar a arma para
um novo alvo. Caso contrário, ela continuara a atacar
o mesmo alvo anterior Cada vez que a arma mudar de
alvo, ela desfere somente um ataque. Nas rodadas subse-
qüentes em que golpear o mesmo adversário, ela poderá
realizar ataques múltiplos, se o bônus base de ataque
do conjurador permitir. Mesmo se a arma espiritual for
uma arma de ataque à distância, utilize o alcance da
magia e não o incremento de distância da arma normal;
mudar o alvo ainda exige uma ação padrão.
A arma espiritual não pode ser atacada ou sofrer
dano de ataques físicos, mas dissipar magia, desintegrar,
esfera da aniquilação e um bastão de cancelamento a
afetam. A CA da arma espiritual contra ataques de
toque é 12 (10 + bônus de tamanho de um objeto
Miúdo).
Se uma criatura atacada possuir Resistência à
Magia o personagem realiza um teste de conjurador
(1d20 + nível do conjurador) contra a Resistência à
Magia na primeira vez que a arma espiritual golpear o
alvo. Caso não supere a RM da criatura, a arma será
dissipada. Caso contrário, a arma afetará normalmente
essa criatura enquanto a magia permanecer ativa.
Normalmente, a arma criada é uma réplica de
energia da arma pessoal da divindade do personagem e
muitas vezes possui um nome próprio. Um clérigo que
não adore uma divindade criará uma arma baseada em
sua tendência. Um clérigo Neutro que não venere um
deus criará uma arma de qualquer tendência, de acordo
com a tendência adequada ao momento. As armas de
cada deus e tendência são:
Deus
Arma
Tendência
Espiritual
Boccob:
Bordão; “Cajado de Boccob”
Corellon Larethian: Espada longa, “Sahandrian”
Ehlonna:
Arco longo, “Jenevier”
Erythnul:
Maça-estrela, “Agonia”
Fharlanghn:
Bordão, “Amigo do Viajante”
Garl Glittergold: Machado de batalha,
“Arumdina”
Gruumsh:
Heironeous:
Hextor:
Kord:
Moradin:
Nerull:
Obad-Hai:
Olidammara:
Pelor:
St. Cuthbert:
Vecna:
Wee Jas:
Yondalla:
Caos:
Mal:
Bem:
Ordem:
Lança, “Lança Sangrenta”
Espada longa, “Arauto da
Justiça”
Mangual, “Executor”
Espada Larga, “Kelmar”
Martelo de Guerra, “Martelo
Espiritual”
Foice Longa, “Ceifadora da
Vida”
Bordão, “Toque da
Tempestade”
Sabre, “Ataque Rápido”
Maça, “Cetro Solar”
Maça, “A Maça de Cuthbert”
Adaga, “Arrependimento”
Adaga, “Discrição”
Espada curta, “Lâmina da
Cornucópia”
Machado de Batalha, “A
Lâmina da Mudança”
Mangual Leve, “O Flagelo das
Almas”
Martelo de Guerra, “O Martelo
da justiça”
Espada longa, “A Espada da
Verdade”', 
    school_id=5, 
    subschool='', 
    descriptors='[Energia]', 
    casting_time='1 ação padrão',
    range_text='Médio (30 metros + 3 metros/nível)',
    area_target_effect_text='Efeito: Uma arma mágica de energia',
    duration='1 rodada/nível (D)',
    saving_throw='Nenhum',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Arma Espiritual');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Arma Espiritual'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Arma Espiritual'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Arma Espiritual'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Arma Espiritual'), 2);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (12, (SELECT id FROM spells WHERE name='Arma Espiritual'), 2);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Arma Mágica', 'Essa magia concede +1 de bônus de melhoria para
uma arma nas jogadas de ataque e dano. Um bônus de
melhoria não se acumula com o bônus de uma arma
obra-prima nas jogadas de ataque.
Não se pode conjurar essa magia sobre armas na-
turais, como um ataque desarmado (veja presa mágica),
O ataque desarmado de um monge é considerado uma
arma e pode ser aprimorado com essa magia.', 8, '', '', '1 ação padrão', 'Toque', 'Alvo: Arma tocada', '1 minuto/nível', 'Vontade anula (inofensiva,', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Essa magia concede +1 de bônus de melhoria para
uma arma nas jogadas de ataque e dano. Um bônus de
melhoria não se acumula com o bônus de uma arma
obra-prima nas jogadas de ataque.
Não se pode conjurar essa magia sobre armas na-
turais, como um ataque desarmado (veja presa mágica),
O ataque desarmado de um monge é considerado uma
arma e pode ser aprimorado com essa magia.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Toque',
    area_target_effect_text='Alvo: Arma tocada',
    duration='1 minuto/nível',
    saving_throw='Vontade anula (inofensiva,',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Arma Mágica');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Arma Mágica'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Arma Mágica'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Arma Mágica'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (7, (SELECT id FROM spells WHERE name='Arma Mágica'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Arma Mágica'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Arma Mágica'), 1);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (12, (SELECT id FROM spells WHERE name='Arma Mágica'), 1);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Arma Mágica Maior', 'Essa magia é similar a arma mágica, exceto pelo bô-
nus de melhoria nas jogadas de ataque e dano, que será
Uma alternativa é afetar até cinqüenta flechas,
virotes ou balas. Os projéteis devem ser do mesmo tipo
e estar juntos (na mesma aljava ou outro recipiente).
Os projéteis, mas não as armas de arremesso, perdem
a transmutação quando são disparados. Considere os
shuriken como um projétil, não uma arma de arremes-
so, em relação a essa magia.
Componentes Materiais: Pó de cal e carbono.', 8, '', '', '1 ação padrão', 'Curto (7,5 metros +1,5 metro/2 níveis)', 'Alvo: Uma arma ou cinqüenta projéteis (todos', '1 hora/nível', 'Vontade anula (inofensiva,', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Essa magia é similar a arma mágica, exceto pelo bô-
nus de melhoria nas jogadas de ataque e dano, que será
Uma alternativa é afetar até cinqüenta flechas,
virotes ou balas. Os projéteis devem ser do mesmo tipo
e estar juntos (na mesma aljava ou outro recipiente).
Os projéteis, mas não as armas de arremesso, perdem
a transmutação quando são disparados. Considere os
shuriken como um projétil, não uma arma de arremes-
so, em relação a essa magia.
Componentes Materiais: Pó de cal e carbono.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Curto (7,5 metros +1,5 metro/2 níveis)',
    area_target_effect_text='Alvo: Uma arma ou cinqüenta projéteis (todos',
    duration='1 hora/nível',
    saving_throw='Vontade anula (inofensiva,',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Arma Mágica Maior');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Arma Mágica Maior'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Arma Mágica Maior'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Arma Mágica Maior'), 3, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Arma Mágica Maior'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Arma Mágica Maior'), 4);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (7, (SELECT id FROM spells WHERE name='Arma Mágica Maior'), 3);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Arma Mágica Maior'), 3);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Arma Mágica Maior'), 3);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Arma do Rompimento', 'Esta magia faz com que uma arma branca se torne
letal contra os mortos-vivos. Qualquer morto-vivo com
um total de DV igual ou inferior ao nível do conjurador
precisará obter sucesso em um teste de resistência de
Vontade ou será completamente destruído quando for
atingido em combate pela arma encantada. A RM não
se aplica ao efeito de destruição.', 8, '', '', '1 ação padrão', 'Toque', 'Efeito: 1 arma de corpo a corpo', '1 rodada/nível', 'Vontade anula (inofensiva,', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Esta magia faz com que uma arma branca se torne
letal contra os mortos-vivos. Qualquer morto-vivo com
um total de DV igual ou inferior ao nível do conjurador
precisará obter sucesso em um teste de resistência de
Vontade ou será completamente destruído quando for
atingido em combate pela arma encantada. A RM não
se aplica ao efeito de destruição.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Toque',
    area_target_effect_text='Efeito: 1 arma de corpo a corpo',
    duration='1 rodada/nível',
    saving_throw='Vontade anula (inofensiva,',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Arma do Rompimento');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Arma do Rompimento'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Arma do Rompimento'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Arma do Rompimento'), 5);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Armadilha', 'Essa magia permite criar um laço que funciona
como uma armadilha mágica. A armadilha pode ser
feita de qualquer cipó, cordão ou tira de couro. Quando
conjurar armadilha sobre ele, o objeto se incorpora aos
arredores (CD 23 para os personagens com a habilidade
encontrar armadilhas localizá-la). Uma ponta do laço se
enrola em torno de um ou mais membros da criatura
que pisar no círculo. A cabeça de um verme ou de uma
serpente pode ficar presa, por exemplo.
Se uma árvore forte e flexível estiver próxima
ao local, a armadilha pode ficar amarrada nela. A
magia curva a árvore, endireitando-a quando o laço
for ativado, causando 1d6 pontos de dano à criatura
presa e erguendo-a do chão através do membro ou
membros presos. Se não houver uma árvore próxima,
o objeto se enrosca na criatura, prendendo-a, mas não
causa dano.
A armadilha é mágica. Para escapar, a criatura
precisa obter sucesso em um teste de Arte da Fuga (CD
23) ou em uma teste de Força (CD 23), que exige uma
ação de rodada completa. A armadilha possui CA 7 e
5 pontos de vida. Escapar da armadilha quebra o laço
e dissipa a magia.', 8, '', '', '3 rodadas', 'Toque', 'Alvo: Um círculo de cipó, corda e tira de couro', 'Até ser disparada ou destruída', 'Nenhum', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='Essa magia permite criar um laço que funciona
como uma armadilha mágica. A armadilha pode ser
feita de qualquer cipó, cordão ou tira de couro. Quando
conjurar armadilha sobre ele, o objeto se incorpora aos
arredores (CD 23 para os personagens com a habilidade
encontrar armadilhas localizá-la). Uma ponta do laço se
enrola em torno de um ou mais membros da criatura
que pisar no círculo. A cabeça de um verme ou de uma
serpente pode ficar presa, por exemplo.
Se uma árvore forte e flexível estiver próxima
ao local, a armadilha pode ficar amarrada nela. A
magia curva a árvore, endireitando-a quando o laço
for ativado, causando 1d6 pontos de dano à criatura
presa e erguendo-a do chão através do membro ou
membros presos. Se não houver uma árvore próxima,
o objeto se enrosca na criatura, prendendo-a, mas não
causa dano.
A armadilha é mágica. Para escapar, a criatura
precisa obter sucesso em um teste de Arte da Fuga (CD
23) ou em uma teste de Força (CD 23), que exige uma
ação de rodada completa. A armadilha possui CA 7 e
5 pontos de vida. Escapar da armadilha quebra o laço
e dissipa a magia.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='3 rodadas',
    range_text='Toque',
    area_target_effect_text='Alvo: Um círculo de cipó, corda e tira de couro',
    duration='Até ser disparada ou destruída',
    saving_throw='Nenhum',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Armadilha');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Armadilha'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Armadilha'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Armadilha'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (8, (SELECT id FROM spells WHERE name='Armadilha'), 2);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Armadilha'), 3);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Armadilha de Fogo', 'A armadilha de fogo gera uma explosão de fogo
quando um invasor abre o item protegido. Ela é capaz
de proteger qualquer objeto que tenha um mecanismo
de abertura (livros, caixas, garrafas, cestas, caixões,
portas, gavetas, etc.).
Ao conjurar a magia, o personagem escolhe um
ponto no item como seu centro. Quando alguém abrir
indevidamente o item, uma explosão de fogo preenche
uma área de 1,5 m de raio em torno do centro da magia.
As chamas causam 1d4 pontos de dano +1 por nível
de conjurador (máximo +20). O item protegido pela
armadilha não é afetado pela explosão.
Nenhuma outra magia de proteção pode ser con-
jurada sobre o mesmo item.
Uma magia arrombar anula armadilha de fogo.
Dissipar magia que não obtenha sucesso não dispara
a armadilha.
Sob a água, essa magia causa metade do dano e cria
uma grande nuvem de vapor.
O conjurador, assim como qualquer outra pessoa
vinculada ao objeto, consegue usá-lo normalmente.
Vincular um objeto sob efeito da magia à uma pessoa
geralmente envolve uma palavra secreta que o persona-
gem pode compartilhar com seus amigos.
Observação: As armadilhas mágicas como arma-
dilha de fogo são difíceis de detectar e desarmar. Um
ladino (e somente um ladino) é capaz de usar as perícias
Procurar para localizá-las e Operar Mecanismo para
desarmá-las. A CD de ambas será 25 + nível da magia
(CD 27 para armadilha de fogo de um druida ou CD
29 para a versão arcana).
Componente Material: 250 gramas de pó de ouro
(25 PO) espalhadas sobre o objeto protegido.', 1, '', '[Fogo]', '10 minutos', 'Toque', 'Alvo: Objeto tocado', 'Permanente ou até ser descarregada (D)', 'Reflexos para reduzir à', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='A armadilha de fogo gera uma explosão de fogo
quando um invasor abre o item protegido. Ela é capaz
de proteger qualquer objeto que tenha um mecanismo
de abertura (livros, caixas, garrafas, cestas, caixões,
portas, gavetas, etc.).
Ao conjurar a magia, o personagem escolhe um
ponto no item como seu centro. Quando alguém abrir
indevidamente o item, uma explosão de fogo preenche
uma área de 1,5 m de raio em torno do centro da magia.
As chamas causam 1d4 pontos de dano +1 por nível
de conjurador (máximo +20). O item protegido pela
armadilha não é afetado pela explosão.
Nenhuma outra magia de proteção pode ser con-
jurada sobre o mesmo item.
Uma magia arrombar anula armadilha de fogo.
Dissipar magia que não obtenha sucesso não dispara
a armadilha.
Sob a água, essa magia causa metade do dano e cria
uma grande nuvem de vapor.
O conjurador, assim como qualquer outra pessoa
vinculada ao objeto, consegue usá-lo normalmente.
Vincular um objeto sob efeito da magia à uma pessoa
geralmente envolve uma palavra secreta que o persona-
gem pode compartilhar com seus amigos.
Observação: As armadilhas mágicas como arma-
dilha de fogo são difíceis de detectar e desarmar. Um
ladino (e somente um ladino) é capaz de usar as perícias
Procurar para localizá-las e Operar Mecanismo para
desarmá-las. A CD de ambas será 25 + nível da magia
(CD 27 para armadilha de fogo de um druida ou CD
29 para a versão arcana).
Componente Material: 250 gramas de pó de ouro
(25 PO) espalhadas sobre o objeto protegido.', 
    school_id=1, 
    subschool='', 
    descriptors='[Fogo]', 
    casting_time='10 minutos',
    range_text='Toque',
    area_target_effect_text='Alvo: Objeto tocado',
    duration='Permanente ou até ser descarregada (D)',
    saving_throw='Reflexos para reduzir à',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Armadilha de Fogo');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Armadilha de Fogo'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Armadilha de Fogo'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Armadilha de Fogo'), 3, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Armadilha de Fogo'), 2);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Armadilha de Fogo'), 4);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Armadilha de Fogo'), 4);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Armadilha de Leomund', 'Essa magia faz uma tranca ou outro pequeno
mecanismo parecer uma armadilha a qualquer criatura
capaz de detectar armadilhas. A magia é conjurada
sobre qualquer dispositivo ou mecanismo de abertura,
como uma fechadura, dobradiça, ferrolho, tampa de
rolha, tampa de rosca ou tramela. Um personagem que
tentar detectar a armadilha, ou usar qualquer magia ou
instrumento para detecção, terá certeza absoluta que há
uma armadilha genuína no mecanismo. Obviamente,
essa magia é ilusória e nada acontece se o mecanismo
for aberto. O propósito principal dessa ilusão é assustar
ladrões ou obrigá-los a perder minutos preciosos ten-
tando remover a armadilha.
Se outra armadilha de Leomund estiver ativa a
menos de 15 metros de distancia, uma nova conjuração
fracassa automaticamente.
Componentes Materiais: Um pedaço de pirita
encostada no local a ser encantando, enquanto um
pó especial, que custa 50 PO para ser preparado, é
jogado sobre ele.', 6, 'Sensação', '', '1 ação padrão', 'Toque', 'Alvo: Objeto tocado', 'Permanente (D)', 'Nenhum', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='Essa magia faz uma tranca ou outro pequeno
mecanismo parecer uma armadilha a qualquer criatura
capaz de detectar armadilhas. A magia é conjurada
sobre qualquer dispositivo ou mecanismo de abertura,
como uma fechadura, dobradiça, ferrolho, tampa de
rolha, tampa de rosca ou tramela. Um personagem que
tentar detectar a armadilha, ou usar qualquer magia ou
instrumento para detecção, terá certeza absoluta que há
uma armadilha genuína no mecanismo. Obviamente,
essa magia é ilusória e nada acontece se o mecanismo
for aberto. O propósito principal dessa ilusão é assustar
ladrões ou obrigá-los a perder minutos preciosos ten-
tando remover a armadilha.
Se outra armadilha de Leomund estiver ativa a
menos de 15 metros de distancia, uma nova conjuração
fracassa automaticamente.
Componentes Materiais: Um pedaço de pirita
encostada no local a ser encantando, enquanto um
pó especial, que custa 50 PO para ser preparado, é
jogado sobre ele.', 
    school_id=6, 
    subschool='Sensação', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Toque',
    area_target_effect_text='Alvo: Objeto tocado',
    duration='Permanente (D)',
    saving_throw='Nenhum',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Armadilha de Leomund');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Armadilha de Leomund'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Armadilha de Leomund'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Armadilha de Leomund'), 3, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Armadilha de Leomund'), 2);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Armadilha de Leomund'), 2);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Armadura Arcana', 'Um campo de força invisível, mas tangível, envolve
o alvo da armadura arcana, concedendo +4 de bônus de
armadura na CA. Diferente das armaduras normais, a
armadura arcana não possui nenhuma penalidade de
armadura, chance de falha de magia arcana ou redução
do deslocamento. Como a armadura arcana é composta
de energia, as criaturas incorpóreas não podem atraves-
sá-la como fazem com as armaduras normais.
Foco: Um pedaço de couro endurecido.', 2, 'Criação', '[Energia]', '1 ação padrão', 'Toque', 'Alvo: Criatura tocada', '1 hora/nível (D)', 'Vontade anula (inofensiva)', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='Um campo de força invisível, mas tangível, envolve
o alvo da armadura arcana, concedendo +4 de bônus de
armadura na CA. Diferente das armaduras normais, a
armadura arcana não possui nenhuma penalidade de
armadura, chance de falha de magia arcana ou redução
do deslocamento. Como a armadura arcana é composta
de energia, as criaturas incorpóreas não podem atraves-
sá-la como fazem com as armaduras normais.
Foco: Um pedaço de couro endurecido.', 
    school_id=2, 
    subschool='Criação', 
    descriptors='[Energia]', 
    casting_time='1 ação padrão',
    range_text='Toque',
    area_target_effect_text='Alvo: Criatura tocada',
    duration='1 hora/nível (D)',
    saving_throw='Vontade anula (inofensiva)',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Armadura Arcana');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Armadura Arcana'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Armadura Arcana'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Armadura Arcana'), 4, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Armadura Arcana'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Armadura Arcana'), 1);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Arrombar', 'A magia arrombar abre portas emperradas, barra-
das, trancadas, imobilizadas ou protegidas com uma
tranca arcana. Ela abre portas secretas, assim como arcas
e baús trancados ou que tenham mecanismos complica-
dos. Ela também enfraquece soldas, algemas e correntes
(desde que sirvam para permanecer fechadas). Se usada
para abrir uma porta com tranca arcana, a magia não
remove a tranca arcana, mas simplesmente suspende
seu funcionamento durante 10 minutos. Em todos os
outros casos, a porta não se tranca ou fica emperrada
novamente. Arrombar não ergue portões fechados ou
obstáculos similares (como uma ponte levadiça) e não
afeta cordas, cipós, etc. O efeito é limitado pela área.
Um conjurador de 3º nível é capaz de lançar a magia
arrombar em uma porta de 9 m ou menor (por exem-
plo, uma porta padrão de 1,20 m por 2,10 m). Cada
magia pode remover dois dispositivos de uma abertura
ou porta. Logo, se uma porta estiver trancada, barrada
e imobilizada ou trancada quatro vezes, abri-la exigiria
duas magias arrombar.', 8, '', '', '1 ação padrão', 'Médio (30 metros + 3 metros/nível)', 'Alvo: Uma porta, caixa ou baú com uma área', 'Instantânea; veja texto', 'Nenhum', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='A magia arrombar abre portas emperradas, barra-
das, trancadas, imobilizadas ou protegidas com uma
tranca arcana. Ela abre portas secretas, assim como arcas
e baús trancados ou que tenham mecanismos complica-
dos. Ela também enfraquece soldas, algemas e correntes
(desde que sirvam para permanecer fechadas). Se usada
para abrir uma porta com tranca arcana, a magia não
remove a tranca arcana, mas simplesmente suspende
seu funcionamento durante 10 minutos. Em todos os
outros casos, a porta não se tranca ou fica emperrada
novamente. Arrombar não ergue portões fechados ou
obstáculos similares (como uma ponte levadiça) e não
afeta cordas, cipós, etc. O efeito é limitado pela área.
Um conjurador de 3º nível é capaz de lançar a magia
arrombar em uma porta de 9 m ou menor (por exem-
plo, uma porta padrão de 1,20 m por 2,10 m). Cada
magia pode remover dois dispositivos de uma abertura
ou porta. Logo, se uma porta estiver trancada, barrada
e imobilizada ou trancada quatro vezes, abri-la exigiria
duas magias arrombar.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Médio (30 metros + 3 metros/nível)',
    area_target_effect_text='Alvo: Uma porta, caixa ou baú com uma área',
    duration='Instantânea; veja texto',
    saving_throw='Nenhum',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Arrombar');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Arrombar'), 1, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Arrombar'), 2);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Arrombar'), 2);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Assassino Fantasmagórico', '', 6, 'Fantasma', '[Medo, de Ação Mental]', '1 ação padrão', 'Médio (30 metros + 3 metros/nível)', 'Alvo: Uma criatura viva', 'Instantânea', 'Vontade desacredita (se', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=6, 
    subschool='Fantasma', 
    descriptors='[Medo, de Ação Mental]', 
    casting_time='1 ação padrão',
    range_text='Médio (30 metros + 3 metros/nível)',
    area_target_effect_text='Alvo: Uma criatura viva',
    duration='Instantânea',
    saving_throw='Vontade desacredita (se',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Assassino Fantasmagórico');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Assassino Fantasmagórico'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Assassino Fantasmagórico'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Assassino Fantasmagórico'), 4);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Assassino Fantasmagórico'), 4);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Astúcia da Raposa', 'A criatura transmutada se torna mais esperta. A
magia concede +4 de bônus de aprimoramento de In-
teligência, concedendo os benefícios normais às perícias
baseadas em Inteligência e às demais características que
utilizam esse modificador. Os magos (e outros conju-
radores que dependem da Inteligência) afetados por
essa magia não adquirem magias adicionais devido ao
aumento da Inteligência, mas as CDs das magias que
eles conjuram enquanto estiverem sob esse efeito são
elevadas. Essa magia não concede pontos de perícias
adicionais.
Componente Material Arcano: Um pouco de pêlo
ou estrume de uma raposa.', 8, '', '', '1 ação padrão', 'Toque', 'Alvo: Criatura tocada', '1 minuto/nível', 'Vontade anula (inofensiva)', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='A criatura transmutada se torna mais esperta. A
magia concede +4 de bônus de aprimoramento de In-
teligência, concedendo os benefícios normais às perícias
baseadas em Inteligência e às demais características que
utilizam esse modificador. Os magos (e outros conju-
radores que dependem da Inteligência) afetados por
essa magia não adquirem magias adicionais devido ao
aumento da Inteligência, mas as CDs das magias que
eles conjuram enquanto estiverem sob esse efeito são
elevadas. Essa magia não concede pontos de perícias
adicionais.
Componente Material Arcano: Um pouco de pêlo
ou estrume de uma raposa.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Toque',
    area_target_effect_text='Alvo: Criatura tocada',
    duration='1 minuto/nível',
    saving_throw='Vontade anula (inofensiva)',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Astúcia da Raposa');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Astúcia da Raposa'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Astúcia da Raposa'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Astúcia da Raposa'), 3, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Astúcia da Raposa'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Astúcia da Raposa'), 2);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Astúcia da Raposa'), 2);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Astúcia da Raposa'), 2);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Astúcia da Raposa em Massa', '', 8, '', '', '', 'Curto (7,5 m + 1,5 m/2 níveis)', 'Alvo: Uma criatura/nível, todas a menos de 9', '', '', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='',
    range_text='Curto (7,5 m + 1,5 m/2 níveis)',
    area_target_effect_text='Alvo: Uma criatura/nível, todas a menos de 9',
    duration='',
    saving_throw='',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Astúcia da Raposa em Massa');
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Astúcia da Raposa em Massa'), 6);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Astúcia da Raposa em Massa'), 6);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Astúcia da Raposa em Massa'), 6);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Ataque Certeiro', '', 3, '', '', '1 ação padrão', 'Pessoal', 'Alvo: Você', 'Veja texto', '', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=3, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Pessoal',
    area_target_effect_text='Alvo: Você',
    duration='Veja texto',
    saving_throw='',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Ataque Certeiro');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Ataque Certeiro'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Ataque Certeiro'), 4, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Ataque Certeiro'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Ataque Certeiro'), 1);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Ataque Visual', 'É possível afetar somente uma criatura viva por
rodada. Ela será alvo de um ataque visual. Dependendo
da quantidade de DV do alvo, este ataque pode gerar
3 efeitos diferentes:
DV
10 ou mais
5-9
4 ou menos
Efeito
Enjoada
Apavorada, enjoada
Letárgica, apavorada e enjoada.
Estes efeitos são cumulativos e
concorrentes.
Enjoada: Dores e febre repentina acometem o
corpo do alvo. Ele sofre -2 de penalidade nas jogadas
de ataque, dano, testes de resistência, perícia e habili-
dade. Uma criatura afetada por esta magia permanece
enjoada durante 10 minutos por nível de conjurador.
Este efeito não pode ser anulado por remover doenças ou
cura completa, mas remover maldição é eficaz.
Apavorada: A vítima fica apavorada durante 1d4
rodadas. Após o término desse efeito, ela permanecerá
abalada durante 10 minutos por nível de conjurador
e ficará apavorada novamente caso veja o conjurador
durante esse período. Este é um efeito de medo.
Letárgica: O alvo cai num estado de coma catatôni-
co durante 10 minutos por nível de conjurador. Duran-
te esse período, ela não pode ser acordada por qualquer
método, exceto efeitos de dissipar magia. Este não é um
efeito de sono e, portanto, os elfos são afetados.
Esta magia dura 1 rodada para cada 3 níveis de
conjurador. É preciso usar uma ação de movimento por
rodada depois da primeira para afetar outro alvo.', 7, '', '[Mal]', '1 ação padrão', 'Curto (7,5 m + 1,5 m/2 níveis)', 'Alvo: 1 criatura viva', '1 rodada/três níveis (veja texto)', 'Fortitude anula', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='É possível afetar somente uma criatura viva por
rodada. Ela será alvo de um ataque visual. Dependendo
da quantidade de DV do alvo, este ataque pode gerar
3 efeitos diferentes:
DV
10 ou mais
5-9
4 ou menos
Efeito
Enjoada
Apavorada, enjoada
Letárgica, apavorada e enjoada.
Estes efeitos são cumulativos e
concorrentes.
Enjoada: Dores e febre repentina acometem o
corpo do alvo. Ele sofre -2 de penalidade nas jogadas
de ataque, dano, testes de resistência, perícia e habili-
dade. Uma criatura afetada por esta magia permanece
enjoada durante 10 minutos por nível de conjurador.
Este efeito não pode ser anulado por remover doenças ou
cura completa, mas remover maldição é eficaz.
Apavorada: A vítima fica apavorada durante 1d4
rodadas. Após o término desse efeito, ela permanecerá
abalada durante 10 minutos por nível de conjurador
e ficará apavorada novamente caso veja o conjurador
durante esse período. Este é um efeito de medo.
Letárgica: O alvo cai num estado de coma catatôni-
co durante 10 minutos por nível de conjurador. Duran-
te esse período, ela não pode ser acordada por qualquer
método, exceto efeitos de dissipar magia. Este não é um
efeito de sono e, portanto, os elfos são afetados.
Esta magia dura 1 rodada para cada 3 níveis de
conjurador. É preciso usar uma ação de movimento por
rodada depois da primeira para afetar outro alvo.', 
    school_id=7, 
    subschool='', 
    descriptors='[Mal]', 
    casting_time='1 ação padrão',
    range_text='Curto (7,5 m + 1,5 m/2 níveis)',
    area_target_effect_text='Alvo: 1 criatura viva',
    duration='1 rodada/três níveis (veja texto)',
    saving_throw='Fortitude anula',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Ataque Visual');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Ataque Visual'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Ataque Visual'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Ataque Visual'), 6);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Ataque Visual'), 6);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Ataque Visual'), 6);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Aterrorizar', 'Essa magia funciona como causar medo, mas afeta
todas as criaturas com menos de 6 DV.
Componente Material: Um pedaço de osso de
um morto-vivo (esqueleto, zumbi, carniçal, lívido ou
múmia).', 7, '', '[Medo, de Ação Mental]', '1 ação padrão', 'Médio (30 metros + 3 metros/nível)', 'Alvo: Uma criatura/3 níveis de conjurador,', '1 rodada/nível ou 1 rodada, veja o', 'Vontade parcial', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Essa magia funciona como causar medo, mas afeta
todas as criaturas com menos de 6 DV.
Componente Material: Um pedaço de osso de
um morto-vivo (esqueleto, zumbi, carniçal, lívido ou
múmia).', 
    school_id=7, 
    subschool='', 
    descriptors='[Medo, de Ação Mental]', 
    casting_time='1 ação padrão',
    range_text='Médio (30 metros + 3 metros/nível)',
    area_target_effect_text='Alvo: Uma criatura/3 níveis de conjurador,',
    duration='1 rodada/nível ou 1 rodada, veja o',
    saving_throw='Vontade parcial',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Aterrorizar');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aterrorizar'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aterrorizar'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aterrorizar'), 3, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Aterrorizar'), 2);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Aterrorizar'), 2);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Aterrorizar'), 2);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Augúrio', '', 3, '', '', '1 minuto', 'Pessoal', 'Alvo: Você', 'Instantânea', '', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=3, 
    subschool='', 
    descriptors='', 
    casting_time='1 minuto',
    range_text='Pessoal',
    area_target_effect_text='Alvo: Você',
    duration='Instantânea',
    saving_throw='',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Augúrio');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Augúrio'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Augúrio'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Augúrio'), 3, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Augúrio'), 4, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Augúrio'), 2);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Aumentar Pessoa', 'Esta magia aumenta instantaneamente uma cria-
tura, dobrando sua altura e multiplicando seu peso por
8. Este aumento aumenta em uma categoria o tamanho
da criatura. Ela recebe +2 de bônus de tamanho na
Força, -2 de penalidade na Destreza (mínimo de 1) e
-1 de penalidade nas jogadas de ataque e CA devido
ao tamanho.
Um humanóide Grande ocupa um espaço de 3 m
e tem alcance natural de 3 m. Esta magia não altera o
deslocamento do alvo.
Caso não haja espaço para que a criatura dobre de
tamanho, ela atingira o crescimento máximo permitido
e poderá realizar um teste de Força (com seu valor de
Força recém alterado pela magia) para remover quais-
quer barreiras que estejam impedindo seu crescimento.
Caso fracasse neste teste, ela encolhe sem sofrer dano
por esmagamento – esta magia não pode ser usada para
esmagar uma criatura aumentando seu tamanho.
Todo equipamento usado ou carregado pela cria-
tura também é afetado de maneira similar pela magia.
As armas brancas e de disparo afetadas pela magia
causam mais dano (Tabela 2-2 no Livro do Mestre).
Outras propriedades mágicas não são afetadas por esta
magia. Qualquer item aumentado que seja largado pelo
alvo retorna ao seu tamanho normal (incluindo armas
de disparo e arremesso). Isso significa que as armas
de arremesso causarão dano normalmente (como se
tivessem seu tamanho original), mas os projéteis causam
dano conforme a arma que os disparou. As propriedades
mágicas dos itens aumentados não são afetadas por esta
magia – uma espada +1 aumentada ainda será apenas
+1, uma varinha do tamanho de um bastão ainda será
considerada uma varinha, uma poção tamanho gigante
precisa ser consumida em quantidade maior para surtir
o mesmo efeito, e assim por diante.
Os diversos efeitos mágicos que aumentam o ta-
manho não se acumulam, o que significa, entre outras
coisas, que é impossível usar uma segunda conjuração
desta magia sobre uma criatura já aumentada para
quadruplicar seu tamanho original.
Aumentar pessoa serve de contramágica e dissipa
reduzir pessoa.
Esta magia pode se tornar permanentes através da
magia permanência.
Componente Matinal: Um punhado de pó de
ferro.', 8, '', '', '1 rodada', 'Curto (7,5 m + 1,5 m/2 níveis)', 'Alvo: 1 humanóide', '1 min,/nível (D)', 'Fortitude anula', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Esta magia aumenta instantaneamente uma cria-
tura, dobrando sua altura e multiplicando seu peso por
8. Este aumento aumenta em uma categoria o tamanho
da criatura. Ela recebe +2 de bônus de tamanho na
Força, -2 de penalidade na Destreza (mínimo de 1) e
-1 de penalidade nas jogadas de ataque e CA devido
ao tamanho.
Um humanóide Grande ocupa um espaço de 3 m
e tem alcance natural de 3 m. Esta magia não altera o
deslocamento do alvo.
Caso não haja espaço para que a criatura dobre de
tamanho, ela atingira o crescimento máximo permitido
e poderá realizar um teste de Força (com seu valor de
Força recém alterado pela magia) para remover quais-
quer barreiras que estejam impedindo seu crescimento.
Caso fracasse neste teste, ela encolhe sem sofrer dano
por esmagamento – esta magia não pode ser usada para
esmagar uma criatura aumentando seu tamanho.
Todo equipamento usado ou carregado pela cria-
tura também é afetado de maneira similar pela magia.
As armas brancas e de disparo afetadas pela magia
causam mais dano (Tabela 2-2 no Livro do Mestre).
Outras propriedades mágicas não são afetadas por esta
magia. Qualquer item aumentado que seja largado pelo
alvo retorna ao seu tamanho normal (incluindo armas
de disparo e arremesso). Isso significa que as armas
de arremesso causarão dano normalmente (como se
tivessem seu tamanho original), mas os projéteis causam
dano conforme a arma que os disparou. As propriedades
mágicas dos itens aumentados não são afetadas por esta
magia – uma espada +1 aumentada ainda será apenas
+1, uma varinha do tamanho de um bastão ainda será
considerada uma varinha, uma poção tamanho gigante
precisa ser consumida em quantidade maior para surtir
o mesmo efeito, e assim por diante.
Os diversos efeitos mágicos que aumentam o ta-
manho não se acumulam, o que significa, entre outras
coisas, que é impossível usar uma segunda conjuração
desta magia sobre uma criatura já aumentada para
quadruplicar seu tamanho original.
Aumentar pessoa serve de contramágica e dissipa
reduzir pessoa.
Esta magia pode se tornar permanentes através da
magia permanência.
Componente Matinal: Um punhado de pó de
ferro.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='1 rodada',
    range_text='Curto (7,5 m + 1,5 m/2 níveis)',
    area_target_effect_text='Alvo: 1 humanóide',
    duration='1 min,/nível (D)',
    saving_throw='Fortitude anula',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Aumentar Pessoa');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aumentar Pessoa'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aumentar Pessoa'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aumentar Pessoa'), 3, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Aumentar Pessoa'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Aumentar Pessoa'), 1);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Aumentar Pessoa'), 1);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Aumentar Pessoa em Massa', '', 8, '', '', '', '', 'Alvo: 1 humanóide/nível, todos a menos de 9', '', '', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='',
    range_text='',
    area_target_effect_text='Alvo: 1 humanóide/nível, todos a menos de 9',
    duration='',
    saving_throw='',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Aumentar Pessoa em Massa');
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Aumentar Pessoa em Massa'), 4);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Aumentar Pessoa em Massa'), 4);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Aura Mágica de Nystul', '', 6, 'Sensação', '', '1 ação padrão', 'Toque', 'Alvo: Um objeto tocado pesando até 2,5 kg/nível', 'Um dia/nível (D)', 'Nenhum; veja texto', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=6, 
    subschool='Sensação', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Toque',
    area_target_effect_text='Alvo: Um objeto tocado pesando até 2,5 kg/nível',
    duration='Um dia/nível (D)',
    saving_throw='Nenhum; veja texto',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Aura Mágica de Nystul');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aura Mágica de Nystul'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aura Mágica de Nystul'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aura Mágica de Nystul'), 4, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Aura Mágica de Nystul'), 1);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (13, (SELECT id FROM spells WHERE name='Aura Mágica de Nystul'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Aura Mágica de Nystul'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Aura Mágica de Nystul'), 1);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Aura Profana', 'Uma escuridão malévola envolve os alvos, prote-
gendo-os de ataques, fornecendo lhe resistência às ma-
gias conjuradas por criaturas bondosas e enfraquecendo
as criaturas bondosas que os atacarem. Essa abjuração
gera quatro efeitos:
Primeiro, cada criatura protegida recebe +4 de
bônus de deflexão na CA e +4 de bônus de resistência
para os testes de resistência. Diferente de proteção contra
o bem, esse benefício se aplica a todos os ataques e não
apenas aos golpes desferidos por criaturas Boas.
Segundo, a criatura protegida adquire Resistência
à Magia 25 contra as magias com o descritor [Bem] ou
conjuradas por criaturas Boas.
Terceiro, a abjuração bloqueia a possessão e influ-
ências mentais, da mesma forma que proteção contra
o bem.
Finalmente, caso uma criatura bondosa atinja uma
criatura protegida em combate corpo a corpo, o atacan-
te sofrerá 1d6 pontos de dano temporário de Força (um
teste de resistência de Fortitude anula o efeito).
Foco: Um pequeno relicário contendo alguma
relíquia sagrada, como um pedaço de um pergaminho
com textos profanos. O relicário custa no mínimo
500 PO.', 1, '', '[Mal]', '1 ação padrão', '6 metros', 'Alvo: Uma criatura/nível em uma explosão de 6', '1 rodada/nível (D)', 'Veja texto', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Uma escuridão malévola envolve os alvos, prote-
gendo-os de ataques, fornecendo lhe resistência às ma-
gias conjuradas por criaturas bondosas e enfraquecendo
as criaturas bondosas que os atacarem. Essa abjuração
gera quatro efeitos:
Primeiro, cada criatura protegida recebe +4 de
bônus de deflexão na CA e +4 de bônus de resistência
para os testes de resistência. Diferente de proteção contra
o bem, esse benefício se aplica a todos os ataques e não
apenas aos golpes desferidos por criaturas Boas.
Segundo, a criatura protegida adquire Resistência
à Magia 25 contra as magias com o descritor [Bem] ou
conjuradas por criaturas Boas.
Terceiro, a abjuração bloqueia a possessão e influ-
ências mentais, da mesma forma que proteção contra
o bem.
Finalmente, caso uma criatura bondosa atinja uma
criatura protegida em combate corpo a corpo, o atacan-
te sofrerá 1d6 pontos de dano temporário de Força (um
teste de resistência de Fortitude anula o efeito).
Foco: Um pequeno relicário contendo alguma
relíquia sagrada, como um pedaço de um pergaminho
com textos profanos. O relicário custa no mínimo
500 PO.', 
    school_id=1, 
    subschool='', 
    descriptors='[Mal]', 
    casting_time='1 ação padrão',
    range_text='6 metros',
    area_target_effect_text='Alvo: Uma criatura/nível em uma explosão de 6',
    duration='1 rodada/nível (D)',
    saving_throw='Veja texto',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Aura Profana');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aura Profana'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aura Profana'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aura Profana'), 4, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Aura Profana'), 8);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (14, (SELECT id FROM spells WHERE name='Aura Profana'), 8);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Aura Sagrada', 'Uma aura brilhante de energia divina envolve o
alvo, protegendo-o de ataques, concedendo-lhe re-
sistência às magias conjuradas por criaturas malignas
e cegando as criaturas malignas que o atacarem. Essa
abjuração gera quatro efeitos.
Primeiro, cada criatura protegida recebe +4 de
bônus de deflexão na CA e +4 de bônus de resistência
para os testes de resistência. Diferente de proteção contra
o mal, esse benefício se aplica a todos os ataques e não
apenas aos golpes desferidos por criaturas Más.
Segundo, cada criatura protegida recebe Resistên-
cia à Magia 25 contra magias com o descritor [Mal] ou
conjuradas por criaturas Más.
Terceiro, a abjuração bloqueia a possessão e influ-
ências mentais, da mesma forma que proteção contra
o mal.
Finalmente, caso a criatura maligna atinja uma
criatura protegida em combate corpo a corpo, o ata-
cante ficará cego (um teste de resistência de Fortitude
anula o efeito, como cegueira/surdez, mas contra a CD
da aura sagrada).
Foco: Um pequeno relicário contendo alguma relí-
quia sagrada, como um pedaço do manto de um santo
ou um pergaminho com textos sagrados. O relicário
custa no mínimo 500 PO.', 1, '', '[Bem]', '1 ação padrão', '', 'Alvo: Uma criatura/nível dentro de uma explo-', '1 rodada/nível (D)', 'Veja texto', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Uma aura brilhante de energia divina envolve o
alvo, protegendo-o de ataques, concedendo-lhe re-
sistência às magias conjuradas por criaturas malignas
e cegando as criaturas malignas que o atacarem. Essa
abjuração gera quatro efeitos.
Primeiro, cada criatura protegida recebe +4 de
bônus de deflexão na CA e +4 de bônus de resistência
para os testes de resistência. Diferente de proteção contra
o mal, esse benefício se aplica a todos os ataques e não
apenas aos golpes desferidos por criaturas Más.
Segundo, cada criatura protegida recebe Resistên-
cia à Magia 25 contra magias com o descritor [Mal] ou
conjuradas por criaturas Más.
Terceiro, a abjuração bloqueia a possessão e influ-
ências mentais, da mesma forma que proteção contra
o mal.
Finalmente, caso a criatura maligna atinja uma
criatura protegida em combate corpo a corpo, o ata-
cante ficará cego (um teste de resistência de Fortitude
anula o efeito, como cegueira/surdez, mas contra a CD
da aura sagrada).
Foco: Um pequeno relicário contendo alguma relí-
quia sagrada, como um pedaço do manto de um santo
ou um pergaminho com textos sagrados. O relicário
custa no mínimo 500 PO.', 
    school_id=1, 
    subschool='', 
    descriptors='[Bem]', 
    casting_time='1 ação padrão',
    range_text='',
    area_target_effect_text='Alvo: Uma criatura/nível dentro de uma explo-',
    duration='1 rodada/nível (D)',
    saving_throw='Veja texto',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Aura Sagrada');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aura Sagrada'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aura Sagrada'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Aura Sagrada'), 4, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Aura Sagrada'), 8);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Aura Sagrada'), 8);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Auxílio Divino', '', 5, '', '', '1 ação padrão', 'Pessoal', 'Alvo: Você', '1 minuto', '', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=5, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Pessoal',
    area_target_effect_text='Alvo: Você',
    duration='1 minuto',
    saving_throw='',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Auxílio Divino');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Auxílio Divino'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Auxílio Divino'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Auxílio Divino'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Auxílio Divino'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (7, (SELECT id FROM spells WHERE name='Auxílio Divino'), 1);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Banimento', 'A magia banimento é uma versão mais poderosa
da magia expulsão. Ela permite expulsar até 2 DV de
criaturas de outros planos por nível de conjurador
para seu plano natal Para afetar uma criatura, é preciso
empunhar uma substância ou objeto que ela odeie,
tema ou que se oponha a ela de alguma forma. Para
cada objeto ou substancia, o conjurador recebe +1 de
bônus no teste de conjurador para superar a RM do
alvo (se houver) e +2 na CD do teste de resistência. Por
exemplo, se a magia fosse conjurada sobre um demônio
que odiasse a luz e fosse vulnerável à água benta e a
armas de ferro frio, o conjurador poderia usar ferro,
água benta e uma tocha. Os três itens adicionariam +3
ao teste para superar a RM do demônio e somariam
+6 à CD da magia.
Se o Mestre desejar, alguns itens raros podem
funcionar com o dobro de força (cada um fornecendo
+2 contra a RM e +4 para a CD).
Foco Arcano: Qualquer item que o alvo não goste
(opcional, veja acima)', 1, '', '', '1 ação padrão', 'Curto (7,5 m + 1,5 m/2 níveis)', 'Alvo: Uma ou mais criaturas extra-planares,', 'Instantânea', 'Vontade anula', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='A magia banimento é uma versão mais poderosa
da magia expulsão. Ela permite expulsar até 2 DV de
criaturas de outros planos por nível de conjurador
para seu plano natal Para afetar uma criatura, é preciso
empunhar uma substância ou objeto que ela odeie,
tema ou que se oponha a ela de alguma forma. Para
cada objeto ou substancia, o conjurador recebe +1 de
bônus no teste de conjurador para superar a RM do
alvo (se houver) e +2 na CD do teste de resistência. Por
exemplo, se a magia fosse conjurada sobre um demônio
que odiasse a luz e fosse vulnerável à água benta e a
armas de ferro frio, o conjurador poderia usar ferro,
água benta e uma tocha. Os três itens adicionariam +3
ao teste para superar a RM do demônio e somariam
+6 à CD da magia.
Se o Mestre desejar, alguns itens raros podem
funcionar com o dobro de força (cada um fornecendo
+2 contra a RM e +4 para a CD).
Foco Arcano: Qualquer item que o alvo não goste
(opcional, veja acima)', 
    school_id=1, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Curto (7,5 m + 1,5 m/2 níveis)',
    area_target_effect_text='Alvo: Uma ou mais criaturas extra-planares,',
    duration='Instantânea',
    saving_throw='Vontade anula',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Banimento');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Banimento'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Banimento'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Banimento'), 4, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Banimento'), 6);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Banimento'), 7);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Banimento'), 7);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Banquete de Heróis', 'O personagem cria um enorme banquete, incluin-
do uma mesa magnífica, cadeiras, pratos, talheres,
comida e bebida. O banquete exige 1 hora para ser
consumido e seus efeitos benéficos não aparecem
antes desse período. Cada criatura que participou
do banquete é curada de qualquer doença, enjôo e
náusea; tornam-se imunes aos veneno durante 12 horas
e recebem 1d8 pontos de vida temporários +1 ponto a
cada 2 níveis de conjurador (máximo +10) depois de
ingerir uma bebida similar a um néctar que faz parte do
banquete. A comida deliciosa que é consumida fornece
a cada participante do banquete +1 de bônus de moral
nas jogadas de ataque e testes de resistência de Vontade;
essas criaturas se tornam imunes aos efeitos de medo
durante 12 horas.
Se o banquete for interrompido por alguma
razão, a magia é dissipada e todos os seus efeitos são
anulados.', 2, 'criação', '', '10 minutos', 'Curto (7,5 m + 1,5 m/2 níveis)', 'Alvo: Banquete para uma criatura/nível', '1 hora mais 12 horas; veja texto', 'Nenhum', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='O personagem cria um enorme banquete, incluin-
do uma mesa magnífica, cadeiras, pratos, talheres,
comida e bebida. O banquete exige 1 hora para ser
consumido e seus efeitos benéficos não aparecem
antes desse período. Cada criatura que participou
do banquete é curada de qualquer doença, enjôo e
náusea; tornam-se imunes aos veneno durante 12 horas
e recebem 1d8 pontos de vida temporários +1 ponto a
cada 2 níveis de conjurador (máximo +10) depois de
ingerir uma bebida similar a um néctar que faz parte do
banquete. A comida deliciosa que é consumida fornece
a cada participante do banquete +1 de bônus de moral
nas jogadas de ataque e testes de resistência de Vontade;
essas criaturas se tornam imunes aos efeitos de medo
durante 12 horas.
Se o banquete for interrompido por alguma
razão, a magia é dissipada e todos os seus efeitos são
anulados.', 
    school_id=2, 
    subschool='criação', 
    descriptors='', 
    casting_time='10 minutos',
    range_text='Curto (7,5 m + 1,5 m/2 níveis)',
    area_target_effect_text='Alvo: Banquete para uma criatura/nível',
    duration='1 hora mais 12 horas; veja texto',
    saving_throw='Nenhum',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Banquete de Heróis');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Banquete de Heróis'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Banquete de Heróis'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Banquete de Heróis'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Banquete de Heróis'), 6);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Banquete de Heróis'), 6);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Barreira de Lâminas', 'Esta magia cria uma parede imóvel e vertical de
lâminas afiadas. Qualquer criatura que tentar ultrapas-
sar a barreira de lâminas sofre 1d6 pontos de dano por
nível de conjurador (máximo 15d6), mas um teste de
Reflexos reduz o dano à metade.
As criaturas que estiverem dentro da área da
barreira quando ela for conjurada também sofrem o
dano, como se estivessem tentando atravessá-la. Essas
criaturas podem evitar a barreira (terminando dentro
ou fora dela, à critério do personagem) sem sofrer
qualquer dano se obtiverem sucesso em um teste de
resistência de Reflexos.
A barreira fornece cobertura (+4 de bônus na CA,
+2 de bônus nos testes de resistência de Reflexos) contra
quaisquer ataques desferidos através dela.', 5, '', '[Energia]', '1 ação padrão', 'Médio (30 m + 3 m/nível)', 'Efeito: Uma barreira de lâminas giratórias com', '1 min/nível (D)', 'Reflexos para reduzir à', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Esta magia cria uma parede imóvel e vertical de
lâminas afiadas. Qualquer criatura que tentar ultrapas-
sar a barreira de lâminas sofre 1d6 pontos de dano por
nível de conjurador (máximo 15d6), mas um teste de
Reflexos reduz o dano à metade.
As criaturas que estiverem dentro da área da
barreira quando ela for conjurada também sofrem o
dano, como se estivessem tentando atravessá-la. Essas
criaturas podem evitar a barreira (terminando dentro
ou fora dela, à critério do personagem) sem sofrer
qualquer dano se obtiverem sucesso em um teste de
resistência de Reflexos.
A barreira fornece cobertura (+4 de bônus na CA,
+2 de bônus nos testes de resistência de Reflexos) contra
quaisquer ataques desferidos através dela.', 
    school_id=5, 
    subschool='', 
    descriptors='[Energia]', 
    casting_time='1 ação padrão',
    range_text='Médio (30 m + 3 m/nível)',
    area_target_effect_text='Efeito: Uma barreira de lâminas giratórias com',
    duration='1 min/nível (D)',
    saving_throw='Reflexos para reduzir à',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Barreira de Lâminas');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Barreira de Lâminas'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Barreira de Lâminas'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Barreira de Lâminas'), 6);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Barreira de Lâminas'), 6);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (12, (SELECT id FROM spells WHERE name='Barreira de Lâminas'), 6);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Benção', 'A benção preenche os seus aliados com coragem.
Eles recebem +1 de bônus de moral em suas jogadas
de ataque e nos testes de resistência contra efeitos de
medo.
A benção serve de contramágica e dissipa maldição
menor.', 4, 'Compulsão', '[Ação Mental]', '1 ação padrão', '15 m', 'Área: Todos os aliados dentro de uma explosão', '1 minuto/nível', 'Nenhum', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='A benção preenche os seus aliados com coragem.
Eles recebem +1 de bônus de moral em suas jogadas
de ataque e nos testes de resistência contra efeitos de
medo.
A benção serve de contramágica e dissipa maldição
menor.', 
    school_id=4, 
    subschool='Compulsão', 
    descriptors='[Ação Mental]', 
    casting_time='1 ação padrão',
    range_text='15 m',
    area_target_effect_text='Área: Todos os aliados dentro de uma explosão',
    duration='1 minuto/nível',
    saving_throw='Nenhum',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Benção');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Benção'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Benção'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Benção'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Benção'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (7, (SELECT id FROM spells WHERE name='Benção'), 1);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Blasfêmia', 'Qualquer criatura que não seja maligna dentro da
área da magia blasfêmia sofre os seguintes efeitos:
DV
Igual ao nível de
conjurador
Nível de conjurador -1
Nível de conjurador -5
Efeito
Pasma
Enfraquecida, pasma
Paralisada,
enfraquecida, pasma
Nível de conjurador -10 Morta, paralisada,
enfraquecida, pasma
Os efeitos são cumulativos e concorrentes. Ne-
nhum teste de resistência é permitido contra estes
efeitos.
Pasma: A criatura não pode realizar nenhuma
ação durante 1 rodada, embora consiga se defender
normalmente.
Enfraquecida: O valor de Força da criatura é redu-
zido em 2d6 pontos durante 2d4 rodadas.
Paralisada: A criatura ficará paralisada e indefesa
durante 1d10 minutos.
Morta: As criaturas vivas morrem. Os mortos-vivos
são destruídos.
Além disso, se o personagem estiver em seu plano
natal, as criaturas extra-planares que não sejam malignas
são instantaneamente banidas de volta aos seus planos
de origem. As criaturas banidas não podem retornar
durante 24 horas. Esse efeito acontece mesmo se as cria-
turas não ouvirem a blasfêmia. Caso obtenham sucesso
num teste de resistência de Vontade (com –4 de penali-
dade) as criaturas evitam o efeito de banimento.
Criaturas cuja quantidade de dados de vida ex-
ceda o nível do conjurador não são afetadas por esta
magia.', 5, '', '[Mal, Sônica]', '1 ação padrão', '9 m', 'Área: Criaturas Boas ou Neutras numa dispersão', 'Instantânea', 'Nenhum ou Vontade', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Qualquer criatura que não seja maligna dentro da
área da magia blasfêmia sofre os seguintes efeitos:
DV
Igual ao nível de
conjurador
Nível de conjurador -1
Nível de conjurador -5
Efeito
Pasma
Enfraquecida, pasma
Paralisada,
enfraquecida, pasma
Nível de conjurador -10 Morta, paralisada,
enfraquecida, pasma
Os efeitos são cumulativos e concorrentes. Ne-
nhum teste de resistência é permitido contra estes
efeitos.
Pasma: A criatura não pode realizar nenhuma
ação durante 1 rodada, embora consiga se defender
normalmente.
Enfraquecida: O valor de Força da criatura é redu-
zido em 2d6 pontos durante 2d4 rodadas.
Paralisada: A criatura ficará paralisada e indefesa
durante 1d10 minutos.
Morta: As criaturas vivas morrem. Os mortos-vivos
são destruídos.
Além disso, se o personagem estiver em seu plano
natal, as criaturas extra-planares que não sejam malignas
são instantaneamente banidas de volta aos seus planos
de origem. As criaturas banidas não podem retornar
durante 24 horas. Esse efeito acontece mesmo se as cria-
turas não ouvirem a blasfêmia. Caso obtenham sucesso
num teste de resistência de Vontade (com –4 de penali-
dade) as criaturas evitam o efeito de banimento.
Criaturas cuja quantidade de dados de vida ex-
ceda o nível do conjurador não são afetadas por esta
magia.', 
    school_id=5, 
    subschool='', 
    descriptors='[Mal, Sônica]', 
    casting_time='1 ação padrão',
    range_text='9 m',
    area_target_effect_text='Área: Criaturas Boas ou Neutras numa dispersão',
    duration='Instantânea',
    saving_throw='Nenhum ou Vontade',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Blasfêmia');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Blasfêmia'), 1, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Blasfêmia'), 7);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (14, (SELECT id FROM spells WHERE name='Blasfêmia'), 7);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Boa Esperança', 'Essa magia infunde uma esperança poderosa em
seus alvos. Cada criatura afetada recebe +2 de bônus
de moral nos testes de resistência, jogadas de ataque e
dano e testes de habilidade e perícia.
Boa esperança serve de contra mágica e dissipa
desespero esmagador.', 4, 'Compulsão', '[de Ação Mental]', 'l ação padrão', 'Médio (30 metros + 3 metros/nível)', 'Alvo: Uma criatura viva/nível, todas a menos de', '1 minuto/nível', 'Vontade anula (inofensiva)', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Essa magia infunde uma esperança poderosa em
seus alvos. Cada criatura afetada recebe +2 de bônus
de moral nos testes de resistência, jogadas de ataque e
dano e testes de habilidade e perícia.
Boa esperança serve de contra mágica e dissipa
desespero esmagador.', 
    school_id=4, 
    subschool='Compulsão', 
    descriptors='[de Ação Mental]', 
    casting_time='l ação padrão',
    range_text='Médio (30 metros + 3 metros/nível)',
    area_target_effect_text='Alvo: Uma criatura viva/nível, todas a menos de',
    duration='1 minuto/nível',
    saving_throw='Vontade anula (inofensiva)',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Boa Esperança');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Boa Esperança'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Boa Esperança'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Boa Esperança'), 3);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Boca Encantada', 'Essa magia cria uma boca encantada no objeto
ou criatura escolhida, que aparece repentinamente e
pronuncia uma mensagem na próxima vez que um
determinado evento ocorrer. A mensagem, de até 25
palavras, precisa pertencer a qualquer idioma conhecido
pelo conjurador e deve ser possível pronunciá-la em um
intervalo de 10 minutos. A boca encantada não expressa
componentes verbais, palavras de comando ou ativa
efeitos mágicos. No entanto, se move de acordo com as
palavras articuladas; se ela for coloca em uma estátua, a
boca da estatua se move e parece estar falando. A boca
encantada pode ser colocada em uma árvore, rocha ou
qualquer outro objeto ou criatura.
A magia funciona quando as condições específicas
são compridas, conforme determinado no momento
da conjuração. Os comandos podem ser tão genéricos
ou específicos quanto o personagem desejar, embora
somente gatilhos auditivos e visuais possam ser usados.
Por exemplo: “Fale somente quando uma velha senhora
humana carregando um saco se sentar com as pernas
cruzadas aqui ao lado”. Os disfarces e ilusões podem
enganar o efeito. Uma escuridão natural não atrapalha
um gatilho visual, mas escuridão mágica e invisibilida-
de atrapalham. Um deslocamento furtivo e a magia
silêncio prejudicam os gatilhos auditivos. Os gatilhos
auditivos podem ser selecionados entre tipos genéricos
de sons (passos, metal batendo) ou para um barulho
ou palavra específica (quando uma gota cair ou alguém
dizer “Bu!”). As ações podem ser consideradas gatilhos
quando puderem ser vistas e ouvidas. Por exemplo,
“Fale quando qualquer criatura tocar a estátua” é um
comando aceitável se a criatura estiver visível. Uma boca
encantada não diferencia tendência, nível, Dado de
Vida ou classe, exceto pela indumentária externa.
O alcance máximo para um gatilho equivale a 4,5
metros por nível de conjurador, então um conjurador de
6° nível poderia comandar uma boca encantada a reagir
a um gatilho num raio de 27 metros. Independente do
alcance, ela só pode responder a gatilhos visíveis e audí-
veis e a ações na linha de visão ou distância audível.
A boca encantada pode se tornar permanente com
a magia permanência.
Componentes Materiais: Um punhado de favos de
mel e um jade de 10 PO.', 6, 'Sensação', '', '1 ação padrão', 'Curto (7,5 m + 1,5 m/2 níveis)', 'Alvo: Uma criatura ou objeto', 'Permanente até ser dissipada.', 'Vontade anula (objeto)', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Essa magia cria uma boca encantada no objeto
ou criatura escolhida, que aparece repentinamente e
pronuncia uma mensagem na próxima vez que um
determinado evento ocorrer. A mensagem, de até 25
palavras, precisa pertencer a qualquer idioma conhecido
pelo conjurador e deve ser possível pronunciá-la em um
intervalo de 10 minutos. A boca encantada não expressa
componentes verbais, palavras de comando ou ativa
efeitos mágicos. No entanto, se move de acordo com as
palavras articuladas; se ela for coloca em uma estátua, a
boca da estatua se move e parece estar falando. A boca
encantada pode ser colocada em uma árvore, rocha ou
qualquer outro objeto ou criatura.
A magia funciona quando as condições específicas
são compridas, conforme determinado no momento
da conjuração. Os comandos podem ser tão genéricos
ou específicos quanto o personagem desejar, embora
somente gatilhos auditivos e visuais possam ser usados.
Por exemplo: “Fale somente quando uma velha senhora
humana carregando um saco se sentar com as pernas
cruzadas aqui ao lado”. Os disfarces e ilusões podem
enganar o efeito. Uma escuridão natural não atrapalha
um gatilho visual, mas escuridão mágica e invisibilida-
de atrapalham. Um deslocamento furtivo e a magia
silêncio prejudicam os gatilhos auditivos. Os gatilhos
auditivos podem ser selecionados entre tipos genéricos
de sons (passos, metal batendo) ou para um barulho
ou palavra específica (quando uma gota cair ou alguém
dizer “Bu!”). As ações podem ser consideradas gatilhos
quando puderem ser vistas e ouvidas. Por exemplo,
“Fale quando qualquer criatura tocar a estátua” é um
comando aceitável se a criatura estiver visível. Uma boca
encantada não diferencia tendência, nível, Dado de
Vida ou classe, exceto pela indumentária externa.
O alcance máximo para um gatilho equivale a 4,5
metros por nível de conjurador, então um conjurador de
6° nível poderia comandar uma boca encantada a reagir
a um gatilho num raio de 27 metros. Independente do
alcance, ela só pode responder a gatilhos visíveis e audí-
veis e a ações na linha de visão ou distância audível.
A boca encantada pode se tornar permanente com
a magia permanência.
Componentes Materiais: Um punhado de favos de
mel e um jade de 10 PO.', 
    school_id=6, 
    subschool='Sensação', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Curto (7,5 m + 1,5 m/2 níveis)',
    area_target_effect_text='Alvo: Uma criatura ou objeto',
    duration='Permanente até ser dissipada.',
    saving_throw='Vontade anula (objeto)',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Boca Encantada');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Boca Encantada'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Boca Encantada'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Boca Encantada'), 3, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Boca Encantada'), 2);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Boca Encantada'), 2);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Bola de Fogo', 'A magia bola de fogo é uma explosão de fogo que
detona com um ruído grave e causa 1d6 pontos de
dano de fogo por nível de conjurador (máximo 10d6)
a qualquer criatura na área afetada. Os objetos que
não sejam carregados ou empunhados por nenhuma
criatura também sofrem o dano. A explosão gera uma
pressão desprezível.
O personagem aponta o dedo e determina o
alcance (distância e altura) onde a bola de fogo deve
explodir. Uma pedra em chamas parte do seu dedo,
e, a menos que colida com algum corpo ou barreira
sólida, detonará em uma explosão de fogo na distância
selecionada. Um impacto anterior resultará em uma
detonação antes do local escolhido. Se ele tentar enviar
a bola de fogo através de uma passagem estreita, como
uma seteira, precisa atingir o local com um ataque de
toque à distância ou a pedra colidirá com a barreira e
detonará antecipadamente.
A bola de fogo incendeia materiais combustíveis e
causa dano a objetos na área afetada. Ela pode derreter
metais com baixo ponto de fusão, como latão, chum-
bo, ouro, prata ou bronze. Se o dano causado a uma
barreira for capaz de destruir seu material, a bola de fogo
se alastrará depois da barreira, se a área permitir, caso
contrário, ela simplesmente derruba a barreira como
qualquer outro efeito capaz de fazê-lo.
Componentes Materiais: Uma pequena bola de
guano e enxofre.', 5, '', '[ Fogo]', '1 ação padrão', 'Longo (120 m + 12 m/nível)', 'Área: Dispersão de 6 metros de raio', 'Instantânea', 'Reflexos para reduzir á', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='A magia bola de fogo é uma explosão de fogo que
detona com um ruído grave e causa 1d6 pontos de
dano de fogo por nível de conjurador (máximo 10d6)
a qualquer criatura na área afetada. Os objetos que
não sejam carregados ou empunhados por nenhuma
criatura também sofrem o dano. A explosão gera uma
pressão desprezível.
O personagem aponta o dedo e determina o
alcance (distância e altura) onde a bola de fogo deve
explodir. Uma pedra em chamas parte do seu dedo,
e, a menos que colida com algum corpo ou barreira
sólida, detonará em uma explosão de fogo na distância
selecionada. Um impacto anterior resultará em uma
detonação antes do local escolhido. Se ele tentar enviar
a bola de fogo através de uma passagem estreita, como
uma seteira, precisa atingir o local com um ataque de
toque à distância ou a pedra colidirá com a barreira e
detonará antecipadamente.
A bola de fogo incendeia materiais combustíveis e
causa dano a objetos na área afetada. Ela pode derreter
metais com baixo ponto de fusão, como latão, chum-
bo, ouro, prata ou bronze. Se o dano causado a uma
barreira for capaz de destruir seu material, a bola de fogo
se alastrará depois da barreira, se a área permitir, caso
contrário, ela simplesmente derruba a barreira como
qualquer outro efeito capaz de fazê-lo.
Componentes Materiais: Uma pequena bola de
guano e enxofre.', 
    school_id=5, 
    subschool='', 
    descriptors='[ Fogo]', 
    casting_time='1 ação padrão',
    range_text='Longo (120 m + 12 m/nível)',
    area_target_effect_text='Área: Dispersão de 6 metros de raio',
    duration='Instantânea',
    saving_throw='Reflexos para reduzir á',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Bola de Fogo');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Bola de Fogo'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Bola de Fogo'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Bola de Fogo'), 3, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Bola de Fogo'), 3);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Bola de Fogo'), 3);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Bola de Fogo Controlável', '', 5, '', '[ Fogo]', '', '', '', 'Até 5 rodadas (veja texto)', '', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=5, 
    subschool='', 
    descriptors='[ Fogo]', 
    casting_time='',
    range_text='',
    area_target_effect_text='',
    duration='Até 5 rodadas (veja texto)',
    saving_throw='',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Bola de Fogo Controlável');
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Bola de Fogo Controlável'), 7);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Bola de Fogo Controlável'), 7);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Bom Fruto', 'Conjurando bom fruto sobre um punhado de frutos
recém-colhidos, o personagem transforma 2d4 deles em
itens mágicos. Ele (assim como qualquer outro druida
de 3° nível ou superior) conseguirá distinguir imedia-
tamente os frutos afetados. Cada fruto transmutado
alimenta uma criatura de tamanho Médio como se
fosse uma refeição normal. O fruto também recupera
1 ponto de dano quando é ingerido; a mesma criatura
não é capaz de recuperar mais de 8 pontos de vida em
um mesmo período de 24 horas.', 8, '', '', '1 ação padrão', 'toque', 'Alvo: 2d4 frutos frescos tocados', 'Um dia/nível', 'Nenhum', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Conjurando bom fruto sobre um punhado de frutos
recém-colhidos, o personagem transforma 2d4 deles em
itens mágicos. Ele (assim como qualquer outro druida
de 3° nível ou superior) conseguirá distinguir imedia-
tamente os frutos afetados. Cada fruto transmutado
alimenta uma criatura de tamanho Médio como se
fosse uma refeição normal. O fruto também recupera
1 ponto de dano quando é ingerido; a mesma criatura
não é capaz de recuperar mais de 8 pontos de vida em
um mesmo período de 24 horas.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='toque',
    area_target_effect_text='Alvo: 2d4 frutos frescos tocados',
    duration='Um dia/nível',
    saving_throw='Nenhum',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Bom Fruto');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Bom Fruto'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Bom Fruto'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Bom Fruto'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Bom Fruto'), 1);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Bordão de Magia', 'O personagem armazena uma magia que ele possa
conjurar num bordão de madeira. Somente uma magia
pode ser guardada em um mesmo bordão simultane-
amente e o druida não pode ter mais de um bordão de
magia. Ele é capaz de conjurar a magia preparada no
bordão como se a tivesse preparado, mas não a subtrai
do seu limite diário de magias daquele dia. Ele precisa
fornecer qualquer componente material necessário para
conjurar a magia quando armazená-la no objeto.', 8, '', '', '10 minutos', 'toque', 'Alvo: Bordão de madeira tocado', 'Permanente até ser descarregado (D)', 'Vontade anula (objeto)', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='O personagem armazena uma magia que ele possa
conjurar num bordão de madeira. Somente uma magia
pode ser guardada em um mesmo bordão simultane-
amente e o druida não pode ter mais de um bordão de
magia. Ele é capaz de conjurar a magia preparada no
bordão como se a tivesse preparado, mas não a subtrai
do seu limite diário de magias daquele dia. Ele precisa
fornecer qualquer componente material necessário para
conjurar a magia quando armazená-la no objeto.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='10 minutos',
    range_text='toque',
    area_target_effect_text='Alvo: Bordão de madeira tocado',
    duration='Permanente até ser descarregado (D)',
    saving_throw='Vontade anula (objeto)',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Bordão de Magia');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Bordão de Magia'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Bordão de Magia'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Bordão de Magia'), 4, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Bordão de Magia'), 6);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Brilho', 'Esse truque cria uma explosão de luz brilhante. Se
o conjurador fizer a luz aparecer diretamente na face
de uma única criatura, ela ficará ofuscada durante 1
minuto, a menos que obtenha sucesso em um teste de
resistência. As criaturas que não enxergam, assim como
as criaturas já ofuscadas, não são afetadas por brilho.', 5, '', '[Fogo]', '1 ação padrão', 'Curto (7,5 metros +1,5 metro/2 níveis)', 'Alvo: Explosão de luz', 'Instantânea', 'Fortitude anula', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Esse truque cria uma explosão de luz brilhante. Se
o conjurador fizer a luz aparecer diretamente na face
de uma única criatura, ela ficará ofuscada durante 1
minuto, a menos que obtenha sucesso em um teste de
resistência. As criaturas que não enxergam, assim como
as criaturas já ofuscadas, não são afetadas por brilho.', 
    school_id=5, 
    subschool='', 
    descriptors='[Fogo]', 
    casting_time='1 ação padrão',
    range_text='Curto (7,5 metros +1,5 metro/2 níveis)',
    area_target_effect_text='Alvo: Explosão de luz',
    duration='Instantânea',
    saving_throw='Fortitude anula',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Brilho');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Brilho'), 1, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Brilho'), 0);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Brilho'), 0);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Brilho'), 0);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Brilho'), 0);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Cajado Vivo', 'O druida transforma um cajado especialmente
preparado em uma criatura Enorme similar a um
ente, com cerca de 7,2 m de altura. Ao colocar a ponta
do cajado no chão e pronunciar uma palavra especial
para concluir a magia, o cajado se transforma em uma
criatura que se parece e luta como um ente (veja o Livro
dos Monstros). O cajado-ente o defende e obedece a
qualquer comando falado. Porém, ele não é um ente
verdadeiro; ele não é capaz de conversar com entes
de verdade ou controlar árvores. Se o cajado-ente for
reduzido a 0 pontos de vida ou menos, se transformará
em pó e será destruído. Caso contrário, poderá ser
usado como foco para conjurar novamente a magia. O
cajado-ente estará sempre em estado perfeito quando
for criado, independente dos ferimentos que tenha
sofrido na última transformação.
Foco: O cajado, que deve ser especialmente prepa-
rado. O bordão precisa ser um galho sólido, cortado de
um carvalho, freixo ou teixo, e então curtido, moldado
e polido (um processo que gasta 28 dias). Não é possível
se aventurar ou engajar-se em outras atividades extenu-
antes durante esse período.', 8, '', '', '1 rodada', 'Toque', 'Alvo: O cajado empunhado', '1 hora/nível (D)', 'Nenhum', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='O druida transforma um cajado especialmente
preparado em uma criatura Enorme similar a um
ente, com cerca de 7,2 m de altura. Ao colocar a ponta
do cajado no chão e pronunciar uma palavra especial
para concluir a magia, o cajado se transforma em uma
criatura que se parece e luta como um ente (veja o Livro
dos Monstros). O cajado-ente o defende e obedece a
qualquer comando falado. Porém, ele não é um ente
verdadeiro; ele não é capaz de conversar com entes
de verdade ou controlar árvores. Se o cajado-ente for
reduzido a 0 pontos de vida ou menos, se transformará
em pó e será destruído. Caso contrário, poderá ser
usado como foco para conjurar novamente a magia. O
cajado-ente estará sempre em estado perfeito quando
for criado, independente dos ferimentos que tenha
sofrido na última transformação.
Foco: O cajado, que deve ser especialmente prepa-
rado. O bordão precisa ser um galho sólido, cortado de
um carvalho, freixo ou teixo, e então curtido, moldado
e polido (um processo que gasta 28 dias). Não é possível
se aventurar ou engajar-se em outras atividades extenu-
antes durante esse período.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='1 rodada',
    range_text='Toque',
    area_target_effect_text='Alvo: O cajado empunhado',
    duration='1 hora/nível (D)',
    saving_throw='Nenhum',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Cajado Vivo');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Cajado Vivo'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Cajado Vivo'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Cajado Vivo'), 4, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Cajado Vivo'), 7);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Caminhar na Água', 'As criaturas transmutadas podem caminhar sobre
qualquer líquido como se fosse terra firme. Lama,
óleo, neve, areia movediça, água corrente, gelo e até
lava podem ser atravessados facilmente – os pés do
alvo flutuam entre 2,5 cm e 5 cm acima da superfície.
As criaturas que estiverem atravessando lava derretida
ainda sofrem o dano devido ao calor, pois estão perto
da fonte. O alvo será capaz de andar, correr, realizar
Investidas ou se deslocar como se a superfície fosse
terreno normal.
Se a magia for conjurada sob a água (ou quando
os alvos estiverem parcial ou completamente submersos
em algum líquido), os alvos sobem para a superfície
com deslocamento de 18 m por rodada, até que possam
ficar de pé sobre ela.', 8, '', '[Água]', '1 ação padrão', 'Toque', 'Alvo: Uma criatura tocada/nível', '10 minutos/nível (D)', 'Vontade anula (inofensiva)', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='As criaturas transmutadas podem caminhar sobre
qualquer líquido como se fosse terra firme. Lama,
óleo, neve, areia movediça, água corrente, gelo e até
lava podem ser atravessados facilmente – os pés do
alvo flutuam entre 2,5 cm e 5 cm acima da superfície.
As criaturas que estiverem atravessando lava derretida
ainda sofrem o dano devido ao calor, pois estão perto
da fonte. O alvo será capaz de andar, correr, realizar
Investidas ou se deslocar como se a superfície fosse
terreno normal.
Se a magia for conjurada sob a água (ou quando
os alvos estiverem parcial ou completamente submersos
em algum líquido), os alvos sobem para a superfície
com deslocamento de 18 m por rodada, até que possam
ficar de pé sobre ela.', 
    school_id=8, 
    subschool='', 
    descriptors='[Água]', 
    casting_time='1 ação padrão',
    range_text='Toque',
    area_target_effect_text='Alvo: Uma criatura tocada/nível',
    duration='10 minutos/nível (D)',
    saving_throw='Vontade anula (inofensiva)',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Caminhar na Água');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Caminhar na Água'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Caminhar na Água'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Caminhar na Água'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (8, (SELECT id FROM spells WHERE name='Caminhar na Água'), 3);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Caminhar em Árvores', '', 2, 'Teletransporte', '', '1 ação padrão', 'Pessoal', 'Alvo: Você', '1 hora/nível ou até ser gasta; veja texto', '', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=2, 
    subschool='Teletransporte', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Pessoal',
    area_target_effect_text='Alvo: Você',
    duration='1 hora/nível ou até ser gasta; veja texto',
    saving_throw='',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Caminhar em Árvores');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Caminhar em Árvores'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Caminhar em Árvores'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Caminhar em Árvores'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Caminhar em Árvores'), 5);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (8, (SELECT id FROM spells WHERE name='Caminhar em Árvores'), 4);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Caminhar no Vento', 'O personagem modifica as substâncias de seu cor-
po para se transformar em vapor (como a magia forma
gasosa) e deslocar-se pelo ar, provavelmente em grandes
velocidades. Ele é capaz de carregar outras criaturas
consigo, mas cada uma age de modo independente.
Normalmente, um caminhante do vento voará
com um deslocamento de 3 metros com capacidade
de perfeita. Se o alvo desejar, um vento mágico o em-
purrará com deslocamento de até 180 m por rodada
(90 km/h), com capacidade de manobra ruim. Eles não
ficam invisíveis, mas adquirem uma aparência translú-
cida de vapor. Se estiver vestindo branco, existe 80%
de chance de serem confundido com nuvens, névoa,
vapor ou algo similar.
Um caminhante do vento recupera sua forma física
quando desejar e pode voltar a forma de vapor poste-
riormente. Cada mudança de forma exige 5 rodadas,
que são deduzidas na duração da magia (assim como
o tempo gasto na forma física). Conforme indicado
acima, o personagem é capaz de dissipar o efeito. Ele
pode até dissipá-la de um caminhante escolhido sem
afetar os demais.
Durante o último minuto da magia, os caminhantes
do vento descem automaticamente a 18 m por rodada
(uma descida total de até 180 m), mas são capazes de
pousar mais rapidamente se quiserem. Essa descida
serve como aviso que a magia está prestes a acabar.', 8, '', '[Ar]', '1 ação padrão', 'Toque', 'Alvo: Você e uma criatura tocada/3 níveis', '1 hora/nível (D); veja texto', 'Nenhum e Vontade anula', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='O personagem modifica as substâncias de seu cor-
po para se transformar em vapor (como a magia forma
gasosa) e deslocar-se pelo ar, provavelmente em grandes
velocidades. Ele é capaz de carregar outras criaturas
consigo, mas cada uma age de modo independente.
Normalmente, um caminhante do vento voará
com um deslocamento de 3 metros com capacidade
de perfeita. Se o alvo desejar, um vento mágico o em-
purrará com deslocamento de até 180 m por rodada
(90 km/h), com capacidade de manobra ruim. Eles não
ficam invisíveis, mas adquirem uma aparência translú-
cida de vapor. Se estiver vestindo branco, existe 80%
de chance de serem confundido com nuvens, névoa,
vapor ou algo similar.
Um caminhante do vento recupera sua forma física
quando desejar e pode voltar a forma de vapor poste-
riormente. Cada mudança de forma exige 5 rodadas,
que são deduzidas na duração da magia (assim como
o tempo gasto na forma física). Conforme indicado
acima, o personagem é capaz de dissipar o efeito. Ele
pode até dissipá-la de um caminhante escolhido sem
afetar os demais.
Durante o último minuto da magia, os caminhantes
do vento descem automaticamente a 18 m por rodada
(uma descida total de até 180 m), mas são capazes de
pousar mais rapidamente se quiserem. Essa descida
serve como aviso que a magia está prestes a acabar.', 
    school_id=8, 
    subschool='', 
    descriptors='[Ar]', 
    casting_time='1 ação padrão',
    range_text='Toque',
    area_target_effect_text='Alvo: Você e uma criatura tocada/3 níveis',
    duration='1 hora/nível (D); veja texto',
    saving_throw='Nenhum e Vontade anula',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Caminhar no Vento');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Caminhar no Vento'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Caminhar no Vento'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Caminhar no Vento'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Caminhar no Vento'), 6);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Caminhar no Vento'), 7);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Campo Antimagia', 'O conjurador é cercado por uma barreira invisível
que acompanha seus movimentos. O espaço interno
desta barreira impede a passagem da maioria dos efei-
tos mágicos, incluindo magias, habilidades similares à
magia e habilidades sobrenaturais. Do mesmo modo,
impede o funcionamento de qualquer item mágico
em seu interior.
Um campo antimagia neutraliza qualquer magia
ou efeito mágico usado dentro dele, que invada ou seja
conjurado em sua área, mas não os dissipa. Por exemplo,
uma criatura sob os efeitos de velocidade não conservaria
os benefícios da magia no interior do campo, mas a
magia continuaria a funcionar além da área afetada.
O tempo transcorrido dentro do campo antimagia é
considerado na duração da magia suprimida.
As criaturas invocadas ou convocadas e os mor-
tos-vivos incorpóreos desaparecem quando entram em
um campo antimagia. Elas reaparecem no mesmo local
depois que o campo se dissipar. O tempo transcorrido
durante esse ‘desaparecimento’ é considerado normal-
mente na duração da conjuração que sustenta a criatura.
Se o personagem conjurar um campo antimagia numa
área ocupada por uma criatura invocada que tenha
Resistência à Magia, será preciso realizar um teste de
conjurador (1d20 + nível de conjurador) contra a RM
da criatura para fazê-la desaparecer (os efeitos de conju-
rações instantâneas, como criar água, não são afetados
por um campo antimagia, pois não há efeitos ativos
desse tipo de magia, apenas um resultado).
As criaturas normais (um troll comum em vez de
um troll conjurado) podem entrar no campo, assim
como os projéteis comuns. Ainda que uma espada
encantada não receba seus benefícios mágicos na área,
ela ainda é uma espada (e uma obra-prima). A magia
não afeta constructos imbuídos com magia durante sua
criação, mas que se tornam auto-suficientes (exceto se
foram invocados, quando são tratados como qualquer
criatura invocada). Os elementais, criaturas planares e
mortos-vivos corpóreos não são afetados, a menos que
tenham sido invocados. Porém, as habilidades similares
à magia ou sobrenaturais dessas criaturas podem ser
temporariamente suprimidas pelo campo.
Dissipar Magia não remove o campo antimagia.
Dois ou mais campos antimagia sobre o mesmo espaço
não se neutralizam. Certas magias, como muralha de
energia, esfera prismática e muralha prismática não são
afetadas por um campo antimagia. Os artefatos, os
semi-deuses e os deuses de posto superior não são afeta-
dos por um efeito mortal como este (consulte o Livro do
Mestre para obter maiores detalhes sobre artefatos).
Se o personagem é maior que a área da barreira,
qualquer parte de seu corpo que estiver além dela não
será afetada.
Componentes Materiais Arcanos: Um pouco de ferro
em pó ou pedaços de ferro.', 1, '', '', '1 ação padrão', '3 m', 'Área: Emanação de 3 m de raio centrada no', '10 minutos/nível (D)', 'Nenhum', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='O conjurador é cercado por uma barreira invisível
que acompanha seus movimentos. O espaço interno
desta barreira impede a passagem da maioria dos efei-
tos mágicos, incluindo magias, habilidades similares à
magia e habilidades sobrenaturais. Do mesmo modo,
impede o funcionamento de qualquer item mágico
em seu interior.
Um campo antimagia neutraliza qualquer magia
ou efeito mágico usado dentro dele, que invada ou seja
conjurado em sua área, mas não os dissipa. Por exemplo,
uma criatura sob os efeitos de velocidade não conservaria
os benefícios da magia no interior do campo, mas a
magia continuaria a funcionar além da área afetada.
O tempo transcorrido dentro do campo antimagia é
considerado na duração da magia suprimida.
As criaturas invocadas ou convocadas e os mor-
tos-vivos incorpóreos desaparecem quando entram em
um campo antimagia. Elas reaparecem no mesmo local
depois que o campo se dissipar. O tempo transcorrido
durante esse ‘desaparecimento’ é considerado normal-
mente na duração da conjuração que sustenta a criatura.
Se o personagem conjurar um campo antimagia numa
área ocupada por uma criatura invocada que tenha
Resistência à Magia, será preciso realizar um teste de
conjurador (1d20 + nível de conjurador) contra a RM
da criatura para fazê-la desaparecer (os efeitos de conju-
rações instantâneas, como criar água, não são afetados
por um campo antimagia, pois não há efeitos ativos
desse tipo de magia, apenas um resultado).
As criaturas normais (um troll comum em vez de
um troll conjurado) podem entrar no campo, assim
como os projéteis comuns. Ainda que uma espada
encantada não receba seus benefícios mágicos na área,
ela ainda é uma espada (e uma obra-prima). A magia
não afeta constructos imbuídos com magia durante sua
criação, mas que se tornam auto-suficientes (exceto se
foram invocados, quando são tratados como qualquer
criatura invocada). Os elementais, criaturas planares e
mortos-vivos corpóreos não são afetados, a menos que
tenham sido invocados. Porém, as habilidades similares
à magia ou sobrenaturais dessas criaturas podem ser
temporariamente suprimidas pelo campo.
Dissipar Magia não remove o campo antimagia.
Dois ou mais campos antimagia sobre o mesmo espaço
não se neutralizam. Certas magias, como muralha de
energia, esfera prismática e muralha prismática não são
afetadas por um campo antimagia. Os artefatos, os
semi-deuses e os deuses de posto superior não são afeta-
dos por um efeito mortal como este (consulte o Livro do
Mestre para obter maiores detalhes sobre artefatos).
Se o personagem é maior que a área da barreira,
qualquer parte de seu corpo que estiver além dela não
será afetada.
Componentes Materiais Arcanos: Um pouco de ferro
em pó ou pedaços de ferro.', 
    school_id=1, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='3 m',
    area_target_effect_text='Área: Emanação de 3 m de raio centrada no',
    duration='10 minutos/nível (D)',
    saving_throw='Nenhum',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Campo Antimagia');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Campo Antimagia'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Campo Antimagia'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Campo Antimagia'), 3, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Campo Antimagia'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Campo Antimagia'), 8);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (13, (SELECT id FROM spells WHERE name='Campo Antimagia'), 6);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (18, (SELECT id FROM spells WHERE name='Campo Antimagia'), 6);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Campo Antimagia'), 6);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Campo Antimagia'), 6);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Canção da Discórdia', 'Essa magia faz as criaturas que estiverem na área
afetada se voltarem contra elas mesmas em vez de en-
frentar seus inimigos. Cada criatura afetada tem 50%
de chance de atacar o alvo mais próximo a cada rodada.
Determine o comportamento de cada criatura a cada
rodada, no começo de seu turno. Uma criatura que não
ataque o personagem mais próximo estará livre para agir
normalmente na sua rodada.
As criaturas forçadas pela canção da discórdia a
atacar seus companheiros empregam todos os métodos
que dispõem, escolhendo suas magias mais letais e as
táticas de combate mais vantajosas. No entanto, elas
não atacam alvos que estejam inconscientes.', 4, 'Compulsão', '[de Ação Mental]', '1 ação padrão', 'Médio (30 metros + 3 metros/nível)', 'Área: Criaturas em uma dispersão de 6 metros', '1 rodada/nível', 'Vontade anula', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Essa magia faz as criaturas que estiverem na área
afetada se voltarem contra elas mesmas em vez de en-
frentar seus inimigos. Cada criatura afetada tem 50%
de chance de atacar o alvo mais próximo a cada rodada.
Determine o comportamento de cada criatura a cada
rodada, no começo de seu turno. Uma criatura que não
ataque o personagem mais próximo estará livre para agir
normalmente na sua rodada.
As criaturas forçadas pela canção da discórdia a
atacar seus companheiros empregam todos os métodos
que dispõem, escolhendo suas magias mais letais e as
táticas de combate mais vantajosas. No entanto, elas
não atacam alvos que estejam inconscientes.', 
    school_id=4, 
    subschool='Compulsão', 
    descriptors='[de Ação Mental]', 
    casting_time='1 ação padrão',
    range_text='Médio (30 metros + 3 metros/nível)',
    area_target_effect_text='Área: Criaturas em uma dispersão de 6 metros',
    duration='1 rodada/nível',
    saving_throw='Vontade anula',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Canção da Discórdia');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Canção da Discórdia'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Canção da Discórdia'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Canção da Discórdia'), 5);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Canção de Ninar', 'Qualquer criatura na área afetada que fracassar em
um teste de resistência de Vontade ficará sonolenta e
desatenta, sofrendo -5 de penalidade nos testes de Ouvir
e Observar e -2 de penalidade nos testes de resistência
de Vontade contra efeitos de sono enquanto a canção de
ninar permanecer ativa. A duração da magia se estende
enquanto o conjurador se concentrar +1 rodada por
nível de conjurador.', 4, 'Compulsão', '[de ação mental]', '1 ação padrão', 'Médio (30 metros + 3 metros/nível)', 'Área: Criaturas vivas dentro de uma explosão de', 'Concentração + 1 rodada/nível (D)', 'Vontade anula', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Qualquer criatura na área afetada que fracassar em
um teste de resistência de Vontade ficará sonolenta e
desatenta, sofrendo -5 de penalidade nos testes de Ouvir
e Observar e -2 de penalidade nos testes de resistência
de Vontade contra efeitos de sono enquanto a canção de
ninar permanecer ativa. A duração da magia se estende
enquanto o conjurador se concentrar +1 rodada por
nível de conjurador.', 
    school_id=4, 
    subschool='Compulsão', 
    descriptors='[de ação mental]', 
    casting_time='1 ação padrão',
    range_text='Médio (30 metros + 3 metros/nível)',
    area_target_effect_text='Área: Criaturas vivas dentro de uma explosão de',
    duration='Concentração + 1 rodada/nível (D)',
    saving_throw='Vontade anula',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Canção de Ninar');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Canção de Ninar'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Canção de Ninar'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Canção de Ninar'), 0);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Cancelar Encantamento', 'Esse efeito de dissipação liberta as criaturas de
encantamentos, transmutações e maldições. Cancelar
encantamento pode reverter um efeito instantâneo,
como carne para pedra. Para cada efeito, o persona-
gem realiza um teste de conjurador (1d20 + nível de
conjurador, máximo +15) contra CD 11 + nível do
conjurador do efeito. Um sucesso indica que a criatura
se libertou da magia, maldição ou efeito. Para itens
mágicos amaldiçoados, a CD é 25.
Se a magia não puder ser neutralizada por dissipar
magia em função de uma propriedade especial, cance-
lar encantamento só afetará as magias de 5° nível ou
inferiores. Por exemplo, rogar maldição não pode ser
anulada por dissipar magia, mas cancelar encantamento
é capaz de afetá-la.
Se o efeito advém de um item mágico permanente,
como uma espada amaldiçoada, cancelar encantamento
não remove a maldição do item, mas libera a vítima
dos seus efeitos, mantendo o item amaldiçoado. Por
exemplo, um item amaldiçoado pode modificar a ten-
dência de seu dono. Cancelar encantamento permite que
a vitima se liberte do objeto (e recupere sua tendência
anterior), mas a maldição do item continua intacta e
afetará a próxima criatura que empunhá-la – mesmo
que esta criatura já tenha sido alvo de cancelar encan-
tamento anteriormente.', 1, '', '', '1 minuto', 'Curto (7,5 m + 1,5 m/2 níveis)', '', 'Instantânea', 'Veja texto', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='Esse efeito de dissipação liberta as criaturas de
encantamentos, transmutações e maldições. Cancelar
encantamento pode reverter um efeito instantâneo,
como carne para pedra. Para cada efeito, o persona-
gem realiza um teste de conjurador (1d20 + nível de
conjurador, máximo +15) contra CD 11 + nível do
conjurador do efeito. Um sucesso indica que a criatura
se libertou da magia, maldição ou efeito. Para itens
mágicos amaldiçoados, a CD é 25.
Se a magia não puder ser neutralizada por dissipar
magia em função de uma propriedade especial, cance-
lar encantamento só afetará as magias de 5° nível ou
inferiores. Por exemplo, rogar maldição não pode ser
anulada por dissipar magia, mas cancelar encantamento
é capaz de afetá-la.
Se o efeito advém de um item mágico permanente,
como uma espada amaldiçoada, cancelar encantamento
não remove a maldição do item, mas libera a vítima
dos seus efeitos, mantendo o item amaldiçoado. Por
exemplo, um item amaldiçoado pode modificar a ten-
dência de seu dono. Cancelar encantamento permite que
a vitima se liberte do objeto (e recupere sua tendência
anterior), mas a maldição do item continua intacta e
afetará a próxima criatura que empunhá-la – mesmo
que esta criatura já tenha sido alvo de cancelar encan-
tamento anteriormente.', 
    school_id=1, 
    subschool='', 
    descriptors='', 
    casting_time='1 minuto',
    range_text='Curto (7,5 m + 1,5 m/2 níveis)',
    area_target_effect_text='',
    duration='Instantânea',
    saving_throw='Veja texto',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Cancelar Encantamento');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Cancelar Encantamento'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Cancelar Encantamento'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Cancelar Encantamento'), 4);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Cancelar Encantamento'), 5);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (20, (SELECT id FROM spells WHERE name='Cancelar Encantamento'), 5);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (7, (SELECT id FROM spells WHERE name='Cancelar Encantamento'), 5);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Cancelar Encantamento'), 5);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Cancelar Encantamento'), 5);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Cão Fiel de Mordenkainen', 'O personagem conjura um cão de guarda fantas-
magórico que é invisível para qualquer criatura, exceto
ele. Ele protegerá a área onde foi conjurado (ele não se
move). O cão começa a latir alto imediatamente quando
uma criatura Pequena ou Grande se aproxima a 9 me-
tros dele. As criaturas que estavam a 9 metros do animal
quando ele foi conjurado podem se deslocar livremente
na área, mas se saírem e voltarem, ativarão o latido. O
cão é capaz de ver criaturas invisíveis e etéreas, mas não
reage a ilusões, embora reaja a ilusões de sombra.
Se um intruso se aproximar a 1,5 metro do cão,
ele pára de latir e tenta morder o intruso (bônus base
de ataque +10, 2d6+3 pontos de dano de perfuração)
uma vez por rodada. Ele recebe os bônus apropriados
para criaturas invisíveis. Considera-se que o cão possui
realiza sua jogada de ataque antes da ação do invasor.
Sua mordida equivale a uma arma mágica em relação à
Redução de Dano e ele não pode ser atacado, somente
dissipado.
A magia permanece ativa durante 1 hora por nível
de conjurador. Depois que o animal começar a latir, a
duração será reduzida para 1 rodada por nível de con-
jurador. Se o conjurador estiver a mais de 30 metros de
distância do fantasma, a magia é dissipada.
Componentes Materiais: Um pequeno apito de
prata, um pedaço de osso e um fio.', 2, 'Criação', '', '1 ação padrão', 'Curto (7,5 m + 1,5 m/2 níveis)', 'Alvo: Cão de guarda fantasmagórico', '1 hora/nível do conjurador ou até ser', 'Nenhum', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='O personagem conjura um cão de guarda fantas-
magórico que é invisível para qualquer criatura, exceto
ele. Ele protegerá a área onde foi conjurado (ele não se
move). O cão começa a latir alto imediatamente quando
uma criatura Pequena ou Grande se aproxima a 9 me-
tros dele. As criaturas que estavam a 9 metros do animal
quando ele foi conjurado podem se deslocar livremente
na área, mas se saírem e voltarem, ativarão o latido. O
cão é capaz de ver criaturas invisíveis e etéreas, mas não
reage a ilusões, embora reaja a ilusões de sombra.
Se um intruso se aproximar a 1,5 metro do cão,
ele pára de latir e tenta morder o intruso (bônus base
de ataque +10, 2d6+3 pontos de dano de perfuração)
uma vez por rodada. Ele recebe os bônus apropriados
para criaturas invisíveis. Considera-se que o cão possui
realiza sua jogada de ataque antes da ação do invasor.
Sua mordida equivale a uma arma mágica em relação à
Redução de Dano e ele não pode ser atacado, somente
dissipado.
A magia permanece ativa durante 1 hora por nível
de conjurador. Depois que o animal começar a latir, a
duração será reduzida para 1 rodada por nível de con-
jurador. Se o conjurador estiver a mais de 30 metros de
distância do fantasma, a magia é dissipada.
Componentes Materiais: Um pequeno apito de
prata, um pedaço de osso e um fio.', 
    school_id=2, 
    subschool='Criação', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Curto (7,5 m + 1,5 m/2 níveis)',
    area_target_effect_text='Alvo: Cão de guarda fantasmagórico',
    duration='1 hora/nível do conjurador ou até ser',
    saving_throw='Nenhum',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Cão Fiel de Mordenkainen');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Cão Fiel de Mordenkainen'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Cão Fiel de Mordenkainen'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Cão Fiel de Mordenkainen'), 3, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Cão Fiel de Mordenkainen'), 5);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Cão Fiel de Mordenkainen'), 5);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Carne para Pedra', 'O alvo e todo seu equipamento se transformam
em uma estátua inerte e sem consciência. Se a estátua
resultante desta magia for quebrada ou danificada, a
criatura (se voltar a seu estado original) sofrerá o dano
e deformidades equivalentes. A criatura não está morta,
mas também não parece viva quando é observada por
magias como visão da morte. Somente as criaturas feitas
de carne podem ser afetadas por esta magia.
Componentes Materiais: Limo, água e pedra.', 8, '', '', '1 ação padrão', 'Médio (30 metros + 3 metros/nível)', 'Alvo: Uma criatura', 'Instantânea', 'Fortitude anula', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='O alvo e todo seu equipamento se transformam
em uma estátua inerte e sem consciência. Se a estátua
resultante desta magia for quebrada ou danificada, a
criatura (se voltar a seu estado original) sofrerá o dano
e deformidades equivalentes. A criatura não está morta,
mas também não parece viva quando é observada por
magias como visão da morte. Somente as criaturas feitas
de carne podem ser afetadas por esta magia.
Componentes Materiais: Limo, água e pedra.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Médio (30 metros + 3 metros/nível)',
    area_target_effect_text='Alvo: Uma criatura',
    duration='Instantânea',
    saving_throw='Fortitude anula',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Carne para Pedra');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Carne para Pedra'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Carne para Pedra'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Carne para Pedra'), 3, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Carne para Pedra'), 6);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Carne para Pedra'), 6);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Carvalho Vivo', 'Essa magia transforma um carvalho em um pro-
tetor ou guardião. A magia só pode ser conjurada em
uma única árvore simultaneamente; enquanto carvalho
vivo estiver ativa, é impossível conjurá-la novamente em
outra árvore. O alvo deve estar a menos de 3 metros da
residência do personagem ou a menos de 90 metros de
algo que ele queira guardar ou proteger.
A magia deve ser conjurada em um carvalho
Enorme e saudável. Uma frase de gatilho de até uma
palavra por nível é colocada sobre o carvalho. Por
exemplo, “Ataque qualquer pessoa que chegue perto
sem primeiro dizer ‘visco sagrado’” é uma frase gatilho
de onze palavras que poderia ser usada por um perso-
nagem de 11° nível ou superior. A magia transforma a
árvore em um ser animado como um ente (veja o Livro
dos Monstros). Se o Mestre permitir, pode-se definir es-
tatísticas inferiores quando carvalho vivo for conjurada
sobre uma árvore menor.
Se a magia carvalho vivo for dissipada, a árvore cria
raízes onde estiver. Caso esteja livre, tentará voltar para
sua localização original antes de enraizar-se.', 8, '', '', '10 minutos', 'Toque', 'Alvo: Árvore tocada', 'Um dia/nível (D)', 'Nenhum', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='Essa magia transforma um carvalho em um pro-
tetor ou guardião. A magia só pode ser conjurada em
uma única árvore simultaneamente; enquanto carvalho
vivo estiver ativa, é impossível conjurá-la novamente em
outra árvore. O alvo deve estar a menos de 3 metros da
residência do personagem ou a menos de 90 metros de
algo que ele queira guardar ou proteger.
A magia deve ser conjurada em um carvalho
Enorme e saudável. Uma frase de gatilho de até uma
palavra por nível é colocada sobre o carvalho. Por
exemplo, “Ataque qualquer pessoa que chegue perto
sem primeiro dizer ‘visco sagrado’” é uma frase gatilho
de onze palavras que poderia ser usada por um perso-
nagem de 11° nível ou superior. A magia transforma a
árvore em um ser animado como um ente (veja o Livro
dos Monstros). Se o Mestre permitir, pode-se definir es-
tatísticas inferiores quando carvalho vivo for conjurada
sobre uma árvore menor.
Se a magia carvalho vivo for dissipada, a árvore cria
raízes onde estiver. Caso esteja livre, tentará voltar para
sua localização original antes de enraizar-se.', 
    school_id=8, 
    subschool='', 
    descriptors='', 
    casting_time='10 minutos',
    range_text='Toque',
    area_target_effect_text='Alvo: Árvore tocada',
    duration='Um dia/nível (D)',
    saving_throw='Nenhum',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Carvalho Vivo');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Carvalho Vivo'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Carvalho Vivo'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Carvalho Vivo'), 6);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Cativar', 'Se o personagem tiver a atenção de um grupo
de criaturas, poderá usar esta magia para mantê-las
enfeitiçadas. Para conjurar a magia, é necessário falar
ou cantar sem interrupção durante 1 rodada. Depois
disso, todos os alvos afetados prestam atenção completa
ao conjurador, ignorando tudo o que acontece ao seu
redor. A atitude deles será considerada “amistosa” en-
quanto o efeito da magia permanecer ativo (veja o Livro
do Mestre para obter informações sobre atitudes). Todas
as criaturas de raças ou religiões inimigas recebem +4
de bônus nos seus testes de resistência.
As criaturas com 4 DV ou mais e/ou Sabedoria 16
ou superior mantém a consciência de seus arredores e
sua atitude será indiferente. Elas recebem novos testes
de resistência se perceberem ações contrárias às suas
expectativas.
O encantamento permanece ativo enquanto o
personagem falar ou cantar, limitado a 1 hora. Todos os
cativados não realizam nenhuma outra ação enquanto
o conjurador falar ou cantar e debatem o assunto ou
sua atuação durante 1d3 rodadas depois disso. Todas
as criaturas que entrarem na área da magia sofrem
seus efeitos, a menos que obtenham sucesso em seu
teste de resistência. A magia termina (mas ainda con-
tinua durante 1d3 rodadas) se o conjurador perder a
concentração ou realizar qualquer outra ação além de
falar ou cantar.
Caso as criaturas que não sejam afetadas pela magia
tomarem atitudes pouco amigáveis ou hostis contra o
conjurador, todos os alvos podem realizar um teste de
Carisma coletivo para dissipar a magia. Este teste é rea-
lizado pelo personagem contra o Carisma mais elevado
da audiência e os demais utilizam a ação Prestar Auxilio.
A bagunça dissipa a magia se o conjurador perder esse
teste resistido de Carisma. Somente um teste resistido
é permitido por ativação desta magia.
Se um membro da audiência for atacado (ou se
tornar alvo de uma ação hostil), a magia termina e a
audiência se torna imediatamente pouco amigável (ou
hostil, para os membros da audiência com 4 DV ou
mais ou Sabedoria 16 ou superior).', 4, 'Feitiço', '[Dependente de Idioma,', '1 rodada', 'Médio (30 m + 3 m/nível)', 'Alvo: Qualquer quantidade de criaturas', 'Até 1 hora', 'Vontade anula (veja texto)', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Se o personagem tiver a atenção de um grupo
de criaturas, poderá usar esta magia para mantê-las
enfeitiçadas. Para conjurar a magia, é necessário falar
ou cantar sem interrupção durante 1 rodada. Depois
disso, todos os alvos afetados prestam atenção completa
ao conjurador, ignorando tudo o que acontece ao seu
redor. A atitude deles será considerada “amistosa” en-
quanto o efeito da magia permanecer ativo (veja o Livro
do Mestre para obter informações sobre atitudes). Todas
as criaturas de raças ou religiões inimigas recebem +4
de bônus nos seus testes de resistência.
As criaturas com 4 DV ou mais e/ou Sabedoria 16
ou superior mantém a consciência de seus arredores e
sua atitude será indiferente. Elas recebem novos testes
de resistência se perceberem ações contrárias às suas
expectativas.
O encantamento permanece ativo enquanto o
personagem falar ou cantar, limitado a 1 hora. Todos os
cativados não realizam nenhuma outra ação enquanto
o conjurador falar ou cantar e debatem o assunto ou
sua atuação durante 1d3 rodadas depois disso. Todas
as criaturas que entrarem na área da magia sofrem
seus efeitos, a menos que obtenham sucesso em seu
teste de resistência. A magia termina (mas ainda con-
tinua durante 1d3 rodadas) se o conjurador perder a
concentração ou realizar qualquer outra ação além de
falar ou cantar.
Caso as criaturas que não sejam afetadas pela magia
tomarem atitudes pouco amigáveis ou hostis contra o
conjurador, todos os alvos podem realizar um teste de
Carisma coletivo para dissipar a magia. Este teste é rea-
lizado pelo personagem contra o Carisma mais elevado
da audiência e os demais utilizam a ação Prestar Auxilio.
A bagunça dissipa a magia se o conjurador perder esse
teste resistido de Carisma. Somente um teste resistido
é permitido por ativação desta magia.
Se um membro da audiência for atacado (ou se
tornar alvo de uma ação hostil), a magia termina e a
audiência se torna imediatamente pouco amigável (ou
hostil, para os membros da audiência com 4 DV ou
mais ou Sabedoria 16 ou superior).', 
    school_id=4, 
    subschool='Feitiço', 
    descriptors='[Dependente de Idioma,', 
    casting_time='1 rodada',
    range_text='Médio (30 m + 3 m/nível)',
    area_target_effect_text='Alvo: Qualquer quantidade de criaturas',
    duration='Até 1 hora',
    saving_throw='Vontade anula (veja texto)',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Cativar');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Cativar'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Cativar'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Cativar'), 2);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Cativar'), 2);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Causar Medo', 'A criatura afetada fica amedrontada. Caso o alvo
obtenha sucesso no teste de resistência de Vontade,
ficará apenas abalado durante uma rodada. As criaturas
com 6 Dados de Vida ou mais são imunes aos efeitos
dessa magia. Cansar medo serve de contramágica e
dissipa remover medo.', 7, '', '[Medo, Ação Mental]', 'l ação padrão', 'Curto (7,5 m + 1,5 m/2 níveis)', 'Alvo: Uma criatura viva com 5 DV ou menos', '1d4 rodadas ou 1 rodada (veja texto)', 'Vontade parcial', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='A criatura afetada fica amedrontada. Caso o alvo
obtenha sucesso no teste de resistência de Vontade,
ficará apenas abalado durante uma rodada. As criaturas
com 6 Dados de Vida ou mais são imunes aos efeitos
dessa magia. Cansar medo serve de contramágica e
dissipa remover medo.', 
    school_id=7, 
    subschool='', 
    descriptors='[Medo, Ação Mental]', 
    casting_time='l ação padrão',
    range_text='Curto (7,5 m + 1,5 m/2 níveis)',
    area_target_effect_text='Alvo: Uma criatura viva com 5 DV ou menos',
    duration='1d4 rodadas ou 1 rodada (veja texto)',
    saving_throw='Vontade parcial',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Causar Medo');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Causar Medo'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Causar Medo'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Causar Medo'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Causar Medo'), 1);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (15, (SELECT id FROM spells WHERE name='Causar Medo'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Causar Medo'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Causar Medo'), 1);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Cegueira/Surdez', 'O personagem utiliza o poder da necromancia para
causar cegueira ou surdez (à critério do conjurador) na
criatura selecionada.', 7, '', '', '1 ação padrão', 'Médio (30 m + 3 m/nível)', 'Alvo: Uma criatura viva', 'Permanente (D)', 'Fortitude anula', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='O personagem utiliza o poder da necromancia para
causar cegueira ou surdez (à critério do conjurador) na
criatura selecionada.', 
    school_id=7, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Médio (30 m + 3 m/nível)',
    area_target_effect_text='Alvo: Uma criatura viva',
    duration='Permanente (D)',
    saving_throw='Fortitude anula',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Cegueira/Surdez');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Cegueira/Surdez'), 1, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (2, (SELECT id FROM spells WHERE name='Cegueira/Surdez'), 2);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Cegueira/Surdez'), 3);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Cegueira/Surdez'), 2);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Cegueira/Surdez'), 2);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Cerrar Portas', 'Essa magia tranca magicamente uma porta, portão,
janela ou persiana de madeira, metal ou pedra. A magia
afeta o portal como se tivesse sido fechado e trancado
normalmente. Uma magia arrombar ou um sucesso em
dissipar magia elimina a magia cerrar portas. Adicione
5 pontos à Classe de Dificuldade para arrombar ou
quebrar um portal afetado com essa magia.', 1, '', '', '1 ação padrão', 'Médio (30 metros -1 3 metros/nível)', 'Alvo: Um portal de até 6 m /nível', '1 minuto/nível (D)', 'Nenhum', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='Essa magia tranca magicamente uma porta, portão,
janela ou persiana de madeira, metal ou pedra. A magia
afeta o portal como se tivesse sido fechado e trancado
normalmente. Uma magia arrombar ou um sucesso em
dissipar magia elimina a magia cerrar portas. Adicione
5 pontos à Classe de Dificuldade para arrombar ou
quebrar um portal afetado com essa magia.', 
    school_id=1, 
    subschool='', 
    descriptors='', 
    casting_time='1 ação padrão',
    range_text='Médio (30 metros -1 3 metros/nível)',
    area_target_effect_text='Alvo: Um portal de até 6 m /nível',
    duration='1 minuto/nível (D)',
    saving_throw='Nenhum',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Cerrar Portas');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Cerrar Portas'), 1, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Cerrar Portas'), 1);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Cerrar Portas'), 1);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Chama Contínua', 'Uma chama, equivalente em brilho a uma tocha,
surge no objeto tocado. O fogo se parece com uma
chama normal, mas não gera calor e não usa oxigênio.
A chama pode ser coberta e escondida, mas não pode
ser apagada.
As magias de luz funcionam como contra-mágica
e dissipam as magias de escuridão de mesmo nível ou
inferior.
Componente Material: Pó de rubi (valor de 50 PO)
despejado no item que vai carregar a chama.', 5, '', '[Luz]', '1 ação padrão', 'Toque', 'Efeito: Chama mágica ilusória', 'Permanente', 'Nenhum', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='Uma chama, equivalente em brilho a uma tocha,
surge no objeto tocado. O fogo se parece com uma
chama normal, mas não gera calor e não usa oxigênio.
A chama pode ser coberta e escondida, mas não pode
ser apagada.
As magias de luz funcionam como contra-mágica
e dissipam as magias de escuridão de mesmo nível ou
inferior.
Componente Material: Pó de rubi (valor de 50 PO)
despejado no item que vai carregar a chama.', 
    school_id=5, 
    subschool='', 
    descriptors='[Luz]', 
    casting_time='1 ação padrão',
    range_text='Toque',
    area_target_effect_text='Efeito: Chama mágica ilusória',
    duration='Permanente',
    saving_throw='Nenhum',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Chama Contínua');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Chama Contínua'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Chama Contínua'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Chama Contínua'), 3, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Chama Contínua'), 3);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Chama Contínua'), 2);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Chama Contínua'), 2);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Chuva de Meteoros', 'A chuva de meteoros é uma magia muito poderosa
e espetacular, similar à bola de fogo em muitos aspectos.
Quando é conjurada, quatro esferas de 60 cm de diâme-
tro são lançadas da palma da mão do personagem até
o ponto de impacto escolhido. As esferas de meteoro
deixam um rastro flamejante.
Se uma esfera for disparada em uma criatura espe-
cífica, o personagem deve realizar um ataque de toque à
distância para acertar o alvo com o meteoro. Qualquer
criatura acertada por uma dessas esferas sofre 2d6 pon-
tos de dano de concussão (sem teste de resistência) e
não poderá realizar o teste de resistência contra o dano
de fogo da esfera (veja abaixo). Se a esfera não atingir
o alvo, ela simplesmente explode na intersecção mais
próximo do quadrado daquela criatura.
Quando a esfera atinge seu destino, ele explode
numa dispersão de 12 metros de raio, causando 6d6
pontos de dano de fogo a cada criatura na área. Se a
criatura estiver na área de mais que uma esfera, ela deve
realizar os testes de resistência separados contra cada
uma. A resistência ao fogo se aplica ao dano de cada
esfera individualmente.', 5, '', '[Fogo]', '1 ação padrão', 'Longo (120 m + 12 m/nível)', 'Área: Quatro dispersões de 12 metros; veja texto', 'Instantânea', 'Nenhum ou Reflexos para', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='A chuva de meteoros é uma magia muito poderosa
e espetacular, similar à bola de fogo em muitos aspectos.
Quando é conjurada, quatro esferas de 60 cm de diâme-
tro são lançadas da palma da mão do personagem até
o ponto de impacto escolhido. As esferas de meteoro
deixam um rastro flamejante.
Se uma esfera for disparada em uma criatura espe-
cífica, o personagem deve realizar um ataque de toque à
distância para acertar o alvo com o meteoro. Qualquer
criatura acertada por uma dessas esferas sofre 2d6 pon-
tos de dano de concussão (sem teste de resistência) e
não poderá realizar o teste de resistência contra o dano
de fogo da esfera (veja abaixo). Se a esfera não atingir
o alvo, ela simplesmente explode na intersecção mais
próximo do quadrado daquela criatura.
Quando a esfera atinge seu destino, ele explode
numa dispersão de 12 metros de raio, causando 6d6
pontos de dano de fogo a cada criatura na área. Se a
criatura estiver na área de mais que uma esfera, ela deve
realizar os testes de resistência separados contra cada
uma. A resistência ao fogo se aplica ao dano de cada
esfera individualmente.', 
    school_id=5, 
    subschool='', 
    descriptors='[Fogo]', 
    casting_time='1 ação padrão',
    range_text='Longo (120 m + 12 m/nível)',
    area_target_effect_text='Área: Quatro dispersões de 12 metros; veja texto',
    duration='Instantânea',
    saving_throw='Nenhum ou Reflexos para',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Chuva de Meteoros');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Chuva de Meteoros'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Chuva de Meteoros'), 2, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Chuva de Meteoros'), 9);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Chuva de Meteoros'), 9);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Ciclone', 'Essa magia cria um poderoso ciclone de ventos
muito rápidos, que se move através do ar, sobre a terra
ou água com deslocamento de 18 metros por rodada.
O personagem é capaz de se concentrar para controlar
cada movimento do ciclone ou especificar uma rota
simples, como se mover para a frente, movimentar-se
em ziguezague, círculos, etc. Direcionar ou alterar o
movimento programado do ciclone exige uma ação
padrão. O ciclone sempre se desloca durante o turno
do conjurador. Se o ciclone sair do alcance da magia,
se deslocará aleatoriamente durante 1d3 rodadas – pos-
sivelmente ameaçando o personagem e seus aliados
– e então se dissipará. O personagem não consegue
recuperar o controle, mesmo se ele voltar a entrar na
área de alcance da magia.
Qualquer criatura Grande ou menor que entre em
contato com o ciclone precisa obter sucesso num teste
de resistência de Reflexos ou sofrerá 3d6 pontos de
dano. As criaturas Médias ou menores que fracassem em
seu primeiro teste precisam realizar um segundo para
evitar serem sugadas pelo ciclone e ficarem suspensas
por ventos poderosos, sofrendo 1d8 pontos de dano
por rodada sem direito a outro teste de resistência. O
conjurador pode forçar o ciclone a expelir qualquer
criatura sempre que desejar, jogando-a onde o ciclone
estiver no momento.', 5, '', '[Ar]', '1 ação padrão', 'Longo (120 m + 12 m/nível)', 'Efeito: Ciclone com largura de 3 metros na base', '1 rodada/nível (D)', 'Reflexos anula; veja texto', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='Essa magia cria um poderoso ciclone de ventos
muito rápidos, que se move através do ar, sobre a terra
ou água com deslocamento de 18 metros por rodada.
O personagem é capaz de se concentrar para controlar
cada movimento do ciclone ou especificar uma rota
simples, como se mover para a frente, movimentar-se
em ziguezague, círculos, etc. Direcionar ou alterar o
movimento programado do ciclone exige uma ação
padrão. O ciclone sempre se desloca durante o turno
do conjurador. Se o ciclone sair do alcance da magia,
se deslocará aleatoriamente durante 1d3 rodadas – pos-
sivelmente ameaçando o personagem e seus aliados
– e então se dissipará. O personagem não consegue
recuperar o controle, mesmo se ele voltar a entrar na
área de alcance da magia.
Qualquer criatura Grande ou menor que entre em
contato com o ciclone precisa obter sucesso num teste
de resistência de Reflexos ou sofrerá 3d6 pontos de
dano. As criaturas Médias ou menores que fracassem em
seu primeiro teste precisam realizar um segundo para
evitar serem sugadas pelo ciclone e ficarem suspensas
por ventos poderosos, sofrendo 1d8 pontos de dano
por rodada sem direito a outro teste de resistência. O
conjurador pode forçar o ciclone a expelir qualquer
criatura sempre que desejar, jogando-a onde o ciclone
estiver no momento.', 
    school_id=5, 
    subschool='', 
    descriptors='[Ar]', 
    casting_time='1 ação padrão',
    range_text='Longo (120 m + 12 m/nível)',
    area_target_effect_text='Efeito: Ciclone com largura de 3 metros na base',
    duration='1 rodada/nível (D)',
    saving_throw='Reflexos anula; veja texto',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Ciclone');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Ciclone'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Ciclone'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Ciclone'), 5, '');

INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Ciclone'), 8);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Ciclone'), 8);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Círculo Mágico contra o Bem', '', 1, '', '[Mal]', '', '', '', '', '', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=1, 
    subschool='', 
    descriptors='[Mal]', 
    casting_time='',
    range_text='',
    area_target_effect_text='',
    duration='',
    saving_throw='',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Círculo Mágico contra o Bem');
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Círculo Mágico contra o Bem'), 3);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (14, (SELECT id FROM spells WHERE name='Círculo Mágico contra o Bem'), 3);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (7, (SELECT id FROM spells WHERE name='Círculo Mágico contra o Bem'), 3);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Círculo Mágico contra o Bem'), 3);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Círculo Mágico contra o Bem'), 3);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Círculo Mágico contra o Caos', '', 1, '', '[Ordem]', '', '', '', '', '', 1, 1)
ON DUPLICATE KEY UPDATE 
    description='', 
    school_id=1, 
    subschool='', 
    descriptors='[Ordem]', 
    casting_time='',
    range_text='',
    area_target_effect_text='',
    duration='',
    saving_throw='',
    spell_resistance=1;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Círculo Mágico contra o Caos');
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Círculo Mágico contra o Caos'), 3);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (16, (SELECT id FROM spells WHERE name='Círculo Mágico contra o Caos'), 3);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (7, (SELECT id FROM spells WHERE name='Círculo Mágico contra o Caos'), 3);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Círculo Mágico contra o Caos'), 3);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Círculo Mágico contra o Caos'), 3);

INSERT INTO spells (name, description, school_id, subschool, descriptors, casting_time, range_text, area_target_effect_text, duration, saving_throw, spell_resistance, source_id)
VALUES ('Círculo Mágico Contra o Mal', 'Todas as criaturas dentro da área recebem os efeitos
da magia proteção contra o mal e nenhuma criatura que
não seja Boa é capaz de invadir essa área. É preciso
superar a Resistência a Magia da criatura para isolá-
la (como a terceira função de proteção contra o mal),
mas os bônus de deflexão, a resistência e a proteção
ao controle mental são aplicados, independentes da
RM do inimigo.
Essa magia tem uma versão alternativa que o con-
jurador deve escolher ao conjurá-la. Um círculo mágico
contra o mal pode ser voltado para o interior em vez
de para o exterior. Nesse caso, a magia aprisiona uma
criatura convocada (pelas magias âncora planar menor,
âncora planar e âncora planar maior, por exemplo), que
não seja Boa, durante 24 horas por nível de conjurador,
supondo que a magia de convocação seja executada
dentro de 1 rodada da conjuração do circulo mágico. A
criatura é incapaz de atravessar o circulo que a aprisiona.
Se a criatura for muito grande para ser comportada na
área da magia, o efeito agirá como uma proteção contra
o mal somente contra a criatura convocada.
Um círculo mágico é ineficaz como uma armadilha.
Se o circulo de pó de prata for removido no processo,
a conjuração é neutralizada, o efeito termina imedia-
tamente. A criatura presa não pode lazer nada contra o
circulo, d ire ta ou indiretamente, mas outras criaturas
podem. Se a criatura convocada tiver Resistência a
Magia, ela pode tentar neutralizar a armadilha uma
vez por dia. Se o personagem fracassar no teste de
conjurador, a criatura estará livre e destruirá o circulo.
Uma criatura capaz de qualquer forma de viagem
dimensional (projeção astral, piscar, porta dimensional,
forma etérea, portal, viagem planar, andar nas sombras,
teletransporte ou habilidades similares) simplesmente
sairá do circulo usando essa habilidade. O personagem
é capaz de impedir a fuga extra-dimensional da criatura
conjurando uma magia âncora dimensional nela, mas
deve fazê-lo antes da criatura agir. Se obtiver sucesso,
a âncora permanece ativa enquanto o circulo mágico
existir. A criatura não consegue atravessar o circulo
mágico, mas seus ataques à distância (armas de ataque á
distância, magias, habilidades mágicas, etc.) conseguem.
A criatura pode atacar qualquer alvo que alcançar com
seus ataques à distância, exceto o próprio circulo.
O personagem pode adicionar um diagrama
especial (uma figura de confinamento bidimensional
vários selos mágicos) para tornar o círculo mágico mais
seguro. Desenhar o diagrama exige 10 minutos e um
teste de identificar Magia (CD 20). O Mestre realiza
o teste secretamente. Se o teste fracassar, o diagrama
será ineficaz. Pode-se escolher 10 para elaborar o dia-
grama, caso o personagem não esteja sob nenhum tipo
de pressão devido ao tempo para completar a tarefa.
Nesse caso, o processo também gastara 10 minutos.
Se o tempo não é um fator importante, o personagem
pode escolher 20, mas perderá 3 horas e 20 minutos
para concluir a tarefa.
Se obtiver sucesso no diagrama, o personagem
será capaz de conjurar a magia âncora dimensional no
círculo mágico uma rodada antes de qualquer magia
de convocação. A âncora aprisionará qualquer criatura
convocada no círculo mágico durante 24 horas por nível
de conjurador. Uma criatura não pode usar sua RM
contra um circulo mágico preparado com um diagrama
e nenhuma de suas habilidades ou ataques são capazes
de atravessar o diagrama. Se a criatura realizar um
teste de Carisma para se libertar da armadilha (veja
a magia âncora planar menor), a CD aumenta em 5
pontos. A criatura é imediatamente liberada se algo
destruir o diagrama – mesmo uma folha seca que caia
sobre os desenhos. No entanto, a criatura não consegue
prejudicar o diagrama sozinha, direta ou indiretamen', 1, '', '[Bem]', '1 ação padrão', 'Toque', 'Área: Emanação de 3 metros de raio, centrada', '10 minutos/nível', 'Vontade anula (inofensiva)', 0, 1)
ON DUPLICATE KEY UPDATE 
    description='Todas as criaturas dentro da área recebem os efeitos
da magia proteção contra o mal e nenhuma criatura que
não seja Boa é capaz de invadir essa área. É preciso
superar a Resistência a Magia da criatura para isolá-
la (como a terceira função de proteção contra o mal),
mas os bônus de deflexão, a resistência e a proteção
ao controle mental são aplicados, independentes da
RM do inimigo.
Essa magia tem uma versão alternativa que o con-
jurador deve escolher ao conjurá-la. Um círculo mágico
contra o mal pode ser voltado para o interior em vez
de para o exterior. Nesse caso, a magia aprisiona uma
criatura convocada (pelas magias âncora planar menor,
âncora planar e âncora planar maior, por exemplo), que
não seja Boa, durante 24 horas por nível de conjurador,
supondo que a magia de convocação seja executada
dentro de 1 rodada da conjuração do circulo mágico. A
criatura é incapaz de atravessar o circulo que a aprisiona.
Se a criatura for muito grande para ser comportada na
área da magia, o efeito agirá como uma proteção contra
o mal somente contra a criatura convocada.
Um círculo mágico é ineficaz como uma armadilha.
Se o circulo de pó de prata for removido no processo,
a conjuração é neutralizada, o efeito termina imedia-
tamente. A criatura presa não pode lazer nada contra o
circulo, d ire ta ou indiretamente, mas outras criaturas
podem. Se a criatura convocada tiver Resistência a
Magia, ela pode tentar neutralizar a armadilha uma
vez por dia. Se o personagem fracassar no teste de
conjurador, a criatura estará livre e destruirá o circulo.
Uma criatura capaz de qualquer forma de viagem
dimensional (projeção astral, piscar, porta dimensional,
forma etérea, portal, viagem planar, andar nas sombras,
teletransporte ou habilidades similares) simplesmente
sairá do circulo usando essa habilidade. O personagem
é capaz de impedir a fuga extra-dimensional da criatura
conjurando uma magia âncora dimensional nela, mas
deve fazê-lo antes da criatura agir. Se obtiver sucesso,
a âncora permanece ativa enquanto o circulo mágico
existir. A criatura não consegue atravessar o circulo
mágico, mas seus ataques à distância (armas de ataque á
distância, magias, habilidades mágicas, etc.) conseguem.
A criatura pode atacar qualquer alvo que alcançar com
seus ataques à distância, exceto o próprio circulo.
O personagem pode adicionar um diagrama
especial (uma figura de confinamento bidimensional
vários selos mágicos) para tornar o círculo mágico mais
seguro. Desenhar o diagrama exige 10 minutos e um
teste de identificar Magia (CD 20). O Mestre realiza
o teste secretamente. Se o teste fracassar, o diagrama
será ineficaz. Pode-se escolher 10 para elaborar o dia-
grama, caso o personagem não esteja sob nenhum tipo
de pressão devido ao tempo para completar a tarefa.
Nesse caso, o processo também gastara 10 minutos.
Se o tempo não é um fator importante, o personagem
pode escolher 20, mas perderá 3 horas e 20 minutos
para concluir a tarefa.
Se obtiver sucesso no diagrama, o personagem
será capaz de conjurar a magia âncora dimensional no
círculo mágico uma rodada antes de qualquer magia
de convocação. A âncora aprisionará qualquer criatura
convocada no círculo mágico durante 24 horas por nível
de conjurador. Uma criatura não pode usar sua RM
contra um circulo mágico preparado com um diagrama
e nenhuma de suas habilidades ou ataques são capazes
de atravessar o diagrama. Se a criatura realizar um
teste de Carisma para se libertar da armadilha (veja
a magia âncora planar menor), a CD aumenta em 5
pontos. A criatura é imediatamente liberada se algo
destruir o diagrama – mesmo uma folha seca que caia
sobre os desenhos. No entanto, a criatura não consegue
prejudicar o diagrama sozinha, direta ou indiretamen', 
    school_id=1, 
    subschool='', 
    descriptors='[Bem]', 
    casting_time='1 ação padrão',
    range_text='Toque',
    area_target_effect_text='Área: Emanação de 3 metros de raio, centrada',
    duration='10 minutos/nível',
    saving_throw='Vontade anula (inofensiva)',
    spell_resistance=0;
        
DELETE FROM spell_component_requirements WHERE spell_id = (SELECT id FROM spells WHERE name='Círculo Mágico Contra o Mal');

INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Círculo Mágico Contra o Mal'), 1, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Círculo Mágico Contra o Mal'), 2, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Círculo Mágico Contra o Mal'), 3, '');


INSERT IGNORE INTO spell_component_requirements (spell_id, component_id, details)
VALUES ((SELECT id FROM spells WHERE name='Círculo Mágico Contra o Mal'), 5, '');

INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (3, (SELECT id FROM spells WHERE name='Círculo Mágico Contra o Mal'), 3);
INSERT IGNORE INTO domain_spells (domain_id, spell_id, spell_level) VALUES (4, (SELECT id FROM spells WHERE name='Círculo Mágico Contra o Mal'), 3);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (7, (SELECT id FROM spells WHERE name='Círculo Mágico Contra o Mal'), 3);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (10, (SELECT id FROM spells WHERE name='Círculo Mágico Contra o Mal'), 3);
INSERT IGNORE INTO class_spell_lists (class_id, spell_id, spell_level) VALUES (11, (SELECT id FROM spells WHERE name='Círculo Mágico Contra o Mal'), 3);
SET FOREIGN_KEY_CHECKS=1;