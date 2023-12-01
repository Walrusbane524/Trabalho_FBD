CREATE DATABASE BDSpotPer
ON PRIMARY
(NAME = 'primarioUm',
    FILENAME = 'C:\Nova pasta\Trabalho_FBD\database\primarioUm.mdf',
    SIZE = 5MB,
    MAXSIZE = 10MB,
    FILEGROWTH = 100%),
FILEGROUP secundario
(NAME = 'secundarioUm',
    FILENAME = 'C:\Nova pasta\Trabalho_FBD\database\secundarioUm.ndf',
    SIZE = 1MB,
    MAXSIZE = 10MB,
    FILEGROWTH = 100%),
(NAME = 'secundarioDois',
    FILENAME = 'C:\Nova pasta\Trabalho_FBD\database\secundarioDois.ndf',
    SIZE = 1MB,
    MAXSIZE = 10MB,
    FILEGROWTH = 100%),
FILEGROUP terciario
(NAME = 'terciario',
    FILENAME = 'C:\Nova pasta\Trabalho_FBD\database\terciario.ndf',
    SIZE = 1MB,
    MAXSIZE = 10MB,
    FILEGROWTH = 100%)
LOG ON
(NAME = 'Log',
    FILENAME = 'C:\Nova pasta\Trabalho_FBD\database\Log.ldf',
    SIZE = 1MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 100%)

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
    cod_gravadora int

	foreign key(cod_gravadora) references gravadora(cod_gravadora)

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

create table telefones(
    cod_telefone int primary key,
    telefone int

)

create table tipo_de_composicao(
    descricao varchar(255),
    cod_tipo_composicao int primary key
)

create table interprete(
    cod_interprete int primary key,
    nome varchar(255),
    tipo int
)

create table faixa(
    descricao varchar(255),
    tempo_de_execucao time,
    cod_musica int primary key,
    cod_tipo_composicao int,
    cod_gravadora int,
    tipo_gravacao char(10),
    cod_album int

    foreign key(cod_tipo_composicao) references tipo_de_composicao(cod_tipo_composicao),
    foreign key(cod_gravadora)       references gravadora(cod_gravadora),
    foreign key(cod_album)           references album(cod_album) on delete cascade --Quando deletar o album deleta as suas faixas

) on terciario


create table interprete_musica(
    cod_interprete int, 
    cod_musica int ,

	foreign key(cod_interprete) references interprete(cod_interprete),
	foreign key(cod_musica) references faixa(cod_musica)
)


create table midia_musica(
    cod_meio int,
    cod_musica int,
    numeroFaixa int

    foreign key(cod_meio)   references midiaFisica(cod_meio),
    foreign key(cod_musica) references faixa(cod_musica) on delete cascade
)


create table periodo(
    cod_periodo varchar(255) primary key,
    comeco date,
    fim date,
    descricao varchar(255)
)

create table compositor(
    cod_compositor int primary key,
    nome char(255),
    data_de_nascimento date,
    data_de_falecimento date,
    local_nascimento char(255),
    cod_periodo varchar(255),

	foreign key(cod_periodo) references periodo(cod_periodo)
)


create table compositor_musica(
    cod_musica int, 
    cod_compositor int,

	foreign key(cod_musica) references faixa(cod_musica),
	foreign key(cod_compositor) references compositor(cod_compositor)
)

create table playlist(
    cod_playlist int primary key,
    nome char(255),
    tempo_de_execucao_total time,
    data_criacao date,

) on terciario

create table musica_playlist(
    cod_musica int,
    cod_playlist int,
    numero_de_vezes_tocada int,
    ultima_vez_tocada date

    foreign key(cod_musica)   references faixa(cod_musica),
    foreign key(cod_playlist) references playlist(cod_playlist)
) on terciario

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



--Terceira condição:

--Consertado
create trigger barroco on album 
for insert, update
as
begin

    --Contrapositiva
	--Não pode existir uma faixa do album onde seu período é barroco e sua gravação não é ddd
    if exists (
	
		select c.cod_periodo, f.tipo_gravacao from inserted i
		inner join faixa f on f.cod_album = i.cod_album
		inner join compositor_musica cm on cm.cod_musica = f.cod_musica
		inner join compositor c on c.cod_compositor = cm.cod_compositor
		where
		(
			c.cod_periodo = 'Barroco'
			and not 
			f.tipo_gravacao = 'DDD'
		)
	)
    begin
		raiserror('Erro período barroco',2,2,2);
        rollback;
    end
end

--Consertado
alter trigger precoAlto on album 
for insert, update
as
begin
	
	--Se existir algum album dos inseridos onde seu preço é maior que todos vezes 3, rejeitar
    if exists(
		select * from inserted  where 
		preco >
			(select 3 * avg(preco) 
			from album
			where cod_album 
			in (
				select distinct cod_album 
				from faixa 
				where tipo_gravacao = 'DDD'
			))
    )
    begin
        raiserror('Preço muito alto',2,2,2);
        rollback
    end
end

--Consertado
create trigger limiteTamanho on album
for insert, update
as 
begin
	
	
	if exists (
            select 1
            from faixa f
            inner join midia_musica mm on mm.cod_musica = f.cod_musica
            inner join midia_fisica mf on mf.cod_meio   = mm.cod_meio
			inner join inserted i      on i.cod_album = f.cod_album
            group by cod_album                 -- agrega elas pelo codigo do album
            having COUNT(*) > 64               -- vê se a quantidade de faixas desse album não excede 64
        )
    begin
        raiserror('Limite de 64 faixas por album excedido',2,2,2);
        rollback
    end
    
end

--Consertado
create trigger CdVinilDownload on midiaFisica
for insert, update
as
begin
    --Se já existir um meio físico para esse album e ele for download
    --então ele não permite adicionar
    --Caso ele seja cd ou vinil, permite somente se for o mesmo tipo
    if exists (
        select * from midiaFisica m inner join inserted i on m.cod_album = i.cod_album
        where (m.tipo = 'download' or i.tipo != m.tipo)
    )
    begin
		raiserror('Inserção falha, meio físico incompativel',2,2,2);
        rollback;
    end
end;


--Consertado
create trigger deletarMeioFisico on faixa
for delete
as
begin
    --Se o meio dessa musica que foi deletada tiver apenas ela como musica
    --Deletar esse meio
    delete from midiaFisica 
    where cod_meio in 
	
	
	(select MF.cod_meio from midiaFisica MF 
    inner join midia_musica MM on MF.cod_meio = MM.cod_meio
    where MM.cod_musica IN (SELECT cod_musica FROM deleted)
    group by MF.cod_meio
	having (count(*) > 0)
	)
    
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
ON faixa(cod_album)
WITH FILLFACTOR = 100;


CREATE NONCLUSTERED INDEX IX_Faixa_TipoComposicao
ON faixa(tipo_de_composicao)
WITH FILLFACTOR = 100;


--Quinta condição


-- Criar a visão materializada
create view visaoPlaylist
with schemabinding
as
select
    p.nome AS nome,
    COUNT(DISTINCT f.cod_album) AS albunsDiferentes
from playlist p
inner join musica_playlist mp on cod_playlist
inner join faixa f on cod_musica
group by p.nome;

-- Criar a indexação na visão materializada
create unique clustered index IX_PlaylistAlbumCountView
on visaoPlaylist(nome);


--Sexta condição:

-- Criar a função
create function ObterAlbumsPorCompositor
(
    @NomeCompositor char(255)
)
returns table
as
return
(
    select * from album 
    inner join faixa on cod_musica
    inner join compositor_musica on cod_musica
    inner join compositor c on cod_compositor
    where c.nome like '%' + @NomeCompositor + '%'
);
