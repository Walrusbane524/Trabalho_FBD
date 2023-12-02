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

def update(conn, table, set_dict, where_dict):
    where_str = ", ".join(f"{key} = '{value}'" if isinstance(value, str) else f"{key} = {value}" for key, value in where_dict.items()) if where_dict != {} else ""
    set_str = ", ".join(f"{key} = '{value}'" if isinstance(value, str) else f"{key} = {value}" for key, value in set_dict.items()) if set_dict != {} else ""

    cursor = conn.cursor()
    cursor.execute("UPDATE " + table + " SET " + set_str + " WHERE " + where_str)
    cursor.close()

def close(conn):
    conn.close()

def printList(table_name, dict_list):
    max_size = 18
    titles = dict_list[0].keys()
    hsize = 0

    for title in titles:
        hsize += max(max_size, len(title))
    print(f'{table_name:.^{hsize}}')

    for title in titles:
        print(f'{str(title).center(max(len(title), max_size))}', end='')
    print()

    for dict in dict_list:
        for key, value in dict.items():
            print(f'{str(value).center(max(len(str(value)), len(key), max_size))}', end='')
        print()