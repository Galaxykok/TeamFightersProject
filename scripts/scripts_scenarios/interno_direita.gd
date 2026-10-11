extends Node2D

@export var player_scene: PackedScene = preload("res://prefabs/Character.tscn")
@export var team_map: int = 2 # Defina 1 para ForaEsquerda e 2 para ForaDireita no Inspector

@onready var spawn_points = $SpawnPoints
@onready var players_container = $PlayersContainer

func _ready() -> void:
	if multiplayer.is_server():
		spawn_players()

func spawn_players() -> void:
	var spawn_index = 0
	var spawns = spawn_points.get_children()

	for peer_id in GameManager.players:
		var player_info = GameManager.players[peer_id]
		
		# Instancia apenas os jogadores que pertencem ao time deste mapa
		if player_info["team"] == team_map:
			var player_instance = player_scene.instantiate()
			
			# 1. Atribui o ID da rede como nome do nó (Essencial para multiplayer)
			player_instance.name = str(peer_id)
			
			# 2. Posição inicial no ponto de Spawn
			if spawn_index < spawns.size():
				player_instance.global_position = spawns[spawn_index].global_position
				spawn_index += 1
			
			# 3. Adiciona ao container
			players_container.add_child(player_instance, true)
			
			# 4. Define a autoridade do nó para o jogador correspondente
			player_instance.set_multiplayer_authority(peer_id)
