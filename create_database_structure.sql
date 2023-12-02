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
    data_de_gravacao date check (data_de_gravacao > '2000-01-01'), --Posterior a 2000
    data_da_compra date,
    cod_gravadora int

	foreign key(cod_gravadora) references gravadora(cod_gravadora)
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


--Terceira condição: Sucesso

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
			inner join inserted i  on i.cod_album = f.cod_album
            group by f.cod_album                 -- agrega elas pelo codigo do album
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

--Consertado
create trigger tipoGravacao on faixa
for insert, update
as
begin

    declare @meio table(tipo char(20))
    declare @gravacao table(tipo_gravacao char(10));

    insert into @meio select tipo 
    from midiaFisica m
	inner join midia_musica mm on m.cod_meio = mm.cod_meio
	where cod_musica in (select cod_musica from inserted)


    insert into @gravacao select tipo_gravacao 
    from inserted

	if exists( 
		select * from @meio, @gravacao
		where (tipo = 'CD' and tipo_gravacao is null) or (tipo_gravacao is not null)
	)
	begin
		raiserror('CD com gravação nula ou Vinil/download com gravação: INVALIDO',2,2,2);
		rollback
	end

    
end;

--Quarta condição: Sucesso

CREATE UNIQUE CLUSTERED INDEX IX_Faixa_CodigoAlbum
ON faixa(cod_album)
WITH FILLFACTOR = 100;


CREATE NONCLUSTERED INDEX IX_Faixa_TipoComposicao
ON faixa(cod_tipo_composicao)
WITH FILLFACTOR = 100;


--Quinta condição: Sucesso


-- Criar a visão materializada
create view visaoPlaylist
with schemabinding
as
select
    p.nome as nomePlaylist,
    COUNT(distinct f.cod_album) as albunsDiferentes
from dbo.playlist p
join dbo.musica_playlist mp on mp.cod_playlist = p.cod_playlist
join dbo.faixa f on f.cod_musica = mp.cod_musica
group by p.nome

union 

select --União com as playlists que não tem músicas
	p.nome as nomePlaylist,
	0 as albunsDiferentes
from dbo.playlist p
where not exists( select * from dbo.musica_playlist mp where mp.cod_playlist = p.cod_playlist)


--Sexta condição: Sucesso

-- Criar a função

create function ObterAlbumsPorCompositor
(
    @NomeCompositor char(255)
)
returns table
as
return
(
    select c.nome from album a
    inner join faixa f on f.cod_album = a.cod_album
    inner join compositor_musica cm on f.cod_musica = cm.cod_musica
    inner join compositor c on c.cod_compositor = cm.cod_compositor
    where c.nome like '%' + @NomeCompositor + '%'
);


--Setima condição: Pesquisa da database


--i)
create view mostrarAlbunsComFaixas
as
select * from album join faixa on faixa.cod_album = album.cod_album

--ii)
create view mostrarPlaylistsComMusicas
as
select * from playlist 
full join musica_playlist 
on playlist.cod_playlist = musica_playlist.cod_playlist
left outer join faixa 
on faixa.cod_musica = musica_playlist.cod_musica


create procedure inserirMusica
(
    @playlistCodigo int,
    @musicaInserida int
)
as
begin
    insert into musica_playlist values(@musicaInserida, @playlistCodigo, 0, null)
end

create procedure removerMusica
(
    @playlistCodigo int,
    @musicaInserida int
)
as
begin
    delete from musica_playlist where cod_playlist = @playlistCodigo and @musicaInserida =cod_musica
end

--iii)

--a)

--Meio que uma gambiarra, mas evita de repetir a query (select avg(preco) from album) cada vez
create view albumsCaros
as
select * from album album
join (select avg(preco) from album) medio 
where album.preco > medio.preco


--b)Listar nome da gravadora com maior número de playlists que possuem pelo uma faixa composta pelo compositor Dvorack.

create view DvorackEhOMelhor
as 
select count(*)  --Numero de músicas pela playlist
from playlist p
join musica_playlist mp
on p.cod_playlist = mp.cod_playlist
join faixa f
on f.cod_musica = mp.cod_musica
group by cod_playlist