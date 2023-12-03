import controllers.sql.gravadora as gravadora

# COLUMNS = ['cod_gravadora', 'Endereco_homepage', 'Endereco', 'nome']

def buildDict(optional=True):
    dict = {}
    user_input = ''
    
    if optional:
        print("**Aperte somente enter para pular o input**")

    print("Insira o código da gravadora: ", end='')
    user_input = input()
    if user_input != '':
        dict['cod_gravadora'] = int(user_input)
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira o endereço da homepage da gravadora: ", end='')
    user_input = input()
    if user_input != '':
        dict['Endereco_homepage'] = user_input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira o endereço da gravadora: ", end='')
    user_input = input()
    if user_input != '':
        dict['Endereco'] = user_input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira a data de gravacao do album: ", end='')
    user_input = input()
    if user_input != '':
        dict['data_de_gravacao'] = user_input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira o nome da gravadora: ", end='')
    user_input = input()
    if user_input != '':
        dict['nome'] = user_input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    return dict

def select(conn):
    print("Insira os valores da condição de select:\n")
    dict = buildDict(True)
    return gravadora.select(conn, where=dict)

def insert(conn):
    print("Insira os valores para o novo álbum:\n")
    dict = buildDict(False)
    gravadora.insert(conn, dict.values())
    print("Insert bem-sucedido!")
    

def delete(conn):
    print("Insira os valores da condição para deleção:\n")
    where_dict = buildDict()
    while where_dict == {}:
        print("A condição de deleção não pode ser vazia!")
        where_dict = buildDict()
    gravadora.delete(conn, where_dict)
    print("Delete bem-sucedido!")

def update(conn):
    print("Insira os valores da condição de update:\n")
    where_dict = buildDict()
    while where_dict == {}:
        print("A condição de update não pode ser vazia!")
        where_dict = buildDict()
    print("Insira os valores de update:\n")
    set_dict = buildDict()
    while set_dict == {}:
        print("Deve haver pelo menos uma coluna a ser modificada!")
        set_dict = buildDict()
    gravadora.update(conn, set_dict, where_dict)
    print("Delete bem-sucedido!")