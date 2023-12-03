import controllers.sql.telefones as telefones

# COLUMNS = ['numero', 'cod_gravadora']

def buildDict(optional=True):
    dict = {}
    user_input = ''
    
    if optional:
        print("**Aperte somente enter para pular o input**")

    print("Insira o número do telefone: ", end='')
    user_input = input()
    if user_input != '':
        dict['numero'] = user_input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira o código da gravadora: ", end='')
    user_input = input()
    if user_input != '':
        dict['cod_gravadora'] = user_input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    return dict
    
def select(conn):
    print("Insira os valores da condição de select:\n")
    dict = buildDict()
    return telefones.select(conn, where=dict)

def insert(conn):
    print("Insira os valores para o novo álbum:\n")
    dict = buildDict(False)
    telefones.insert(conn, dict.values())
    print("Insert bem-sucedido!")

def delete(conn):
    print("Insira os valores da condição para deleção:\n")
    where_dict = buildDict()
    while where_dict == {}:
        print("A condição de deleção não pode ser vazia!")
        where_dict = buildDict()
    telefones.delete(conn, where_dict)
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

    telefones.update(conn, set_dict, where_dict)
    print("Delete bem-sucedido!")