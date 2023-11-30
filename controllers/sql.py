import psycopg2

def connect(dbname = "spotiper", user="spotiper", password="spotiper", host="localhost", port="5432"):
    return psycopg2.connect(dbname="spotiper", user="spotiper", password="spotiper", host="localhost", port="5432")

def select(conn, tables, columns = [], where_dict = {}):
    
    where_str = ", ".join(f"{key} = '{value}'" if isinstance(value, str) else f"{key} = {value}" for key, value in where_dict.items()) if where_dict != {} else ""
    columns_str = ", ".join(column for column in columns) if columns != [] else "*"

    cursor = conn.cursor()
    cursor.execute("SELECT " + columns_str + " FROM " + tables + ("" if where_str == "" else " WHERE " + where_str))
    
    rows = cursor.fetchall()
    columns = [desc[0] for desc in cursor.description]

    result_list = [dict(zip(columns, row)) for row in rows]

    cursor.close()

    return result_list

def insert(conn, table, values):

    values_str = ", ".join(value for value in values) if values != [] else ""

    cursor = conn.cursor()
    cursor.execute("INSERT INTO " + table + " VALUES (" + values_str + ")")
    cursor.close()
    print("Linha inserida com sucesso")

def delete(conn, table, where_dict = {}):

    where_str = ", ".join(f"{key} = '{value}'" if isinstance(value, str) else f"{key} = {value}" for key, value in where_dict.items()) if where_dict != {} else ""

    cursor = conn.cursor()
    cursor.execute("DELETE FROM " + table + " WHERE " + where_str)
    cursor.close()
    print("Linha deletada com sucesso")

def close(conn):
    conn.close()