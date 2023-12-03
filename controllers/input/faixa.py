import controllers.sql.faixa as faixa

# COLUMNS = ['cod_musica', 'descricao', 'tempo_de_execucao', 'tipo_gravacao', 'cod_tipo_composicao', 'cod_gravadora', 'cod_album']

def buildDict(optional=True):
    dict = {}
    user_input = ''
    
    if optional:
        print("**Aperte somente enter para pular o input**")

    print("Insira o código da música: ", end='')
    user_input = input()
    if user_input != '':
        dict['cod_musica'] = int(user_input)
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira a descrição da música: ", end='')
    user_input = input()
    if user_input != '':
        dict['descricao'] = user_input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira o tempo de execução da música: ", end='')
    user_input = input()
    if user_input != '':
        dict['tempo_de_execucao'] = user_input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira a tipo de gravacao da música: ", end='')
    user_input = input()
    if user_input != '':
        dict['tipo_gravacao'] = user_input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)
    
    print("Insira o código do tipo de composição da música: ", end='')
    user_input = input()
    if user_input != '':
        dict['cod_tipo_composicao'] = int(user_input)
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira o código da gravadora da música: ", end='')
    user_input = input()
    if user_input != '':
        dict['cod_gravadora'] = int(user_input)
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)
        
    print("Insira o código do álbum da música: ", end='')
    user_input = input()
    if user_input != '':
        dict['cod_album'] = int(user_input)
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    return dict

def select(conn):
    print("Insira os valores da condição de select:\n")
    dict = buildDict(True)
    return faixa.select(conn, where=dict)

def insert(conn):
    print("Insira os valores para o novo álbum:\n")
    dict = buildDict(False)
    faixa.insert(conn, dict.values())
    print("Insert bem-sucedido!")
    
def delete(conn):
    print("Insira os valores da condição para deleção:\n")
    where_dict = buildDict()
    while where_dict == {}:
        print("A condição de deleção não pode ser vazia!")
        where_dict = buildDict()
    faixa.delete(conn, where_dict)
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
    faixa.update(conn, set_dict, where_dict)
    print("Delete bem-sucedido!")