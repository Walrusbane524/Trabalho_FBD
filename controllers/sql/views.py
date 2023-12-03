import controllers.sql.general as sql

def selectPlaylistsClassicas(conn, columns = [], where = {}):
    return sql.select(conn, "playlistsClassicas", columns=columns, where=where)

def selectCompositorMaisTrabalhador(conn, columns = [], where = {}):
    return sql.select(conn, "compositorMaisTrabalhador", columns=columns, where=where)

def selectDvoracEhOMior(conn, columns = [], where = {}):
    return sql.select(conn, "DvoracEhOMior", columns=columns, where=where)

def selectAlbumsCaros(conn, columns = [], where = {}):
    return sql.select(conn, "albumsCaros", columns=columns, where=where)



def selectMostrarPlaylistsComMusicas(conn, columns = [], where = {}):
    return sql.select(conn, "mostrarPlaylistsComMusicas", columns=columns, where=where)

def selectMostrarAlbunsComFaixas(conn, columns = [], where = {}):
    return sql.select(conn, "mostrarAlbunsComFaixas", columns=columns, where=where)

def selectVisaoPlaylist(conn, columns = [], where = {}):
    return sql.select(conn, "mostrarAlbunsComFaixas", columns=columns, where=where)
