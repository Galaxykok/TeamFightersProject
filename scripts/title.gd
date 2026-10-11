extends Control

const PORT = 7000 # Uma porta qualquer que esteja livre
const MAX_CLIENTS = 8

func _on_pressed() -> void:
	# Aqui decidimos se seremos o Servidor (Host)
	# Em um jogo simples, o primeiro que clica em Start geralmente é o Host
	create_host()

func create_host():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT, MAX_CLIENTS)
	
	if error != OK:
		print(error)
		return
		
	multiplayer.multiplayer_peer = peer
	print("Servidor Iniciado! Aguardando jogadores...")
	get_tree().change_scene_to_file("res://scenes/waitroom.tscn")
	
	# Após ligar o servidor, mudamos para a tela de times

func join_as_client(ip_do_host):
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip_do_host, PORT)
	multiplayer.multiplayer_peer = peer
	# O cliente também muda de cena ao tentar conectar
	get_tree().change_scene_to_file("res://scenes/waitroom.tscn")

func _on_quit_btn_pressed() -> void:
	get_tree().quit()
	
func _on_join_btn_pressed() -> void:
	join_as_client($"../LineEdit".text)
