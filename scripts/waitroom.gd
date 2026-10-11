extends Control

@onready var lista_t1 = $Panel1/ListaJogadores1
@onready var lista_t2 = $Panel2/ListaJogadores2
@onready var button = $Button

func _ready():
	# Oculta o botão por padrão para todos
	button.visible = false
	
	# Apenas o servidor gerencia a entrada oficial
	if multiplayer.is_server():
		# Mostra o botão apenas se for o servidor
		button.visible = true
		
		multiplayer.peer_connected.connect(_on_player_connected)
		# Adiciona o próprio Host (Servidor) como Player1
		_on_player_connected(1)

func _on_player_connected(id):
	GameManager.add_player(id)
	
	update_clients_list.rpc(GameManager.players)

@rpc("authority", "call_local")
func update_clients_list(server_players_dict):
	GameManager.players = server_players_dict
	refresh_ui()

func refresh_ui():
	for n in lista_t1.get_children(): n.queue_free()
	for n in lista_t2.get_children(): n.queue_free()
	
	for id in GameManager.players:
		var p_info = GameManager.players[id]
		var label = Label.new()
		label.text = p_info["name"]
		
		if p_info["team"] == 1:
			lista_t1.add_child(label)
		else:
			lista_t2.add_child(label)


func _on_button_pressed() -> void:
	if multiplayer.is_server():
		iniciar_partida_rpc.rpc()
		
@rpc("authority", "call_local")
func iniciar_partida_rpc():
	var meu_id = multiplayer.get_unique_id()
	
	if GameManager.players.has(meu_id):
		var meu_time = GameManager.players[meu_id]["team"]
		if meu_time == 1:
			get_tree().change_scene_to_file("res://scenes/ForaEsquerda.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/ForaDireita.tscn")
