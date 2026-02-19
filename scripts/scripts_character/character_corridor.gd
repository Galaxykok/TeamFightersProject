extends CharacterBody2D

var SPEED = 100.0
const JUMP_VELOCITY = -200.0

func _ready() -> void:
	pass

func change_sprite(direction) -> void:
	if direction > 0:
		$Sprite2D.texture = preload("res://sprite/characters/right.png")
	if direction < 0:
		$Sprite2D.texture = preload("res://sprite/characters/left.png")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	SPEED = 150.0 if Input.is_action_pressed("run") else 100.0
	if direction:
		velocity.x = direction * SPEED
		change_sprite(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
