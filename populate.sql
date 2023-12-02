-- Insert data into gravadora table
INSERT INTO gravadora (cod_gravadora, Endereco_homepage, Endereco, nome)
VALUES (1, 'http://example.com', '123 Main St', 'Record Company 1');

-- Insert data into album table
INSERT INTO album (cod_album, tipoCompra, preco, data_de_gravacao, data_da_compra, cod_gravadora)
VALUES (1, 'Physical', 19.99, '2023-01-15', '2023-02-01', 1);

-- Insert data into midiaFisica table
INSERT INTO midiaFisica (cod_meio, tipo, cod_album)
VALUES (1, 'CD', 1);

-- Insert data into telefones table
INSERT INTO telefones (cod_telefone, telefone)
VALUES (1, 1234567890);

-- Insert data into tipo_de_composicao table
INSERT INTO tipo_de_composicao (cod_tipo_composicao, descricao)
VALUES ('Rock', 'Rock genre');

-- Insert data into interprete table
INSERT INTO interprete (cod_interprete, nome, tipo)
VALUES (1, 'Artist 1', 'Soprano');

-- Insert data into faixa table
INSERT INTO faixa (cod_musica, descricao, tempo_de_execucao, cod_tipo_composicao, tipo_gravacao, cod_gravadora, cod_album)
VALUES (1, 'Song 1', '00:04:30', 'Rock', 'DDD', 1, 1);

-- Insert data into interprete_musica table
INSERT INTO interprete_musica (cod_interprete, cod_musica)
VALUES (1, 1);

-- Insert data into midia_musica table
INSERT INTO midia_musica (cod_meio, cod_musica, numeroFaixa)
VALUES (1, 1, 1);

-- Insert data into periodo table
INSERT INTO periodo (cod_periodo, comeco, fim, descricao)
VALUES ('1900-2000', '1900-01-01', '2000-12-31', '20th Century');

-- Insert data into compositor table
INSERT INTO compositor (cod_compositor, nome, data_de_nascimento, data_de_falecimento, local_nascimento, cod_periodo)
VALUES (1, 'Composer 1', '1850-01-01', '1920-05-15', 'City, Country', '1900-2000');

-- Insert data into compositor_musica table
INSERT INTO compositor_musica (cod_musica, cod_compositor)
VALUES (1, 1);

-- Insert data into playlist table
INSERT INTO playlist (cod_playlist, nome, tempo_de_execucao_total, data_criacao)
VALUES (1, 'My Playlist', '01:30:00', '2023-03-01');

-- Insert data into musica_playlist table
INSERT INTO musica_playlist (cod_musica, cod_playlist, numero_de_vezes_tocada, ultima_vez_tocada)
VALUES (1, 1, 5, '2023-03-15');


-- Insert data into gravadora table
INSERT INTO gravadora (cod_gravadora, Endereco_homepage, Endereco, nome)
VALUES (2, 'http://musiccompany.com', '456 Oak St', 'Sound Records');

-- Insert data into album table
INSERT INTO album (cod_album, tipoCompra, preco, data_de_gravacao, data_da_compra, cod_gravadora)
VALUES (2, 'Digital', 12.99, '2023-02-20', '2023-03-05', 2);

-- Insert data into midiaFisica table
INSERT INTO midiaFisica (cod_meio, tipo, cod_album)
VALUES (2, 'Vinyl', 2);

-- Insert data into telefones table
INSERT INTO telefones (cod_telefone, telefone)
VALUES (2, 9876543210);

-- Insert data into tipo_de_composicao table
INSERT INTO tipo_de_composicao (cod_tipo_composicao, descricao)
VALUES ('Pop', 'Pop genre');

-- Insert data into interprete table
INSERT INTO interprete (cod_interprete, nome, tipo)
VALUES (2, 'Singer 2', 'Orquestra');

-- Insert data into faixa table
INSERT INTO faixa (cod_musica, descricao, tempo_de_execucao, cod_tipo_composicao, tipo_gravacao, cod_gravadora, cod_album)
VALUES (2, 'Track 2', '00:03:45', 'Pop', 'Live', 2, 2);

-- Insert data into interprete_musica table
INSERT INTO interprete_musica (cod_interprete, cod_musica)
VALUES (2, 2);

-- Insert data into midia_musica table
INSERT INTO midia_musica (cod_meio, cod_musica, numeroFaixa)
VALUES (2, 2, 1);

-- Insert data into periodo table
INSERT INTO periodo (cod_periodo, comeco, fim, descricao)
VALUES ('2000-2020', '2000-01-01', '2020-12-31', '21st Century');

-- Insert data into compositor table
INSERT INTO compositor (cod_compositor, nome, data_de_nascimento, data_de_falecimento, local_nascimento, cod_periodo)
VALUES (2, 'Songwriter 2', '1960-03-10', 'Alive', 'City2, Country2', '2000-2020');

-- Insert data into compositor_musica table
INSERT INTO compositor_musica (cod_musica, cod_compositor)
VALUES (2, 2);

-- Insert data into playlist table
INSERT INTO playlist (cod_playlist, nome, tempo_de_execucao_total, data_criacao)
VALUES (2, 'My Playlist 2', '01:15:00', '2023-03-10');

-- Insert data into musica_playlist table
INSERT INTO musica_playlist (cod_musica, cod_playlist, numero_de_vezes_tocada, ultima_vez_tocada)
VALUES (2, 2, 8, '2023-03-20');


-- Insert data into gravadora table
INSERT INTO gravadora (cod_gravadora, Endereco_homepage, Endereco, nome)
VALUES (3, 'http://swedishrecords.se', '789 Pine St', 'Ljud Inspelningar AB');

-- Insert data into album table
INSERT INTO album (cod_album, tipoCompra, preco, data_de_gravacao, data_da_compra, cod_gravadora)
VALUES (3, 'Digital', 24.99, '2023-04-10', '2023-04-25', 3);

-- Insert data into midiaFisica table
INSERT INTO midiaFisica (cod_meio, tipo, cod_album)
VALUES (3, 'CD', 3);

-- Insert data into telefones table
INSERT INTO telefones (cod_telefone, telefone)
VALUES (3, 1122334455);

-- Insert data into tipo_de_composicao table
INSERT INTO tipo_de_composicao (cod_tipo_composicao, descricao)
VALUES ('Electronic', 'Electronic genre');

-- Insert data into interprete table
INSERT INTO interprete (cod_interprete, nome, tipo)
VALUES (3, 'Artist 3', 'Orquestra');

-- Insert data into faixa table
INSERT INTO faixa (cod_musica, descricao, tempo_de_execucao, cod_tipo_composicao, tipo_gravacao, cod_gravadora, cod_album)
VALUES (3, 'Sång 3', '00:05:15', 'Electronic', 'Studio', 3, 3);

-- Insert data into interprete_musica table
INSERT INTO interprete_musica (cod_interprete, cod_musica)
VALUES (3, 3);

-- Insert data into midia_musica table
INSERT INTO midia_musica (cod_meio, cod_musica, numeroFaixa)
VALUES (3, 3, 1);

-- Insert data into periodo table
INSERT INTO periodo (cod_periodo, comeco, fim, descricao)
VALUES ('2020-2050', '2020-01-01', '2050-12-31', '21st Century');

-- Insert data into compositor table
INSERT INTO compositor (cod_compositor, nome, data_de_nascimento, data_de_falecimento, local_nascimento, cod_periodo)
VALUES (3, 'Kompositör 3', '1975-06-20', NULL, 'Stad3, Land3', '2020-2050');

-- Insert data into compositor_musica table
INSERT INTO compositor_musica (cod_musica, cod_compositor)
VALUES (3, 3);

-- Insert data into playlist table
INSERT INTO playlist (cod_playlist, nome, tempo_de_execucao_total, data_criacao)
VALUES (3, 'Min Spellista 3', '01:45:00', '2023-04-01');

-- Insert data into musica_playlist table
INSERT INTO musica_playlist (cod_musica, cod_playlist, numero_de_vezes_tocada, ultima_vez_tocada)
VALUES (3, 3, 12, '2023-04-15');


--Tabelas independentes: Gravadora, Periodo, Interprete, Playlist, Tipo de composição 
INSERT INTO periodo (cod_periodo, comeco, fim, descricao)
VALUES ('Barroco', '1600-01-01', '1700-12-31', 'Estilo do século 17');

INSERT INTO tipo_de_composicao (cod_tipo_composicao, descricao)
VALUES ('Conserto', 'Conserto');

--Tabelas dependentes grau 1: Compositor, Album, Telefones
INSERT INTO faixa (cod_musica, descricao, tempo_de_execucao, cod_tipo_composicao, tipo_gravacao, cod_gravadora, cod_album)
VALUES (4, 'Song 1', '00:04:30', 'Rock', 'DDD', 1, 1);
INSERT INTO faixa (cod_musica, descricao, tempo_de_execucao, cod_tipo_composicao, tipo_gravacao, cod_gravadora, cod_album)
VALUES (6, 'Song 1', '00:04:30', 'Rock', 'DDD', 1, 1);

INSERT INTO faixa (cod_musica, descricao, tempo_de_execucao, cod_tipo_composicao, tipo_gravacao, cod_gravadora, cod_album)
VALUES (17, 'Song 1', '00:04:30', 'Conserto', 'DDD', 1, 1);
INSERT INTO faixa (cod_musica, descricao, tempo_de_execucao, cod_tipo_composicao, tipo_gravacao, cod_gravadora, cod_album)
VALUES (18, 'Song 1', '00:04:30', 'Conserto', 'DDD', 1, 1);


INSERT INTO compositor (cod_compositor, nome, data_de_nascimento, data_de_falecimento, local_nascimento, cod_periodo)
VALUES (7, 'Composer 2', '1600-01-01', '1700-01-01', 'City, Country', 'Barroco');

INSERT INTO compositor (cod_compositor, nome, data_de_nascimento, data_de_falecimento, local_nascimento, cod_periodo)
VALUES (8, 'Composer 2', '1600-01-01', '1700-01-01', 'City, Classico', 'Barroco');

--Tabelas dependentes grau 2: Midia Fisica, Faixa, tabelas de ligação...

INSERT INTO musica_playlist (cod_musica, cod_playlist, numero_de_vezes_tocada, ultima_vez_tocada)
VALUES (17, 4, 12, '2023-04-15');
INSERT INTO musica_playlist (cod_musica, cod_playlist, numero_de_vezes_tocada, ultima_vez_tocada)
VALUES (18, 4, 12, '2023-04-15');




--Playlist só barroco classico

INSERT INTO playlist (cod_playlist, nome, tempo_de_execucao_total, data_criacao)
VALUES (4, 'Playlist classica', '01:15:00', '2023-03-10');

INSERT INTO compositor_musica (cod_musica, cod_compositor)
VALUES (17, 7);
INSERT INTO compositor_musica (cod_musica, cod_compositor)
VALUES (18, 8);
