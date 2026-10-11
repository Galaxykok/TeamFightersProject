extends CharacterBody2D

var max_distance: float = 500.0
var speed: float = 400.0
var direction: Vector2 = Vector2.ZERO
var start_position: Vector2

func _ready() -> void:
	start_position = global_position

func _physics_process(delta: float) -> void:
	var motion = direction * speed * delta
	var collision = move_and_collide(motion)

	if collision:
		queue_free()
		return

	if global_position.distance_to(start_position) >= max_distance:
		queue_free()
