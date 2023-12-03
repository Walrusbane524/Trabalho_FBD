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


def select(conn, table, columns = [], where_dict = {}):
    
    where_str = " AND ".join(f"{key} = '{value}'" if isinstance(value, str) else f"{key} = {value}" for key, value in where_dict.items()) if where_dict != {} else ""
    columns_str = ", ".join(column for column in columns) if columns != [] else "*"

    cursor = conn.cursor()

    query_string = "SELECT " + columns_str + " FROM " + table + ("" if where_str == "" else " WHERE " + where_str)
    #print(query_string)

    cursor.execute(query_string)
    
    rows = cursor.fetchall()
    columns = [desc[0] for desc in cursor.description]

    result_list = [dict(zip(columns, row)) for row in rows]

    cursor.close()

    #print(result_list)

    return result_list

def executeWithReturn(conn, sql_string):
    cursor = conn.cursor()
    cursor.execute(sql_string)
    rows = cursor.fetchall()

    columns = [desc[0] for desc in cursor.description]

    result_list = [dict(zip(columns, row)) for row in rows]

    cursor.close()
    conn.commit()
    return result_list

def insert(conn, table, values):

    values_str = ", ".join(f"'{value}'" if isinstance(value, str) and value != 'NULL' else f"{value}" for value in values) if values != [] else ""

    #print(values_str)
    cursor = conn.cursor()

    query_str = "INSERT INTO " + table + " VALUES (" + values_str + ")"

    print(query_str)

    cursor.execute(query_str)
    cursor.close()

    conn.commit()
    print("Linha inserida com sucesso")

def delete(conn, table, where_dict = {}):

    where_str = " AND ".join(f"{key} = '{value}'" if isinstance(value, str) and value != 'NULL' else f"{key} = {value}" for key, value in where_dict.items()) if where_dict != {} else ""

    cursor = conn.cursor()
    cursor.execute("DELETE FROM " + table + " WHERE " + where_str)
    cursor.close()
    conn.commit()
    print("Linha deletada com sucesso")

def update(conn, table, set_dict, where_dict):
    where_str = " AND ".join(f"{key} = '{value}'" if isinstance(value, str) else f"{key} = {value}" for key, value in where_dict.items()) if where_dict != {} else ""
    set_str = ", ".join(f"{key} = '{value}'" if isinstance(value, str) else f"{key} = {value}" for key, value in set_dict.items()) if set_dict != {} else ""

    cursor = conn.cursor()

    query_string = "UPDATE " + table + " SET " + set_str + " WHERE " + where_str
    print(query_string)

    cursor.execute(query_string)
    cursor.close()
    conn.commit()
    print("Linha editada com sucesso")

def close(conn):
    conn.close()

def printList(table_name, dict_list):
    max_size = 18
    titles = dict_list[0].keys()
    max_column_size = 0

    for d in dict_list:
        for key, value in d.items():
            if len(str(key)) > max_column_size:
                max_column_size = len(str(key))
                #print(f"Chave maior: {key}, Tamanho = {len(key)}")
            if len(str(value)) > max_column_size:
                max_column_size = len(str(value))
                #print(f"Valor maior: {str(value)}, Tamanho = {len(str(value))}")

    max_column_size += 2

    #print(max_column_size)

    print(f'{table_name:.^{max_column_size * len(titles)}}')

    for title in titles:
        print(f'{str(title).center(max_column_size)}', end='')
    print()

    for d in dict_list:
        for key, value in d.items():
            print(f'{str(value).center(max_column_size)}', end='')
        print()