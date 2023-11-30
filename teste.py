import psycopg2
import database

conn = database.connect()

results = database.select(conn, "gravadora", columns="*")

for row in results:
    print(row)

conn.commit()

database.close(conn)