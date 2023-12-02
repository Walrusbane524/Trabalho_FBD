import controllers.sql.midia_fisica as midia_fisica

# COLUMNS = ['cod_meio', 'tipo', 'cod_album']

def buildDict(optional=True):
    dict = {}
    input = ''
    
    if optional:
        print("**Aperte somente enter para pular o input**")

    print("Insira o código da mídia física: ", end='')
    input = input()
    if input != '':
        dict['cod_meio'] = int(input)
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira o tipo da mídia física: ", end='')
    input = input()
    if input != '':
        dict['tipo'] = input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira o código do álbum: ", end='')
    input = input()
    if input != '':
        dict['cod_album'] = int(input)
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    return dict
    
def insert(conn):
    print("Insira os valores para o novo álbum:\n")
    dict = buildDict(False)
    midia_fisica.insert(conn, dict)
    print("Insert bem-sucedido!")
    

def delete(conn):
    print("Insira os valores da condição para deleção:\n")
    where_dict = buildDict()
    while where_dict == {}:
        print("A condição de deleção não pode ser vazia!")
        where_dict = buildDict()
    midia_fisica.delete(conn, where_dict)
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
    midia_fisica.update(conn, set_dict, where_dict)
    print("Delete bem-sucedido!")