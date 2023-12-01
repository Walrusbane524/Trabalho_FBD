import pypyodbc

def connect(database="BDSpotPer", server="WALRUSBANE"):
    DRIVER_NAME = "SQL SERVER"
    connecion_string = f"""
        DRIVER={{{DRIVER_NAME}}};
        SERVER={server};
        DATABASE={database};
        Trust_Connection=yes;
    """
    return pypyodbc.connect(connecion_string)


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