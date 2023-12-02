import controllers.sql.midia_musica as midia_mus

# COLUMNS = ['cod_meio', 'cod_musica', 'numeroFaixa']

def buildDict():
    dict = {}
    input = ''

    print("Insira o código da mídia física: ", end='')
    input = input()
    if input != '':
        dict['cod_meio'] = int(input)
    else:
        print("Insira um valor!")
        return buildDict()

    print("Insira o código da música: ", end='')
    input = input()
    if input != '':
        dict['cod_musica'] = int(input)
    else:
        print("Insira um valor!")
        return buildDict()
    
    print("Insira o número da faixa: ", end='')
    input = input()
    if input != '':
        dict['numeroFaixa'] = int(input)
    else:
        print("Insira um valor!")
        return buildDict()

    return dict
    
def insert(conn):
    print("Insira os valores para o novo álbum:\n")
    dict = buildDict()
    midia_mus.insert(conn, dict)
    print("Insert bem-sucedido!")
    

def delete(conn):
    print("Insira os valores da condição para deleção:\n")
    where_dict = buildDict()
    midia_mus.delete(conn, where_dict)
    print("Delete bem-sucedido!")

def update(conn):
    print("Insira os valores da condição de update:\n")
    where_dict = buildDict()
    
    print("Insira os valores de update:\n")
    set_dict = buildDict()

    midia_mus.update(conn, set_dict, where_dict)
    print("Delete bem-sucedido!")