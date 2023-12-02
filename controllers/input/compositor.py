import controllers.sql.compositor as compositor

# COLUMNS = ['cod_compositor', 'nome', 'data_de_nascimento', 'data_de_falecimento', 'local_nascimento', 'cod_periodo']

def buildDict(optional=True):
    dict = {}
    input = ''
    
    if optional:
        print("**Aperte somente enter para pular o input**")

    print("Insira o código do compositor: ", end='')
    input = input()
    if input != '':
        dict['cod_compositor'] = int(input)
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira o nome do compositor: ", end='')
    input = input()
    if input != '':
        dict['nome'] = input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira a data de nascimento do compositor: ", end='')
    input = input()
    if input != '':
        dict['data_de_nascimento'] = input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira a data de falecimento do compositor: ", end='')
    input = input()
    if input != '':
        dict['data_de_falecimento'] = input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira o local de nascimento do compositor: ", end='')
    input = input()
    if input != '':
        dict['local_nascimento'] = input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira o código do período do compositor: ", end='')
    input = input()
    if input != '':
        dict['cod_periodo'] = int(input)
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    return dict
    
def insert(conn):
    print("Insira os valores para o novo álbum:\n")
    dict = buildDict(False)
    compositor.insert(conn, dict)
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