CREATE DATABASE BDSpotPer
ON PRIMARY
(NAME = 'BDSpotPer_Primary',
    FILENAME = 'C:\Caminho\Para\Arquivos\BDSpotPer_Primary.mdf',
    SIZE = 100MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 10MB),
FILEGROUP BDSpotPer_Secondary1
(NAME = 'BDSpotPer_Secondary1_1',
    FILENAME = 'C:\Caminho\Para\Arquivos\BDSpotPer_Secondary1_1.ndf',
    SIZE = 50MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 5MB),
(NAME = 'BDSpotPer_Secondary1_2',
    FILENAME = 'C:\Caminho\Para\Arquivos\BDSpotPer_Secondary1_2.ndf',
    SIZE = 50MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 5MB),
FILEGROUP BDSpotPer_Secondary2
(NAME = 'BDSpotPer_Secondary2_1',
    FILENAME = 'C:\Caminho\Para\Arquivos\BDSpotPer_Secondary2_1.ndf',
    SIZE = 100MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 10MB),
LOG ON
(NAME = 'BDSpotPer_Log',
    FILENAME = 'C:\Caminho\Para\Arquivos\BDSpotPer_Log.ldf',
    SIZE = 50MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 10MB);

-- Definir o filegroup padrão para objetos
ALTER DATABASE BDSpotPer
MODIFY FILEGROUP BDSpotPer_Secondary2 DEFAULT;

-- Criar tabelas
USE BDSpotPer;

-- Tabelas alocadas no filegroup com dois arquivos
CREATE TABLE Playlist (
    PlaylistID INT PRIMARY KEY,
    Name NVARCHAR(255)
) ON BDSpotPer_Secondary2;

-- Outras tabelas alocadas no filegroup com dois arquivos

-- Tabelas alocadas no filegroup com um arquivo
CREATE TABLE Track (
    TrackID INT PRIMARY KEY,
    Title NVARCHAR(255),
    AlbumID INT FOREIGN KEY REFERENCES Album(AlbumID)
) ON BDSpotPer_Secondary1;

CREATE TABLE PlaylistTrack (
    PlaylistID INT FOREIGN KEY REFERENCES Playlist(PlaylistID),
    TrackID INT FOREIGN KEY REFERENCES Track(TrackID),
    PRIMARY KEY (PlaylistID, TrackID)
) ON BDSpotPer_Secondary1;



create table gravadora(
    cod_gravadora int primary key,
    Endereco_homepage varchar(255),
    Endereco varchar(255),
    nome varchar(255)
)

create table album(
    cod_album int primary key,
    tipo int, 
    preco decimal(10,2),
    data_de_gravacao date,
    data_da_compra date,
    cod_gravadora foreign key references gravadora(cod_gravadora)
)

create table midiaFisica(
    cod_meio int primary key,
    tipo int,
    cod_album foreign key references album(cod_album)
)

create table midia_musica(
    cod_meio foreign key references midiaFisica(cod_meio),
    cod_musica foreign key references faixa(cod_musica),
    tipo_gravacao int,
    numeroFaixa int
)

create table telefones(
    cod_telefone int primary key,
    telefone int

)

create table tipo_de_composicao(
    descricao varchar(255),
    cod_tipo_composicao int
)

create table interprete(
    cod_interprete int primary key,
    nome varchar(255),
    tipo int
)

create table interprete_musica(
    cod_interprete foreign key references interprete(cod_interprete),
    ocd_musica foreign key references faixa(cod_musica)
)

create table faixa(
    descricao varchar(255),
    tempo_de_execucao time,
    cod_musica int primary key,
    cod_tipo_composicao foreign key references tipo_de_composicao(cod_tipo_composicao)
    cod_gravadora foreign key references gravadora(cod_gravadora),

)

create table compositor_musica(
    cod_musica foreign key references faixa(cod_musica),
    cod_compositor foreign key references compositor(cod_compositor)
)

create table compositor(
    cod_compositor primary key,
    nome char(255),
    data_de_nascimento date,
    data_de_falecimento date,
    local_nascimento char(255),
    cod_periodo foreign key references periodo(cod_periodo)
)

create table periodo(
    cod_periodo primary key,
    comeco date,
    fim date,
    descricao varchar(255)
)

create table musica_playlist(
    cod_musica foreign key references faixa(cod_musica),
    cod_playlist foreign key references playlist(cod_playlist),
    numero_de_vezes_tocada int,
    ultima_vez_tocada date
)

create table playlist(
    cod_playlist primary key,
    nome char(255),
    tempo_de_execucao_total time,
    data_criacao date
    cod_usuario foreign key references usuario(cod_usuario)
)

create table usuario(
    cod_usuario primary key
)



--Terceira condição:


ALTER TABLE Album
ADD CONSTRAINT CK_Album_PeriodoBarroco
CHECK (Periodo = 'Barroco' AND TipoGravacao = 'DDD');

ALTER TABLE Album
ADD CONSTRAINT CK_Album_MaxFaixas
CHECK (NOT EXISTS (SELECT 1 FROM Faixa WHERE AlbumID = Album.AlbumID GROUP BY AlbumID HAVING COUNT(*) > 64));

ALTER TABLE Faixa
ADD CONSTRAINT FK_Faixa_Album
FOREIGN KEY (AlbumID)
REFERENCES Album(AlbumID)
ON DELETE CASCADE;

ALTER TABLE Album
ADD CONSTRAINT CK_Album_PrecoCompra
CHECK (PrecoCompra <= 3 * (SELECT AVG(PrecoCompra) FROM Album WHERE AlbumID IN (SELECT DISTINCT AlbumID FROM Faixa WHERE TipoGravacao = 'DDD')));


--Quarta condição

CREATE UNIQUE CLUSTERED INDEX IX_Faixa_CodigoAlbum
ON Faixa(CodigoAlbum)
WITH FILLFACTOR = 100;


CREATE NONCLUSTERED INDEX IX_Faixa_TipoComposicao
ON Faixa(TipoComposicao)
WITH FILLFACTOR = 100;


--Quinta condição

-- Criar a visão materializada
CREATE VIEW PlaylistAlbumCountView
WITH SCHEMABINDING
AS
SELECT
    p.Name AS PlaylistName,
    COUNT(DISTINCT a.AlbumID) AS AlbumCount
FROM
    dbo.Playlist p
JOIN
    dbo.PlaylistTrack pt ON p.PlaylistID = pt.PlaylistID
JOIN
    dbo.Track t ON pt.TrackID = t.TrackID
JOIN
    dbo.Album a ON t.AlbumID = a.AlbumID
GROUP BY
    p.Name;

-- Criar a indexação na visão materializada
CREATE UNIQUE CLUSTERED INDEX IX_PlaylistAlbumCountView
ON PlaylistAlbumCountView(PlaylistName);


--Sexta condição:

-- Criar a função
CREATE FUNCTION ObterAlbumsPorCompositor
(
    @NomeCompositor NVARCHAR(255)
)
RETURNS TABLE
AS
RETURN
(
    SELECT DISTINCT
        a.AlbumID,
        a.Nome AS AlbumNome,
        a.Artista,
        a.AnoLancamento
    FROM
        Album a
    JOIN
        Faixa f ON a.AlbumID = f.AlbumID
    WHERE
        f.Compositor LIKE '%' + @NomeCompositor + '%'
);
