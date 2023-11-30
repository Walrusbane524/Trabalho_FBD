import psycopg2

def connect(dbname = "spotiper", user="spotiper", password="spotiper", host="localhost", port="5432"):
    return psycopg2.connect(dbname="spotiper", user="spotiper", password="spotiper", host="localhost", port="5432")

def select(conn, tables, columns = "*", where = ""):
    cursor = conn.cursor()
    cursor.execute("SELECT " + columns + " FROM " + tables + ("" if where == "" else " WHERE " + where))
    results = cursor.fetchall()
    cursor.close()
    return results

def insert(conn, table, values):
    cursor = conn.cursor()
    cursor.execute("INSERT INTO " + table + " VALUES (" + values + ")")
    cursor.close()

def close(conn):
    conn.close()