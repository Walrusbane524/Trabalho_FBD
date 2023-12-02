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
VALUES (1, 'Artist 1', 1);

-- Insert data into faixa table
INSERT INTO faixa (cod_musica, descricao, tempo_de_execucao, cod_tipo_composicao, tipo_gravacao, cod_gravadora, cod_album)
VALUES (1, 'Song 1', '00:04:30', 'Rock', 'Studio', 1, 1);

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
