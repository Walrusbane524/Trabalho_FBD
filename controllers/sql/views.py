import controllers.sql.general as sql

def selectPlaylistsClassicas(conn, columns = [], where = {}):
    return sql.select(conn, "playlistsClassicas", columns, where)

def selectCompositorMaisTrabalhador(conn, columns = [], where = {}):
    return sql.select(conn, "compositorMaisTrabalhador", columns, where)

def selectDvoracEhOMior(conn, columns = [], where = {}):
    return sql.select(conn, "DvoracEhOMior", columns, where)

def selectAlbumsCaros(conn, columns = [], where = {}):
    return sql.select(conn, "albumsCaros", columns, where)



def selectMostrarPlaylistsComMusicas(conn, columns = [], where = {}):
    return sql.select(conn, "mostrarPlaylistsComMusicas", columns, where)

def selectMostrarAlbunsComFaixas(conn, columns = [], where = {}):
    return sql.select(conn, "mostrarAlbunsComFaixas", columns, where)

def selectVisaoPlaylist(conn, columns = [], where = {}):
    return sql.select(conn, "visaoPlaylist", columns, where)

def selectFuncaoObterAlbumsPorCompositor(conn, compositor):
    return sql.executeWithReturn(conn, f"SELECT * from ObterAlbumsPorCompositor('{compositor}')")

def printList(dict_list):
    if(len(dict_list) > 0):
        titles = dict_list[0].keys()
        max_column_size = 0

        for d in dict_list:
            for key, value in d.items():
                if len(str(key)) > max_column_size:
                    max_column_size = len(str(key))
                    #print(f"Chave maior: {key}, Tamanho = {len(key)}")
                if len(str(value)) > max_column_size:
                    max_column_size = len(str(value))
                    #print(f"Valor maior: {str(value)}, Tamanho = {len(str(value))}")

        max_column_size += 2

        #print(max_column_size)

        print(f'{"VALORES":.^{max_column_size * len(titles)}}')

        for title in titles:
            print(f'{str(title).center(max_column_size)}', end='')
        print()

        for d in dict_list:
            for key, value in d.items():
                print(f'{str(value).center(max_column_size)}', end='')
            print()
    else:
        print("Vazio!")