extends Node2D

@export var player_scene: PackedScene = preload("res://scenes/Player.tscn")
@export var team_map: int = 1 # 1 para ForaEsquerda, 2 para ForaDireita

@onready var center_point = $CenterPoint # Pode ser um Marker2D no centro ou Vector2.ZERO
@onready var players_container = $PlayersContainer

func _ready() -> void:
	if multiplayer.is_server():
		spawn_players()

func spawn_players() -> void:
	# Filtra apenas os jogadores pertencentes a este time/mapa
	var team_players: Array = []
	for peer_id in GameManager.players:
		if GameManager.players[peer_id]["team"] == team_map:
			team_players.append(peer_id)
			
	var total_players: int = team_players.size()
	if total_players == 0:
		return

	var center_pos: Vector2 = center_point.global_position if center_point else Vector2.ZERO
	var radius: float = 60.0 # Raio do círculo em pixels
	
	for i in range(total_players):
		var peer_id = team_players[i]
		var player_instance = player_scene.instantiate()
		
		player_instance.name = str(peer_id)
		
		# Calcula o ângulo e o offset em círculo para cada jogador
		var angle = i * (2 * PI / total_players)
		var offset = Vector2(cos(angle), sin(angle)) * radius
		
		player_instance.global_position = center_pos + offset
		
		players_container.add_child(player_instance, true)
		player_instance.set_multiplayer_authority(peer_id)
