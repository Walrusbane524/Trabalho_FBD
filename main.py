import controllers.sql.general as sql
import controllers.menu as menu

#conn = sql.connect(database='test', user='spotper', password='Sp0t!per')
conn = sql.connect(database='BDSpotPer')

menu.menu(conn)

conn.commit()

sql.close(conn)