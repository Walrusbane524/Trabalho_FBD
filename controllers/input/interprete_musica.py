import controllers.sql.interprete_musica as interp_mus

# COLUMNS = ['cod_interprete', 'cod_musica']

def buildDict(optional = True):
    dict = {}
    user_input = ''

    print("Insira o código do interprete: ", end='')
    user_input = input()
    if user_input != '':
        dict['cod_interprete'] = int(user_input)
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict()

    print("Insira o código da música: ", end='')
    user_input = input()
    if user_input != '':
        dict['cod_musica'] = int(user_input)
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict()

    return dict
    
def select(conn):
    print("Insira os valores da condição de select:\n")
    dict = buildDict()
    return interp_mus.select(conn, where=dict)

def insert(conn):
    print("Insira os valores para o novo álbum:\n")
    dict = buildDict(False)
    interp_mus.insert(conn, dict.values())
    print("Insert bem-sucedido!")

def delete(conn):
    print("Insira os valores da condição para deleção:\n")
    where_dict = buildDict()
    while where_dict == {}:
        print("A condição de deleção não pode ser vazia!")
        where_dict = buildDict()
    interp_mus.delete(conn, where_dict)
    print("Delete bem-sucedido!")

def update(conn):
    print("Insira os valores da condição de update:\n")
    where_dict = buildDict()
    while where_dict == {}:
        print("A condição de update não pode ser vazia!")
        where_dict = buildDict()
    
    print("Insira os valores de update:\n")
    set_dict = buildDict()
    while where_dict == {}:
        print("A condição de update não pode ser vazia!")
        where_dict = buildDict()

    interp_mus.update(conn, set_dict, where_dict)
    print("Delete bem-sucedido!")