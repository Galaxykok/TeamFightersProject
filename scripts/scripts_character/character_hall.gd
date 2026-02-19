extends CharacterBody2D

var speed = 100.0
var entered = false

var is_in_range: bool = false
var target_object: Node2D
@onready var hand_position: Marker2D =  $HandPosition

var current_direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	if GameState.player_position_hall != null:
		global_position = GameState.player_position_hall

func change_sprite(direction: Vector2) -> void:
	if direction.x > 0:
		$Sprite2D.texture = preload("res://sprite/characters/right.png")
	elif direction.x < 0:
		$Sprite2D.texture = preload("res://sprite/characters/left.png")
	elif direction.y > 0:
		$Sprite2D.texture = preload("res://sprite/characters/front.png")
	elif direction.y < 0:
		$Sprite2D.texture = preload("res://sprite/characters/back.png")

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	if direction != Vector2.ZERO:
		current_direction = direction
	speed = 150.0 if Input.is_action_pressed("run") else 100.0
	velocity = direction * speed
	pickup_object()
	change_sprite(direction)
	move_and_slide()

func pickup_object() -> void:
	if is_in_range:
		if Input.is_action_just_pressed("enter"):
			target_object.reparent(hand_position)
			target_object.position = hand_position.position
			target_object.is_picked = true

func _on_range_body_entered(body: Node2D) -> void:
	print("a")
	if body is Pickable:
		is_in_range = true
		target_object = body

func _on_range_body_exited(body: Node2D) -> void:
	if body is Pickable:
		is_in_range = false
		target_object = null
