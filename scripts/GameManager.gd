extends Node

var players = {}
var player_count = 0

func add_player(id):
	player_count += 1
	var custom_name = "Player" + str(player_count)
	var team = 1 if (player_count % 2 != 0) else 2
	
	players[id] = {"name": custom_name, "team": team}
	
	print("Novo jogador: ", custom_name, " no Time ", team)
