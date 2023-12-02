import controllers.sql.periodo as periodo

# COLUMNS = ['cod_periodo', 'comeco', 'fim', 'descricao']

def buildDict(optional=True):
    dict = {}
    input = ''
    
    if optional:
        print("**Aperte somente enter para pular o input**")

    print("Insira o código do período: ", end='')
    input = input()
    if input != '':
        dict['cod_periodo'] = int(input)
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira o a data de começo do período: ", end='')
    input = input()
    if input != '':
        dict['comeco'] = input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira o a data de fim do período: ", end='')
    input = input()
    if input != '':
        dict['fim'] = input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira a descrição do período: ", end='')
    input = input()
    if input != '':
        dict['descricao'] = input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    return dict
    
def insert(conn):
    print("Insira os valores para o novo álbum:\n")
    dict = buildDict(False)
    periodo.insert(conn, dict)
    print("Insert bem-sucedido!")
    

def delete(conn):
    print("Insira os valores da condição para deleção:\n")
    where_dict = buildDict()
    while where_dict == {}:
        print("A condição de deleção não pode ser vazia!")
        where_dict = buildDict()
    periodo.delete(conn, where_dict)
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
    periodo.update(conn, set_dict, where_dict)
    print("Delete bem-sucedido!")