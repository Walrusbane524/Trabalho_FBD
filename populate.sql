--Inserções
insert into gravadora values(1, 'www.nuclearRecords.com.com.com.com.br', 'Suécia', 'NuclearRecords');
insert into album values(1, 1, 200.84, '2001-03-12', '2003-04-09', 1);

-- Insert data into midiaFisica
INSERT INTO midiaFisica VALUES (1, 'CD', 1);
-- Insert data into telefones
INSERT INTO telefones VALUES (1, 123456789);
-- Insert data into tipo_de_composicao
INSERT INTO tipo_de_composicao VALUES ('Rock', 1);
-- Insert data into interprete
INSERT INTO interprete VALUES (1, 'Interprete1', 1);
-- Insert data into faixa
INSERT INTO faixa VALUES ('Faixa1', '00:03:30', 1, 1, 1, 'Estúdio', 1);
-- Insert data into interprete_musica
INSERT INTO interprete_musica VALUES (1, 1);
-- Insert data into midia_musica
INSERT INTO midia_musica VALUES (1, 1, 1);
-- Insert data into periodo
INSERT INTO periodo VALUES ('Periodo1', '2000-01-01', '2023-12-31', 'Descrição do Periodo');
-- Insert data into compositor
INSERT INTO compositor VALUES (1, 'Compositor1', '1980-01-01', '2022-12-31', 'LocalNascimento', 'Periodo1');
-- Insert data into compositor_musica
INSERT INTO compositor_musica VALUES (1, 1);
-- Insert data into playlist
INSERT INTO playlist VALUES (1, 'Playlist1', '00:30:00', '2023-01-01');
-- Insert data into musica_playlist
INSERT INTO musica_playlist VALUES (1, 1, 5, '2023-01-15');
-- Insert data into gravadora
INSERT INTO gravadora VALUES (101, 'www.innovativeRecords.com', 'Innovative Street 123', 'Innovative Records');
-- Insert data into album
INSERT INTO album VALUES (201, 2, 39.99, '2023-02-20', '2023-02-25', 101);
-- Insert data into midiaFisica
INSERT INTO midiaFisica VALUES (301, 'Vinyl', 201);
-- Insert data into telefones
INSERT INTO telefones VALUES (401, 987654321);
-- Insert data into tipo_de_composicao
INSERT INTO tipo_de_composicao VALUES ('Jazz', 301);
-- Insert data into interprete
INSERT INTO interprete VALUES (501, 'Innovative Artist', 2);
-- Insert data into faixa
INSERT INTO faixa VALUES ('Track of Innovation', '00:05:45', 301, 301, 101, 'Live', 201);
-- Insert data into interprete_musica
INSERT INTO interprete_musica VALUES (502, 301);
-- Insert data into midia_musica
INSERT INTO midia_musica VALUES (303, 301, 2);
-- Insert data into periodo
INSERT INTO periodo VALUES ('Period of Innovation', '2005-01-01', '2023-12-31', 'A period of groundbreaking music');
-- Insert data into compositor
INSERT INTO compositor VALUES (503, 'Innovative Composer', '1985-03-15', NULL, 'Birthplace City', 'Period of Innovation');
-- Insert data into compositor_musica
INSERT INTO compositor_musica VALUES (502, 503);
-- Insert data into playlist
INSERT INTO playlist VALUES (701, 'Innovative Playlist', '01:15:00', '2023-02-01');
-- Insert data into musica_playlist
INSERT INTO musica_playlist VALUES (502, 701, 10, '2023-02-15');
