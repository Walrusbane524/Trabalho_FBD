import controllers.sql.musica_playlist as mus_play

# COLUMNS = ['cod_musica', 'cod_playlist', 'numero_de_vezes_tocada', 'ultima_vez_tocada']

def buildDict(optional = True):
    dict = {}
    user_input = ''

    print("Insira o código da música: ", end='')
    user_input = input()
    if user_input != '':
        dict['cod_musica'] = int(user_input)
    else:
        if(not optional):
            print("Insira um valor!")
            return buildDict()

    print("Insira o código da playlist: ", end='')
    user_input = input()
    if user_input != '':
        dict['cod_playlist'] = int(user_input)
    else:
        if(not optional):
            print("Insira um valor!")
            return buildDict()
    
    print("Insira o número de vezes tocada: ", end='')
    user_input = input()
    if user_input != '':
        dict['numero_de_vezes_tocada'] = int(user_input)
    else:
        if(not optional):
            print("Insira um valor!")
            return buildDict()
    
    print("Insira a última vez tocada: ", end='')
    user_input = input()
    if user_input != '':
        dict['ultima_vez_tocada'] = user_input
    else:
        if(not optional):
            print("Insira um valor!")
            return buildDict()

    return dict
    
def select(conn):
    print("Insira os valores da condição de select:\n")
    dict = buildDict()
    return mus_play.select(conn, where=dict)

def insert(conn):
    print("Insira os valores para o novo álbum:\n")
    dict = buildDict(False)
    dict['numero_de_vezes_tocada'] = 0
    dict['ultima_vez_tocada'] = "NULL"
    mus_play.insert(conn, dict.values())
    print("Insert bem-sucedido!")

def delete(conn):
    print("Insira os valores da condição para deleção:\n")
    where_dict = buildDict()
    mus_play.delete(conn, where_dict)
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
        print("A condição de update não pode ser vazia!")
        set_dict = buildDict()

    mus_play.update(conn, set_dict, where_dict)
    print("Delete bem-sucedido!")