import controllers.sql as sql

#conn = sql.connect(database='test', user='spotper', password='Sp0t!per')
conn = sql.connect(database='test')

whereClause = {
    "nome": 'gravadora 2' 
}

results = sql.select(conn, "album")

for row in results:
    print(row)

conn.commit()

sql.close(conn)