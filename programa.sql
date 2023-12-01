CREATE DATABASE BDSpotPer
ON PRIMARY
(NAME = 'BDSpotPer_Primary',
    FILENAME = 'C:\Caminho\Para\Arquivos\BDSpotPer_Primary.mdf',
    SIZE = 100MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 10MB),
FILEGROUP secundario
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
FILEGROUP terciario
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
MODIFY FILEGROUP secundario DEFAULT;

-- Criar tabelas
USE BDSpotPer;

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
    data_de_gravacao date, --Posterior a 2000
    data_da_compra date,
    cod_gravadora foreign key references gravadora(cod_gravadora)

    constraint dataDepois2000 check (data_de_gravacao > '2000-01-01')
)

create table midiaFisica(
    cod_meio int primary key,
    tipo char(20),
    cod_album int,

    --tem um trigger para lidar com o caso de ser cd ou vinil e poder adicionar vários
    
    --Quando o album é deletado, a midia física também é
    foreign key(cod_album) references album(cod_album) on delete cascade
)

create table midia_musica(
    cod_meio int,
    cod_musica int,
    numeroFaixa int

    foreign key(cod_meio)   references midiaFisica(cod_meio),
    foreign key(cod_musica) references faixa(cod_musica) on delete cascade
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
    cod_tipo_composicao int,
    cod_gravadora int,
    tipo_gravacao char(10),
    cod_album int

    foreign key(cod_tipo_composicao) references tipo_de_composicao(cod_tipo_composicao)
    foreign key(cod_gravadora)       references gravadora(cod_gravadora)
    foreign key(cod_album)           references album(cod_album) on delete cascade --Quando deletar o album deleta as suas faixas

) on terciario

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
    cod_periodo varchar(255) primary key,
    comeco date,
    fim date,
    descricao varchar(255)
)

create table musica_playlist(
    cod_musica foreign key references faixa(cod_musica),
    cod_playlist foreign key references playlist(cod_playlist),
    numero_de_vezes_tocada int,
    ultima_vez_tocada date
) on terciario

create table playlist(
    cod_playlist primary key,
    nome char(255),
    tempo_de_execucao_total time,
    data_criacao date
    cod_usuario int,

    foreign key(cod_usuario) references faixa(cod_musica)
) on terciario

create table usuario(
    cod_usuario primary key
)



--Terceira condição:

alter table album 
add constraint tipoDaGravacaoBarroco
check (cod_periodo = "Barroco" or not ("DDD" in (select tipo_gravacao from midia_musica m where m.cod_musica = cod_musica)))
add constraint numeroMaximo
check (
    not exists (
        select 1 
        from faixa
        inner join midia_musica on cod_musica
        inner join midia_fisica on cod_meio
        where cod_album = album.cod_album  --faixas com esse album
        group by cod_album  -- agrega elas pelo codigo do album
        having COUNT(*) > 64 -- vê se a quantidade de faixas desse album não excede 64
    )
)
add constraint precoJusto
check (preco <= 3 * (
    select avg(preco) 
    from album 
    where cod_album 
    in (
        select distinct cod_album 
        from faixa 
        where tipo_gravacao = 'DDD')
    )
);

create trigger CdVinilDownload on midiaFisica
before insert, update
as
begin
    --Se já existir um meio físico para esse album e ele for download
    --então ele não permite adicionar
    --Caso ele seja cd ou vinil, permite somente se for o mesmo tipo
    if exists (
        select * from midiaFisica 
        where cod_album = inserted.cod_album and (tipo = "download" or tipo != inserted.tipo)
    )
    begin
        RAISEERROR('Inserção falha, meio físico incompativel');
        rollback;
    end
end;

create trigger deletarMeioFisico on faixa
before delete
as
begin
    --Se o meio dessa musica que foi deletada tiver apenas ela como musica
    --Deletar esse meio
    delete from midiaFisica 
    where cod_meio in

    (select cod_meio from midiaFisica 
    inner join midia_musica on cod_meio
    where cod_musica = deleted.cod_musica and count(*) = 1
    group by cod_meio)
    
end;

create trigger tipoGravacao on midia_musica
before insert, update
as
begin

    declare @meio char(10);
    declare @gravacao char(10) = null;

    select @meio = tipo 
    from midia_fisica 
    where cod_meio = inserted.cod_meio

    select @gravacao = tipo_gravacao 
    from faixa
    where cod_musica = inserted.cod_musica

    --Se o tipo for cd e não tiver gravação dá erro
    --Se o tipo não for cd e tiver gravação dá erro
    if ((tipo = "CD" and gravacao is null) or (gravacao is not null))
    begin
        RAISEERROR('Falha, tipo de gravação e meio físico incompatíveis');
        rollback;
    end
    
end;

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
