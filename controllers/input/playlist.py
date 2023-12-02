import controllers.sql.periodo as periodo
from datetime import date

# COLUMNS = ['cod_playlist', 'tempo_de_execucao_total', 'data_criacao']

def buildDict(optional=True):
    dict = {}
    input = ''
    
    if optional:
        print("**Aperte somente enter para pular o input**")

    print("Insira o código da playlist: ", end='')
    input = input()
    if input != '':
        dict['cod_playlist'] = int(input)
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira o tempo de execução total: ", end='')
    input = input()
    if input != '':
        dict['comeco'] = input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    print("Insira a data de criação: ", end='')
    input = input()
    if input != '':
        dict['data_criacao'] = input
    else:
        if not optional:
            print("Insira um valor!")
            return buildDict(optional)

    return dict
    
def insert(conn):
    print("Insira os valores para o novo álbum:\n")
    dict = buildDict(False)

    dict['tempo_de_execucao_total'] = "NULL"

    current_date = date.today()
    dict['data_criacao'] = current_date

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