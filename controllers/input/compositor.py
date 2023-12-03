import controllers.sql.compositor as compositor

# COLUMNS = ['cod_compositor', 'nome', 'data_de_nascimento', 'data_de_falecimento', 'local_nascimento', 'cod_periodo']

def buildDict(optional=True):
    dict = {}
    user_input = ''
    
    if optional:
        print("**Aperte somente enter para pular o input**")

    print("Insira o código do compositor: ", end='')
    user_input = input()
    if user_input != '':
        dict['cod_compositor'] = int(user_input)
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira o nome do compositor: ", end='')
    user_input = input()
    if user_input != '':
        dict['nome'] = user_input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira a data de nascimento do compositor: ", end='')
    user_input = input()
    if user_input != '':
        dict['data_de_nascimento'] = user_input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira a data de falecimento do compositor: ", end='')
    user_input = input()
    if user_input != '':
        dict['data_de_falecimento'] = user_input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira o local de nascimento do compositor: ", end='')
    user_input = input()
    if user_input != '':
        dict['local_nascimento'] = user_input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira o período do compositor: ", end='')
    user_input = input()
    if user_input != '':
        dict['cod_periodo'] = user_input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    return dict

def select(conn):
    print("Insira os valores da condição de select:\n")
    dict = buildDict(True)
    return compositor.select(conn, where=dict)

def insert(conn):
    print("Insira os valores para o novo álbum:\n")
    dict = buildDict(False)
    compositor.insert(conn, dict.values())
    print("Insert bem-sucedido!")
    

def delete(conn):
    print("Insira os valores da condição para deleção:\n")
    where_dict = buildDict()
    while where_dict == {}:
        print("A condição de deleção não pode ser vazia!")
        where_dict = buildDict()
    compositor.delete(conn, where_dict)
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
    compositor.update(conn, set_dict, where_dict)
    print("Delete bem-sucedido!")