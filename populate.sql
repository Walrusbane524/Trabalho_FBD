--Tabelas independentes: Gravadora, Periodo, Interprete, Playlist, Tipo de composição 

--Gravadora
INSERT INTO gravadora (cod_gravadora, Endereco_homepage, Endereco, nome)
VALUES
  (1, 'http://www.example1.com', '123 Main St', 'Record Company 1'),
  (2, 'http://www.example2.com', '456 Oak St', 'Music Producers Ltd'),
  (3, 'http://www.example3.com', '789 Pine St', 'Sound Studios'),
  (4, 'http://www.example4.com', '321 Elm St', 'Melody Creations'),
  (5, 'http://www.example5.com', '567 Birch St', 'Harmony Records'),
  (6, 'http://www.example6.com', '890 Cedar St', 'Rhythm Entertainment'),
  (7, 'http://www.example7.com', '765 Maple St', 'Symphony Productions'),
  (8, 'http://www.example8.com', '432 Fir St', 'Song Crafters'),
  (9, 'http://www.example9.com', '876 Pine St', 'Note Studios'),
  (10, 'http://www.example10.com', '543 Oak St', 'Tune Makers');

  

--Periodo
-- Insert data into periodo table
INSERT INTO periodo (cod_periodo, comeco, fim, descricao)
VALUES
  ('P1', '2000-01-01', '2010-12-31', 'First Decade'),
  ('P2', '2011-01-01', '2020-12-31', 'Second Decade'),
  ('P3', '2021-01-01', '2030-12-31', 'Third Decade'),
  ('P4', '2031-01-01', '2040-12-31', 'Fourth Decade'),
  ('P5', '2041-01-01', '2050-12-31', 'Fifth Decade'),
  ('P6', '2051-01-01', '2060-12-31', 'Singed Root'),
  ('P7', '2061-01-01', '2070-12-31', 'Seventh Decade'),
  ('P8', '2071-01-01', '2080-12-31', 'Eighth Decade'),
  ('P9', '2081-01-01', '2090-12-31', 'Ninth Decade'),
  ('P10', '2091-01-01', '2100-12-31', 'Tenth Decade');
--Interprete

-- Insert data into interprete table
INSERT INTO interprete (cod_interprete, nome, tipo)
VALUES
  (1, 'Singer 1', 'Vocalist'),
  (2, 'Guitarist 1', 'Instrumentalist'),
  (3, 'Pianist 1', 'Instrumentalist'),
  (4, 'Bassist 1', 'Instrumentalist'),
  (5, 'Drummer 1', 'Instrumentalist'),
  (6, 'Violinist 1', 'Instrumentalist'),
  (7, 'Cellist 1', 'Instrumentalist'),
  (8, 'Flutist 1', 'Instrumentalist'),
  (9, 'Saxophonist 1', 'Instrumentalist'),
  (10, 'Trumpeter 1', 'Instrumentalist');

--Playlists

-- Insert data into playlist table
INSERT INTO playlist (cod_playlist, nome, tempo_de_execucao_total, data_criacao)
VALUES
  (1, 'My Playlist 1', '01:30:00', '2023-05-01'),
  (2, 'Top Hits', '02:15:00', '2023-05-05'),
  (3, 'Chill Vibes', '01:00:00', '2023-05-10'),
  (4, 'Rock Classics', '03:30:00', '2023-05-15'),
  (5, 'Pop Party Mix', '01:45:00', '2023-05-20'),
  (6, 'Jazz Lounge', '02:00:00', '2023-05-25'),
  (7, 'Indie Favorites', '01:20:00', '2023-05-30'),
  (8, 'Electronic Beats', '01:45:00', '2023-06-01'),
  (9, 'Country Jams', '02:30:00', '2023-06-05'),
  (10, 'R&B Grooves', '01:15:00', '2023-06-10');


-- Insert data into tipo_de_composicao table
INSERT INTO tipo_de_composicao (cod_tipo_composicao, descricao)
VALUES
  ('Pop', 'Pop genre'),
  ('Rock', 'Rock genre'),
  ('Jazz', 'Jazz genre'),
  ('Electronic', 'Electronic genre'),
  ('Hip-Hop', 'Hip-Hop genre'),
  ('Classical', 'Classical genre'),
  ('Country', 'Country genre'),
  ('Blues', 'Blues genre'),
  ('R&B', 'Rhythm and Blues genre'),
  ('Indie', 'Indie genre');


INSERT INTO periodo (cod_periodo, comeco, fim, descricao)
VALUES ('Barroco', '1600-01-01', '1700-12-31', 'Estilo do século 17');

INSERT INTO tipo_de_composicao (cod_tipo_composicao, descricao)
VALUES ('Concerto', 'Concerto');

--Tabelas dependentes grau 1: Compositor, Album, Telefone

--Telefone

INSERT INTO telefone (numero, cod_gravadora)
VALUES
    ('5551111111', 1),
    ('5552222222', 2),
    ('5553333333', 3),
    ('5554444444', 4),
    ('5555555555', 5),
    ('5556666666', 6),
    ('5557777777', 7),
    ('5558888888', 8),
    ('5559999999', 9),
    ('5551010101', 10),
    ('5552020202', 1),
    ('5553030303', 2),
    ('5554040404', 3),
    ('5555050505', 4),
    ('5556060606', 5),
    ('5557070707', 6),
    ('5558080808', 7),
    ('5559090909', 8),
    ('5551231234', 9),
    ('5555675678', 10),
    ('5559876543', 1)

-- Insert data into compositor table
INSERT INTO compositor (cod_compositor, nome, data_de_nascimento, data_de_falecimento, local_nascimento, cod_periodo)
VALUES
  (1, 'John Songsmith', '1970-05-15', NULL, 'City1, Country1', 'P1'),
  (2, 'Emily Melodymaker', '1985-08-22', NULL, 'City2, Country2', 'P2'),
  (3, 'Michael Harmony', '1968-02-10', '2022-06-30', 'City3, Country3', 'P3'),
  (4, 'Sarah Composer', '1990-11-20', NULL, 'City4, Country4', 'P4'),
  (5, 'Daniel Tunebuilder', '1975-04-03', NULL, 'City5, Country5', 'P5'),
  (6, 'Laura Rhythmcraft', '1980-09-18', NULL, 'City6, Country6', 'P5'),
  (7, 'Alex Beatweaver', '1963-12-25', '2021-03-15', 'City7, Country7', 'P7'),
  (8, 'Olivia Noteartist', '1995-06-08', NULL, 'City8, Country8', 'P8'),
  (9, 'William Serenademaker', '1978-01-30', NULL, 'City9, Country9', 'P9'),
  (10, 'Eva Sonatacreator', '1987-07-12', NULL, 'City10, Country10', 'P10');

-- Insert data into album table
INSERT INTO album (cod_album, tipoCompra, preco, data_de_gravacao, data_da_compra, cod_gravadora)
VALUES
  (1, 'Digital', 19.99, '2023-05-01', '2023-05-10', 1),
  (2, 'CD', 24.99, '2023-05-02', '2023-05-12', 2),
  (3, 'Vinyl', 29.99, '2023-05-03', '2023-05-14', 3),
  (4, 'Digital', 21.99, '2023-05-04', '2023-05-16', 4),
  (5, 'CD', 26.99, '2023-05-05', '2023-05-18', 5),
  (6, 'Vinyl', 31.99, '2023-05-06', '2023-05-20', 6),
  (7, 'Digital', 23.99, '2023-05-07', '2023-05-22', 7),
  (8, 'CD', 28.99, '2023-05-08', '2023-05-24', 8),
  (9, 'Vinyl', 33.99, '2023-05-09', '2023-05-26', 9),
  (10, 'Digital', 25.99, '2023-05-10', '2023-05-28', 10);



INSERT INTO faixa (cod_musica, descricao, tempo_de_execucao, cod_tipo_composicao, tipo_gravacao, cod_album)
VALUES (4, 'Song 1', '00:04:30', 'Rock', 'DDD', 1);
INSERT INTO faixa (cod_musica, descricao, tempo_de_execucao, cod_tipo_composicao, tipo_gravacao, cod_album)
VALUES (6, 'Song 1', '00:04:30', 'Rock', 'DDD', 1);

INSERT INTO faixa (cod_musica, descricao, tempo_de_execucao, cod_tipo_composicao, tipo_gravacao, cod_album)
VALUES (17, 'Song 1', '00:04:30', 'Concerto', 'DDD', 1);
INSERT INTO faixa (cod_musica, descricao, tempo_de_execucao, cod_tipo_composicao, tipo_gravacao, cod_album)
VALUES (18, 'Song 1', '00:04:30', 'Concerto', 'DDD', 1);
INSERT INTO faixa (cod_musica, descricao, tempo_de_execucao, cod_tipo_composicao, tipo_gravacao, cod_album)
VALUES (19, 'Song 3', '00:14:30', 'Concerto', 'DDD', 1);


INSERT INTO compositor (cod_compositor, nome, data_de_nascimento, data_de_falecimento, local_nascimento, cod_periodo)
VALUES (17, 'Composer 2', '1600-01-01', '1700-01-01', 'City, Country', 'Barroco');

INSERT INTO compositor (cod_compositor, nome, data_de_nascimento, data_de_falecimento, local_nascimento, cod_periodo)
VALUES (18, 'Composer 2', '1600-01-01', '1700-01-01', 'City, Classico', 'Barroco');

--Tabelas dependentes grau 2: Midia Fisica, Faixa, tabelas de ligação...

-- Insert data into midiaFisica table
INSERT INTO midiaFisica (cod_meio, tipo, cod_album)
VALUES
  (1, 'CD', 1),
  (2, 'Vinyl', 2),
  (3, 'CD', 3),
  (4, 'Vinyl', 4),
  (5, 'CD', 5),
  (6, 'Vinyl', 6),
  (7, 'CD', 7),
  (8, 'Vinyl', 8),
  (9, 'CD', 9),
  (10, 'Vinyl', 10);

INSERT INTO faixa (cod_musica, descricao, tempo_de_execucao, cod_tipo_composicao, tipo_gravacao, cod_album)
VALUES
  (51, 'Track 51', '00:03:45', 'Pop', null, 1),
  (52, 'Track 52', '00:04:30', 'Rock', 'DDD', 2),
  (53, 'Track 53', '00:02:15', 'Jazz', null, 3),
  (54, 'Track 54', '00:03:20', 'Electronic', 'DDD', 4),
  (55, 'Track 55', '00:04:10', 'Hip-Hop', null, 5),
  (56, 'Track 56', '00:02:45', 'Classical', 'ADD', 6),
  (57, 'Track 57', '00:03:30', 'Country', null, 7),
  (58, 'Track 58', '00:04:00', 'Blues', 'DDD', 8),
  (59, 'Track 59', '00:03:15', 'R&B', null, 9),
  (60, 'Track 60', '00:02:50', 'Indie', 'ADD',  10),
  (61, 'Track 61', '00:03:40', 'Pop', null, 1),
  (62, 'Track 62', '00:04:25', 'Rock', 'DDD', 2),
  (63, 'Track 63', '00:02:10', 'Jazz', null, 3),
  (64, 'Track 64', '00:03:15', 'Electronic', 'DDD', 4),
  (65, 'Track 65', '00:04:05', 'Hip-Hop', null, 5),
  (66, 'Track 66', '00:02:40', 'Classical', 'ADD', 6),
  (67, 'Track 67', '00:03:25', 'Country', null, 7),
  (68, 'Track 68', '00:03:55', 'Blues', 'DDD', 8),
  (69, 'Track 69', '00:03:10', 'R&B', null, 9),
  (70, 'Track 70', '00:02:45', 'Indie', 'ADD',  10);

-- Insert data into musica_playlist table with cod_musica values from 50 to 70
-- Insert data into musica_playlist table with cod_musica values from 50 to 70 and cod_playlist values looping from 1 to 10
-- Insert data into musica_playlist table with cod_musica values from 50 to 70 and cod_playlist values looping from 1 to 10
INSERT INTO musica_playlist (cod_musica, cod_playlist, numero_de_vezes_tocada, ultima_vez_tocada)
VALUES
  (70, 1, 5, '2023-07-11'),
  (69, 2, 8, '2023-07-08'),
  (68, 3, 10, '2023-07-05'),
  (67, 4, 6, '2023-07-02'),
  (66, 5, 4, '2023-06-29'),
  (65, 6, 7, '2023-06-26'),
  (64, 7, 9, '2023-06-23'),
  (63, 8, 3, '2023-06-20'),
  (62, 9, 8, '2023-06-17'),
  (61, 10, 11, '2023-06-14'),
  (60, 1, 6, '2023-06-11'),
  (59, 2, 5, '2023-06-08'),
  (58, 3, 9, '2023-06-06'),
  (57, 4, 4, '2023-06-03'),
  (56, 5, 7, '2023-06-01'),
  (55, 6, 12, '2023-05-28'),
  (54, 7, 6, '2023-05-25'),
  (53, 8, 10, '2023-05-22'),
  (52, 9, 3, '2023-05-20'),
  (51, 10, 8, '2023-05-17')

INSERT INTO midia_musica (cod_musica, cod_meio, numeroFaixa)
VALUES
  (70, 1, 1),
  (69, 2, 2),
  (68, 3, 3),
  (67, 4, 4),
  (66, 5, 5),
  (65, 6, 6),
  (64, 7, 7),
  (63, 8, 8),
  (62, 9, 9),
  (61, 10, 10),
  (60, 1, 1),
  (59, 2, 2),
  (58, 3, 3),
  (57, 4, 4),
  (56, 5, 5),
  (55, 6, 6),
  (54, 7, 7),
  (53, 8, 8),
  (52, 9, 9),
  (51, 10, 10)
  

  -- Insert data into musica_playlist table with cod_musica values from 70 to 50 and unique cod_playlist values
INSERT INTO interprete_musica (cod_musica, cod_interprete)
VALUES
  (70, 1),
  (69, 2),
  (68, 3),
  (67, 4),
  (66, 5),
  (65, 6),
  (64, 7),
  (63, 8),
  (62, 9),
  (61, 10),
  (60, 1),
  (59, 2),
  (58, 3),
  (57, 4),
  (56, 5),
  (55, 6),
  (54, 7),
  (53, 8),
  (52, 9),
  (51, 10)

  -- Insert data into midia_musica table with cod_musica values from 50 to 70 and cod_meio values looping from 1 to 10
-- Insert data into midia_musica table with cod_musica values from 70 to 50 and unique cod_meio values
INSERT INTO compositor_musica (cod_musica, cod_compositor)
VALUES
  (70, 1),
  (69, 2),
  (68, 3),
  (67, 4),
  (66, 5),
  (65, 6),
  (64, 7),
  (63, 8),
  (62, 9),
  (61, 10),
  (60, 1),
  (59, 2),
  (58, 3),
  (57, 4),
  (56, 5),
  (55, 6),
  (54, 7),
  (53, 8),
  (52, 9),
  (51, 10)

INSERT INTO musica_playlist (cod_musica, cod_playlist, numero_de_vezes_tocada, ultima_vez_tocada)
VALUES (19, 4, 12, '2023-04-15');


--Playlist só barroco classico

INSERT INTO playlist (cod_playlist, nome, tempo_de_execucao_total, data_criacao)
VALUES (24, 'Playlist classica', '01:15:00', '2023-03-10');

INSERT INTO musica_playlist (cod_musica, cod_playlist, numero_de_vezes_tocada, ultima_vez_tocada)
VALUES (17, 24, 12, '2023-04-15');
INSERT INTO musica_playlist (cod_musica, cod_playlist, numero_de_vezes_tocada, ultima_vez_tocada)
VALUES (18, 24, 12, '2023-04-15');

INSERT INTO compositor_musica (cod_musica, cod_compositor)
VALUES (17, 17);
INSERT INTO compositor_musica (cod_musica, cod_compositor)
VALUES (18, 18);


INSERT INTO faixa (cod_musica, descricao, tempo_de_execucao, cod_tipo_composicao, tipo_gravacao, cod_album)
VALUES (21, 'Song 5', '00:24:30', 'Concerto', 'DDD', 1);

INSERT INTO musica_playlist (cod_musica, cod_playlist, numero_de_vezes_tocada, ultima_vez_tocada)
VALUES (21, 24, 12, '2023-04-15');
-- USE master;
-- GO
-- ALTER DATABASE BDSpotPer 
-- SET SINGLE_USER 
-- WITH ROLLBACK IMMEDIATE;
-- GO
-- DROP DATABASE BDSpotPer;