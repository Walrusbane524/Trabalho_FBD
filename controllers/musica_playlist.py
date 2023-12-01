import controllers.sql as sql

TABLENAME = "musica_playlist"

def select(conn, columns = [], where = {}):
    return sql.select(conn, TABLENAME, columns=columns, where=where)

def insert(conn, values):
    sql.insert(conn, TABLENAME, values)

def delete(conn, where = {}):
    sql.delete(conn, TABLENAME, where)
