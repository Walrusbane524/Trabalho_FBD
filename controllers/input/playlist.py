import controllers.sql.playlist as playlist
from datetime import date

# COLUMNS = ['cod_playlist', 'nome', 'tempo_de_execucao_total', 'data_criacao']

def buildDict(optional=True):
    dict = {}
    user_input = ''
    
    if optional:
        print("**Aperte somente enter para pular o input**")

    print("Insira o código da playlist: ", end='')
    user_input = input()
    if user_input != '':
        dict['cod_playlist'] = int(user_input)
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira o nome da playlist: ", end='')
    user_input = input()
    if user_input != '':
        dict['nome'] = user_input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira o tempo de execução total: ", end='')
    user_input = input()
    if user_input != '':
        dict['tempo_de_execucao_total'] = user_input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira a data de criação: ", end='')
    user_input = input()
    if user_input != '':
        dict['data_criacao'] = user_input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)
    print(dict)

    return dict

def select(conn):
    print("Insira os valores da condição de select:\n")
    dict = buildDict(True)
    return playlist.select(conn, where=dict)

def insert(conn):
    print("Insira os valores para a nova playlist:\n")
    dict = buildDict(False)

    dict['tempo_de_execucao_total'] = "NULL"
    current_date = date.today()
    dict['data_criacao'] = str(current_date)

    #print(dict.values())

    playlist.insert(conn, dict.values())
    print("Insert bem-sucedido!")
    return dict

def delete(conn):
    print("Insira os valores da condição para deleção:\n")
    where_dict = buildDict()
    while where_dict == {}:
        print("A condição de deleção não pode ser vazia!")
        where_dict = buildDict()
    playlist.delete(conn, where_dict)
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

    playlist.update(conn, set_dict, where_dict)
    print("Delete bem-sucedido!")