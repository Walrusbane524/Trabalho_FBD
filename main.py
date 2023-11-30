import controllers.sql as sql

conn = sql.connect()

whereClause = {
    "nome": 'gravadora 2' 
}

results = sql.select(conn, "gravadora", where_dict=whereClause)

for row in results:
    print(row)

conn.commit()

sql.close(conn)