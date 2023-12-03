import controllers.sql.tipo_de_composicao as tipo_de_composicao

# COLUMNS = ['cod_tipo_composicao', 'descricao']

def buildDict(optional=True):
    dict = {}
    user_input = ''
    
    if optional:
        print("**Aperte somente enter para pular o input**")

    print("Insira o nome do tipo de composição: ", end='')
    user_input = input()
    if user_input != '':
        dict['cod_tipo_composicao'] = user_input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira a descrição do tipo de composição: ", end='')
    user_input = input()
    if user_input != '':
        dict['descricao'] = user_input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    return dict
    
def select(conn):
    print("Insira os valores da condição de select:\n")
    dict = buildDict(True)
    return tipo_de_composicao.select(conn, where=dict)

def insert(conn):
    print("Insira os valores para o novo álbum:\n")
    dict = buildDict(False)
    tipo_de_composicao.insert(conn, dict.values())
    print("Insert bem-sucedido!")

def delete(conn):
    print("Insira os valores da condição para deleção:\n")
    where_dict = buildDict()
    while where_dict == {}:
        print("A condição de deleção não pode ser vazia!")
        where_dict = buildDict()
    tipo_de_composicao.delete(conn, where_dict)
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
    tipo_de_composicao.update(conn, set_dict, where_dict)
    print("Delete bem-sucedido!")