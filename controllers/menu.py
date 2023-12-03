from importlib import import_module
import controllers.input as sql_input
import controllers.sql as sql
from datetime import date

tabelas = ['album', 'compositor', 'midia_fisica', 'faixa', 
           'midia_musica', 'compositor_musica', 'playlist', 
           'musica_playlist', 'gravadora', 'interprete', 
           'interprete_musica', 'tipo_de_composicao', 
           'telefones', 'views', 'sair']

def handlePlaylistTrackInsertion(conn, playlist_id, track_id_list):
    musica_playlist_sql = import_module('controllers.sql.musica_playlist')
    
    for track_id in track_id_list:
        mus_play_dict = {}
        mus_play_dict['cod_musica'] = track_id
        mus_play_dict['cod_playlist'] = playlist_id
        mus_play_dict['numero_de_vezes_tocada'] = 0
        mus_play_dict['ultima_vez_tocada'] = "NULL"
        musica_playlist_sql.insert(conn, mus_play_dict.values())
        
def handlePlaylistTrackDeletion(conn, playlist_id, track_id_list):
    musica_playlist_sql = import_module('controllers.sql.musica_playlist')
    
    for track_id in track_id_list:
        musica_playlist_sql.delete(conn, {'cod_musica': track_id, 'cod_playlist': playlist_id})

def handlePlaylistTrackSelection(conn, playlist_id):
    play_mus_sql = import_module('controllers.sql.musica_playlist')
    faixas_escolhidas = []
    user_input = ''
    while(user_input != 'q'):
        print("Insira o código de uma das músicas, aperte 'q' para cancelar ou aperte 'c' para confirmar seleção:")
        play_mus_sql.printList(play_mus_sql.select(conn, where = {'cod_playlist': playlist_id}))
        print("Faixas selecionadas para deleção:", faixas_escolhidas)
        user_input = input()
        if user_input != 'q' and user_input != 'c':
            try:
                number_input = int(user_input)
                faixas_escolhidas.append(number_input)
            except:
                print("Insira um valor válido!")
        elif user_input == 'c':
            handlePlaylistTrackDeletion(conn, playlist_id, faixas_escolhidas)
            faixas_escolhidas = []

def handleAlbumTrackSelection(conn, album_id):
    faixa_sql = import_module('controllers.sql.faixa')
    faixas_escolhidas = []
    user_input = ''
    while(user_input != 'q'):
        print("Insira o código de uma das músicas, aperte 'q' para cancelar ou aperte 'c' para confirmar seleção:")
        faixa_sql.printList(faixa_sql.select(conn, where = {'cod_album': album_id}))
        print("Faixas selecionadas:", faixas_escolhidas)
        user_input = input()
        if user_input != 'q' and user_input != 'c':
            try:
                number_input = int(user_input)
                faixas_escolhidas.append(number_input)
            except:
                print("Insira um valor válido!")
        elif user_input == 'c':
            return faixas_escolhidas

def handleAlbumSelection(conn, playlist_id):
    album_sql = import_module('controllers.sql.album')
    user_input = ''
    faixas_escolhidas = []
    while user_input != 'q':
        print("Insira o código de um dos albuns, aperte 'q' para cancelar ou aperte 'c' para confirmar seleção:")
        album_sql.printList(album_sql.select(conn))
        user_input = input().lower()
        if user_input != 'q' and user_input != 'c':
            try:
                album_id = int(user_input) 
                faixas_escolhidas.extend(handleAlbumTrackSelection(conn, album_id))
            except:
                print("Insira um valor válido!")
        elif user_input == 'c':
             handlePlaylistTrackInsertion(conn, playlist_id, faixas_escolhidas)
             print("Inserção concluída")


def handlePlaylistCreation(conn):
    playlist_input = import_module('controllers.input.playlist')
    inserted_playlist = playlist_input.insert(conn)
    print("Deseja já inserir músicas na playlist? (s/n)")
    if input().lower() == 'n':
        return
    handleAlbumSelection(conn, inserted_playlist['cod_playlist'])

def handlePlaylistMusicUpdate(conn, playlist_id):
    play_mus_input_module = import_module('controllers.input.musica_playlist')
    play_mus_sql_module = import_module('controllers.sql.musica_playlist')
    user_input = 0
    while user_input != 3:
        music_lisc = play_mus_sql_module.select(conn, where={'cod_playlist': playlist_id})
        if len(music_lisc) > 0:
            play_mus_sql_module.printList(music_lisc)
        else:
            print("Playlist vazia")
        print("Escolha uma das opções:")
        print("1. Inserir novas músicas à playlist")
        print("2. Remover músicas da playlist")
        print("3. Sair")
        try:
            user_input = int(input())
            if user_input == 1:
                handleAlbumSelection(conn, playlist_id)
            elif user_input == 2:
                handlePlaylistTrackSelection(conn, playlist_id)
            elif user_input != 3:
                print("Insira um valor válido!")
        except:
            print("Insira um valor válido!")


def handlePlaylistUpdate(conn):
    playlist_input_module = import_module('controllers.input.playlist')
    playlist_sql_module = import_module('controllers.sql.playlist')
    print("Deseja mudar o nome de uma playlist? (s/n)")
    if input().lower() == 's':
        playlist_sql_module.printList(playlist_sql_module.select(conn))
        playlist_input_module.update(conn)
    user_input = ''
    while user_input.lower() != 'q':
        print("Escolha uma playlist para atualizar as músicas ou aperte q para sair:")
        playlist_sql_module.printList(playlist_sql_module.select(conn))
        user_input = input()
        if user_input.lower() != 'q':
            try:
                number_input = int(user_input)
                handlePlaylistMusicUpdate(conn, number_input)
            except:
                print("Insira um valor válido")

def playPlaylistTracks(conn, playlist_id):
    play_mus_input_module = import_module('controllers.input.musica_playlist')
    play_mus_sql_module = import_module('controllers.sql.musica_playlist')
    user_input = ''
    while user_input != 'q':
        print("Escolha uma música ou aperte q para sair:")
        play_mus_sql_module.printList(play_mus_sql_module.select(conn, where={'cod_playlist': playlist_id}))
        user_input = input().lower()
        if user_input != 'q':
            try:
                number_input = int(user_input)
                vezes_tocadas = play_mus_sql_module.select(conn, where={'cod_musica': number_input, 'cod_playlist': playlist_id})[0]["numero_de_vezes_tocada"]
                #print("vezes_tocadas", vezes_tocadas)
                play_mus_sql_module.update(conn, 
                                           {'cod_musica': number_input, 
                                            'cod_playlist': playlist_id, 
                                            'numero_de_vezes_tocada': vezes_tocadas + 1,
                                            'ultima_vez_tocada': str(date.today())}, 
                                           {'cod_musica': number_input, 
                                            'cod_playlist': playlist_id})
                print("Musica tocada com sucesso")
            except:
                print("Insira um valor válido")

def playPlaylist(conn):
    playlist_sql_module = import_module('controllers.sql.playlist')
    user_input = ''

    while user_input.lower() != 'q':
        print("Escolha uma playlist ou aperte q para sair:")
        playlist_sql_module.printList(playlist_sql_module.select(conn))
        user_input = input()
        if user_input.lower() != 'q':
            try:
                number_input = int(user_input)
                playPlaylistTracks(conn, number_input)
            except:
                print("Insira um valor válido")


def playlistMenu(conn):
    playlist_input_module = import_module('controllers.input.playlist')
    playlist_sql_module = import_module('controllers.sql.playlist')
    input_number = 0

    while input_number != 6:
        print("Tabela escolhida: Playlist")
        print("Escolha uma das tabelas (digite o número):")
        print("1. Select")
        print("2. Insert")
        print("3. Update")
        print("4. Delete")
        print("5. Tocar Playlist")
        print("6. Sair")

        input_number = int(input())
        if (input_number not in range(1, 7)):
            print('Insira um número válido!')
    
        if input_number == 1:
            playlist_sql_module.printList(playlist_input_module.select(conn))
        elif input_number == 2:
            handlePlaylistCreation(conn)
        elif input_number == 3:
            handlePlaylistUpdate(conn)
        elif input_number == 4:
            playlist_input_module.delete(conn)
        elif input_number == 5:
            playPlaylist(conn)

def viewsFunctionsMenu(conn):
    compositor_sql_module = import_module('controllers.sql.compositor')
    view_sql_module = import_module('controllers.sql.views')
    input_number = 0

    while input_number != 8:
        print("Tabela escolhida: Views")
        print("Escolha uma das views ou função para fazer select:")
        print("1. View: playlistsClassicas")
        print("2. View: compositorMaisTrabalhador")
        print("3. View: DvoracEhOMior")
        print("4. View: albumsCaros")
        print("5. View: mostrarPlaylistsComMusicas")
        print("6. View: mostrarAlbunsComFaixas")
        print("7. View: visaoPlaylist")
        print("8. Função: ObterAlbumsPorCompositor")
        print("9. Sair")

        input_number = int(input())
        if (input_number not in range(1, 10)):
            print('Insira um número válido!')
    
        if input_number == 1:
            view_sql_module.printList(view_sql_module.selectPlaylistsClassicas(conn))
        elif input_number == 2:
            view_sql_module.printList(view_sql_module.selectCompositorMaisTrabalhador(conn))
        elif input_number == 3:
            view_sql_module.printList(view_sql_module.selectDvoracEhOMior(conn))
        elif input_number == 4:
            view_sql_module.printList(view_sql_module.selectAlbumsCaros(conn))
        elif input_number == 5:
            view_sql_module.printList(view_sql_module.selectMostrarPlaylistsComMusicas(conn))
        elif input_number == 6:
            view_sql_module.printList(view_sql_module.selectMostrarAlbunsComFaixas(conn))
        elif input_number == 7:
            view_sql_module.printList(view_sql_module.selectVisaoPlaylist(conn))
        elif input_number == 8:
            print("Insira o nome de um compositor:")
            compositor_sql_module.printList(compositor_sql_module.select(conn))
            input_nome = input()
            view_sql_module.printList(view_sql_module.selectFuncaoObterAlbumsPorCompositor(conn, input_nome))
        

def escolhaTabela(conn):
    print("\nEscolha uma das tabelas (digite o número):")
    print(" 1. Album")
    print(" 2. Compositor")
    print(" 3. Mídia_fisica")
    print(" 4. Faixa")
    print(" 5. Mídia_musica")
    print(" 6. Compositor_musica")
    print(" 7. Playlist")
    print(" 8. Musica_playlist")
    print(" 9. Gravadora")
    print("10. Interprete")
    print("11. Interprete_musica")
    print("12. Tipo_de_composição")
    print("13. Telefones")
    print("14. Views e Funções")
    print("15. Sair")

    input_number = int(input()) - 1
    while (input_number not in range(0, 16)):
        print('Insira um número válido!')
        input_number = int(input()) - 1
    
    return tabelas[input_number]

def escolherAçãoTabela(conn, tabela):
    if tabela == 'playlist':
        playlistMenu(conn)
    elif tabela == 'views':
        viewsFunctionsMenu(conn)
    else: 
        dynamic_input_module = import_module('controllers.input.' + tabela)
        dynamic_sql_module = import_module('controllers.sql.' + tabela)
        input_number = 0

        while input_number != 5:
            print("\nTabela escolhida: " + tabela.upper())
            print("\nEscolha uma das opções (digite o número):")
            print("1. Select")
            print("2. Insert")
            print("3. Update")
            print("4. Delete")
            print("5. Sair")

            input_number = int(input())
            if (input_number not in range(1, 6)):
                print('Insira um número válido!')
        
            if input_number == 1:
                dynamic_sql_module.printList(dynamic_input_module.select(conn))
            elif input_number == 2:
                dynamic_input_module.insert(conn)
            elif input_number == 3:
                dynamic_input_module.update(conn)
            elif input_number == 4:
                dynamic_input_module.delete(conn)

def menu(conn):
    tabela = ''
    while tabela != 'sair':
        tabela = escolhaTabela(conn)
        if tabela != 'sair':
            escolherAçãoTabela(conn, tabela)