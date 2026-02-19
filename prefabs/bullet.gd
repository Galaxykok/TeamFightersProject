extends Node2D

var direction = Vector2.ZERO
var velocity = 400
var max_distance = 500.0
@onready var start_position = global_position # Guarda onde a bala nasceu

func _process(delta: float) -> void:
	# Movimentação
	position += direction * velocity * delta
	# distance_to compara a posição atual com a inicial
	if global_position.distance_to(start_position) >= max_distance:
		queue_free()
