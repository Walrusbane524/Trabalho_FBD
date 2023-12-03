import controllers.sql.general as sql

TABLENAME = "midia_musica"

def select(conn, columns = [], where = {}):
    return sql.select(conn, TABLENAME, columns=columns, where_dict=where)

def insert(conn, values):
    sql.insert(conn, TABLENAME, values)

def delete(conn, where = {}):
    sql.delete(conn, TABLENAME, where)

def update(conn, set_dict, where_dict):
    sql.update(conn, TABLENAME, set_dict, where_dict)

def printList(dict_list):
    sql.printList(TABLENAME.upper(), dict_list)