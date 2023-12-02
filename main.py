import controllers.sql.general as sql
import controllers.sql.album as album

#conn = sql.connect(database='test', user='spotper', password='Sp0t!per')
conn = sql.connect(database='BDSpotPer')

whereClause = {
    "nome": 'gravadora 2' 
}

results = album.select(conn)

album.printList(results)

conn.commit()

sql.close(conn)