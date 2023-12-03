-- Criar tabelas
USE BDSpotPer;
create table gravadora(
    cod_gravadora int primary key not null,
    Endereco_homepage varchar(255),
    Endereco varchar(255),
    nome varchar(255) not null
)

create table telefone(
    numero varchar(10) primary key not null,
    cod_gravadora int not null,

    foreign key(cod_gravadora) references gravadora(cod_gravadora)
)


create table album(
    cod_album int primary key not null ,
    tipoCompra varchar(20) not null, 
    preco decimal(10,2) not null,
    data_de_gravacao date check (data_de_gravacao > '2000-01-01'), --Posterior a 2000
    data_da_compra date,
    cod_gravadora int not null

	foreign key(cod_gravadora) references gravadora(cod_gravadora)
)

create table midiaFisica(
    cod_meio int primary key not null,
    tipo varchar(20),
    cod_album int not null,

    --tem um trigger para lidar com o caso de ser cd ou vinil e poder adicionar vários
    
    --Quando o album é deletado, a midia física também é
    foreign key(cod_album) references album(cod_album) on delete cascade
)
create table tipo_de_composicao(
    cod_tipo_composicao varchar(20) primary key not null,
    descricao varchar(255)
)

create table interprete(
    cod_interprete int primary key not null,
    nome varchar(255) not null,
    tipo varchar(20) not null
)

create table faixa(
    cod_musica int primary key not null,
    descricao varchar(255),
    tempo_de_execucao time not null,
    cod_tipo_composicao varchar(20) not null,
    tipo_gravacao varchar(10) ,
    cod_album int not null

    foreign key(cod_tipo_composicao) references tipo_de_composicao(cod_tipo_composicao),
    foreign key(cod_album)           references album(cod_album) on delete cascade --Quando deletar o album deleta as suas faixas

) on terciario


create table interprete_musica(
    cod_interprete int not null, 
    cod_musica int not null,

	foreign key(cod_interprete) references interprete(cod_interprete) on delete cascade,
	foreign key(cod_musica) references faixa(cod_musica) on delete cascade
)


create table midia_musica(
    cod_meio int not null,
    cod_musica int not null,
    numeroFaixa int

    foreign key(cod_meio)   references midiaFisica(cod_meio) on delete cascade,
    foreign key(cod_musica) references faixa(cod_musica)
)


create table periodo(
    cod_periodo varchar(255) primary key not null,
    comeco date,
    fim date,
    descricao varchar(255)
)

create table compositor(
    cod_compositor int primary key not null,
    nome varchar(255) not null,
    data_de_nascimento date,
    data_de_falecimento date,
    local_nascimento varchar(255),
    cod_periodo varchar(255),

	foreign key(cod_periodo) references periodo(cod_periodo)
)


create table compositor_musica(
    cod_musica int, 
    cod_compositor int,

	foreign key(cod_musica) references faixa(cod_musica) on delete cascade,
	foreign key(cod_compositor) references compositor(cod_compositor) on delete cascade
)

create table playlist(
    cod_playlist int primary key not null,
    nome varchar(255) not null,
    tempo_de_execucao_total time,
    data_criacao date,

) on terciario

create table musica_playlist(
    cod_musica int not null,
    cod_playlist int not null,
    numero_de_vezes_tocada int,
    ultima_vez_tocada date

    foreign key(cod_musica)   references faixa(cod_musica) on delete cascade,
    foreign key(cod_playlist) references playlist(cod_playlist) on delete cascade
) on terciario

GO

--Terceira condição: Sucesso

--Consertado
--Testado com sucesso
create trigger barroco on compositor_musica
for insert, update
as
begin

    --Contrapositiva
	--Não pode existir uma faixa do album onde seu período é barroco e sua gravação não é ddd
    if exists (
	
		select c.cod_periodo, f.tipo_gravacao from album i
		inner join faixa f on f.cod_album = i.cod_album
		inner join inserted cm on cm.cod_musica = f.cod_musica
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


-- INSERT INTO faixa (cod_musica, descricao, tempo_de_execucao, cod_tipo_composicao, tipo_gravacao, cod_album)
-- VALUES (93, 'Song 3', '00:14:30', 'Conserto', 'TESTE', 1);

-- INSERT INTO compositor (cod_compositor, nome, data_de_nascimento, data_de_falecimento, local_nascimento, cod_periodo)
-- VALUES (73, 'Composer 2', '1600-01-01', '1700-01-01', 'City, Country', 'Barroco');

-- INSERT INTO compositor_musica (cod_musica, cod_compositor)
-- VALUES
--   (93,73)


GO

--Consertado
--Testado com sucesso
create trigger precoAlto on album 
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

--Teste: Sucesso
-- select * 
-- 			from album
-- 			where cod_album 
-- 			in (
-- 				select distinct cod_album 
-- 				from faixa 
-- 				where tipo_gravacao = 'DDD'
-- 			)

GO

--Consertado
--Testado com sucesso
create trigger limiteTamanho on faixa
for insert, update
as 
begin
	
	
	if     64 < all(select count(*) from inserted a
                inner join faixa on faixa.cod_album = a.cod_album 
                group by a.cod_album )              -- vê se a quantidade de faixas desse album não excede 64
        
    begin
        raiserror('Limite de 64 faixas por album excedido',2,2,2);
        rollback
    end
    
end

--Crie no javascript vários inserts diferentes, com mais de 64 para um album
--Ele nega a partir da inserção 64
-- const util = (vezes, inicial) =>{
--     let string = "";
--     for(let i=0; i< vezes;i++) string = string.concat(`(${inicial+i}, 'Track 51', '00:03:45', 'Pop', 'Stereo', 1),`)
--     return string;
-- }

GO

--Consertado
--Testado com sucesso
create trigger CdVinilDownload on midiaFisica
for insert, update
as
begin
    --Se já existir um meio físico para esse album e ele for download
    --então ele não permite adicionar
    --Caso ele seja cd ou vinil, permite somente se for o mesmo tipo
    if exists (
        select * from midiaFisica m inner join inserted i on m.cod_album = i.cod_album
        where (i.tipo != m.tipo)
    )

    or 1 < any( select count(m.cod_meio) from midiaFisica m 
                join inserted i on i.cod_album = m.cod_album
                where m.tipo = 'download'
                group by m.cod_album)
    begin
		raiserror('Inserção falha, meio físico incompativel',2,2,2);
        rollback;
    end
end;

--Teste1 Meios Diferentes: Funciona
-- INSERT INTO midiaFisica (cod_meio, tipo, cod_album)
-- VALUES
--   (100, 'Vinyl', 1)
-- INSERT INTO album (cod_album, tipoCompra, preco, data_de_gravacao, data_da_compra, cod_gravadora)
-- VALUES
--   (1905, 'Digital', 19.99, '2023-05-01', '2023-05-10', 1)
-- INSERT INTO midiaFisica (cod_meio, tipo, cod_album)
-- VALUES
--   (898, 'download', 1905)
-- INSERT INTO midiaFisica (cod_meio, tipo, cod_album)
-- VALUES
--   (899, 'cd', 1905)

--Teste2 Multiplos Downloads

-- INSERT INTO album (cod_album, tipoCompra, preco, data_de_gravacao, data_da_compra, cod_gravadora)
-- VALUES
--   (1907, 'Digital', 19.99, '2023-05-01', '2023-05-10', 1)
-- INSERT INTO midiaFisica (cod_meio, tipo, cod_album)
-- VALUES
--   (898, 'download', 1907)
-- INSERT INTO midiaFisica (cod_meio, tipo, cod_album)
-- VALUES
--   (899, 'download', 1907)

GO

--Consertado
--Testado
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

GO


--Consertado
--Testado com sucesso
create trigger tipoGravacao on midia_musica
for insert, update
as
begin

    declare @meio table(tipo varchar(20))
    declare @gravacao table(tipo_gravacao varchar(10));

    insert into @meio select tipo 
    from midiaFisica m
	inner join midia_musica mm on m.cod_meio = mm.cod_meio
	where cod_musica in (select cod_musica from inserted)


    insert into @gravacao select tipo_gravacao 
    from inserted inner join faixa on inserted.cod_musica = faixa.cod_musica

	if exists( 
		select * from @meio, @gravacao
		where ((tipo = 'CD' and not (tipo_gravacao = 'DDD' or tipo_gravacao = 'ADD'))) or (tipo != 'CD' and tipo_gravacao is not null)
)
	begin
		raiserror('CD com gravação nula ou Vinil/download com gravação: INVALIDO',2,2,2);
		rollback
	end

    
end;

--Teste Validado
--Inserindo no vinil um valor não nulo, rejeita como esperado
-- INSERT INTO faixa (cod_musica, descricao, tempo_de_execucao, cod_tipo_composicao, tipo_gravacao, cod_album)
-- VALUES (6, 'Song 1', '00:04:30', 'Rock', 'DDD', 1);
-- INSERT INTO midia_musica (cod_musica, cod_meio, numeroFaixa)
-- VALUES
--   (4223, 2, 1)

-- select tipo, tipo_gravacao, f.*
-- from midiaFisica m
-- inner join midia_musica mm on m.cod_meio = mm.cod_meio
-- inner join faixa f on f.cod_musica = mm.cod_musica
-- where (not (tipo = 'CD' and (tipo_gravacao = 'DDD' or tipo_gravacao = 'ADD'))) and (tipo != 'CD' and tipo_gravacao is not null)



GO


--Testado: Sucesso
create trigger calcularTamanhoPlaylist on musica_playlist
after insert, update 
as 
begin
    update playlist 
    set playlist.tempo_de_execucao_total = tabelaAtualizada.tempo
	from (
    
        select 
            CONVERT(TIME, DATEADD(SECOND, SUM(DATEDIFF(SECOND, 0, f.tempo_de_execucao)), 0)) as tempo, 
            playlist.cod_playlist as id 
        from faixa f 
		inner join musica_playlist mp
		on f.cod_musica = mp.cod_musica 
		inner join playlist 
		on playlist.cod_playlist = mp.cod_playlist
		inner join inserted
		on inserted.cod_playlist = playlist.cod_playlist
	
		group by playlist.cod_playlist
    ) tabelaAtualizada
    where (tabelaAtualizada.id = playlist.cod_playlist)
end

GO

--Quarta condição: A consertar...

-- CREATE UNIQUE CLUSTERED INDEX IX_Faixa_CodigoAlbum
-- ON faixa(cod_album)
-- WITH FILLFACTOR = 100;

-- GO

-- CREATE NONCLUSTERED INDEX IX_Faixa_TipoComposicao
-- ON faixa(cod_tipo_composicao)
-- WITH FILLFACTOR = 100;


--Quinta condição: Sucesso

GO

-- Criar a visão materializada: consertar outer join
create view visaoPlaylist
with schemabinding
as
select
        p.nome AS nomePlaylist,
        COUNT(DISTINCT f.cod_album) AS albunsDiferentes
    from dbo.playlist p
    full join dbo.musica_playlist mp on mp.cod_playlist = p.cod_playlist
    full join dbo.faixa f on f.cod_musica = mp.cod_musica
    group by p.nome;


--Sexta condição: Sucesso

GO

-- Criar a função
--Testado com sucesso
create function ObterAlbumsPorCompositor
(
    @NomeCompositor varchar(255)
)
returns table
as
return
(
    select c.nome, a.* from album a
    inner join faixa f on f.cod_album = a.cod_album
    inner join compositor_musica cm on f.cod_musica = cm.cod_musica
    inner join compositor c on c.cod_compositor = cm.cod_compositor
    where c.nome like '%' + @NomeCompositor + '%'
);



--Setima condição: Pesquisa da database

GO

--i)
create view mostrarAlbunsComFaixas
as
select album.*, faixa.cod_musica, faixa.cod_tipo_composicao, faixa.descricao, faixa.tempo_de_execucao, faixa.tipo_gravacao from album join faixa on faixa.cod_album = album.cod_album

GO

--ii)
create view mostrarPlaylistsComMusicas
as
select playlist.*, faixa.* from playlist 
full join musica_playlist 
on playlist.cod_playlist = musica_playlist.cod_playlist
left outer join faixa 
on faixa.cod_musica = musica_playlist.cod_musica

GO

create procedure inserirMusica
(
    @playlistCodigo int,
    @musicaInserida int
)
as
begin
    insert into musica_playlist values(@musicaInserida, @playlistCodigo, 0, null)
end

GO

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
GO

create view albumsCaros
as
select * from album album
join (select avg(preco) as precoMedio from album) medio 
on album.preco > medio.precoMedio;

GO

create view DvoracEhOMior 
as 


	select * from gravadora gravadora

	join 

		(
			select top 1 a.cod_gravadora as id, count(p.cod_playlist) as numeroDePlaylists 
			from playlist p
			join musica_playlist mp
			on p.cod_playlist = mp.cod_playlist
			full join faixa f
			on f.cod_musica = mp.cod_musica
			join album a on a.cod_album = f.cod_album


			group by p.cod_playlist, a.cod_gravadora

			order by numeroDePlaylists desc


		) melhorGravadora
on gravadora.cod_gravadora = melhorGravadora.id;

GO

--c) Listar nome do compositor com maior número de faixas nas playlists existentes.

create view compositorMaisTrabalhador
as 

    select compositor.*, numeroDeFaixas from compositor 
    join 
        (

            select top 1 count(f.cod_musica) as numeroDeFaixas, cod_compositor
            from faixa f
            inner join compositor_musica cm on cm.cod_musica = f.cod_musica 
            group by cm.cod_compositor
            order by numeroDeFaixas desc

        ) compositorMaisPopular
    on compositor.cod_compositor = compositorMaisPopular.cod_compositor
    

--d) Listar playlists, cujas faixas (todas) têm tipo de composição “Concerto” e período “Barroco”

GO

create view playlistsClassicas
as 

    select * 
    from playlist p
    where not exists --Contrapositiva: Não existe faixa cuja composição não é Conserto e periodo não é barroco
    (
        select 0 from musica_playlist mp 
        full join faixa f               on f.cod_musica = mp.cod_musica
        inner join compositor_musica cm on cm.cod_musica = f.cod_musica 
        inner join compositor c         on c.cod_compositor = cm.cod_compositor
        where mp.cod_playlist = p.cod_playlist and f.cod_tipo_composicao != 'Concerto' or c.cod_periodo != 'Barroco'
    );


    --Falta: on delete cascade para cada tabela intermediária
    --       testar dois triggers
    --       testar as views do item 7
    --       consertar os indices clusterizados do item 4