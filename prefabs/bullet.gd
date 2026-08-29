extends CharacterBody2D

var max_distance = 500.0
var direction = Vector2.ZERO

@onready var start_position = global_position

func _physics_process(delta: float) -> void:
	var velocity = 400
	var motion = direction * velocity * delta
	var collision = move_and_collide(motion)

	if collision:
		queue_free()

	if global_position.distance_to(start_position) >= max_distance:
		queue_free()
