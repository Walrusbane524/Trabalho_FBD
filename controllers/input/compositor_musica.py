import controllers.sql.compositor_musica as comp_mus

# COLUMNS = ['cod_musica', 'cod_compositor']

def buildDict():
    dict = {}
    input = ''
    


    print("Insira o código da Música: ", end='')
    input = input()
    if input != '':
        dict['cod_musica'] = int(input)
    else:
        print("Insira um valor!")
        return buildDict()

    print("Insira o código do compositor: ", end='')
    input = input()
    if input != '':
        dict['cod_compositor'] = int(input)
    else:
        print("Insira um valor!")
        return buildDict()

    return dict
    
def insert(conn):
    print("Insira os valores para o novo álbum:\n")
    dict = buildDict()
    comp_mus.insert(conn, dict)
    print("Insert bem-sucedido!")
    

def delete(conn):
    print("Insira os valores da condição para deleção:\n")
    where_dict = buildDict()
    comp_mus.delete(conn, where_dict)
    print("Delete bem-sucedido!")

def update(conn):
    print("Insira os valores da condição de update:\n")
    where_dict = buildDict()
    
    print("Insira os valores de update:\n")
    set_dict = buildDict()

    comp_mus.update(conn, set_dict, where_dict)
    print("Delete bem-sucedido!")