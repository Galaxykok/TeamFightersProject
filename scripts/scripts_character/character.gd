extends CharacterBody2D

var speed = 100.0
var team = 1
var platform = false
#var is_in_range: bool = false
#var target_object: Node2D
#@onready var hand_position: Marker2D =  $HandPosition
const JUMP_VELOCITY = -400.0

var current_direction = Vector2.ZERO

func _ready() -> void:
	pass

func change_sprite(direction) -> void:
	# Se for o modo plataforma, a direção será apenas um número (float)
	if team == 1:
		if direction is float or direction is int:
			if direction > 0:
				$Sprite2D.texture = preload("res://sprite/characters/right.png")
			elif direction < 0:
				$Sprite2D.texture = preload("res://sprite/characters/left.png")
			return

		if direction.x > 0:
			$Sprite2D.texture = preload("res://sprite/characters/right.png")
		elif direction.x < 0:
			$Sprite2D.texture = preload("res://sprite/characters/left.png")
		elif direction.y > 0:
			$Sprite2D.texture = preload("res://sprite/characters/front.png")
		elif direction.y < 0:
			$Sprite2D.texture = preload("res://sprite/characters/back.png")
	else:
		if direction is float or direction is int:
			if direction > 0:
				$Sprite2D.texture = preload("res://sprite/characters/right2.png")
			elif direction < 0:
				$Sprite2D.texture = preload("res://sprite/characters/left2.png")
			return

		if direction.x > 0:
			$Sprite2D.texture = preload("res://sprite/characters/right2.png")
		elif direction.x < 0:
			$Sprite2D.texture = preload("res://sprite/characters/left2.png")
		elif direction.y > 0:
			$Sprite2D.texture = preload("res://sprite/characters/front2.png")
		elif direction.y < 0:
			$Sprite2D.texture = preload("res://sprite/characters/back2.png")

func _physics_process(delta: float) -> void:
	if platform:
		_move_platform(delta)
	else:
		_move_top_down(delta)
		
	move_and_slide()
	
func _move_top_down(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	if direction != Vector2.ZERO:
		current_direction = direction
		
	speed = 130.0 if Input.is_action_pressed("run") else 80.0
	velocity = direction * speed
	change_sprite(direction)

func _move_platform(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")
	speed = 150.0 if Input.is_action_pressed("run") else 100.0
	
	if direction != 0:
		velocity.x = direction * speed
		current_direction = direction
		change_sprite(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
#func pickup_object() -> void:
	#if is_in_range:
		#if Input.is_action_just_pressed("enter"):
			#target_object.reparent(hand_position)
			#target_object.position = hand_position.position
			#target_object.is_picked = true
#
#func _on_range_body_entered(body: Node2D) -> void:
	#print("a")
	#if body is Pickable:
		#is_in_range = true
		#target_object = body
#
#func _on_range_body_exited(body: Node2D) -> void:
	#if body is Pickable:
		#is_in_range = false
		#target_object = null
