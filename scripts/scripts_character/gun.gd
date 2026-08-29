extends StaticBody2D
class_name Pickable

var bullet = preload("res://prefabs/bullet.tscn")

var shoot_cooldown: float = 0.15
var time_since_last_shot: float = 0.0

#var is_picked: bool = false

func change_sprite(direction) -> void:
	if direction is float or direction is int:
		if direction > 0:
			$Sprite2D.texture = preload("res://sprite/gun/gun_right.png")
		elif direction < 0:
			$Sprite2D.texture = preload("res://sprite/gun/gun_left.png")
		return
	else:
		if direction.x > 0:
			$Sprite2D.texture = preload("res://sprite/gun/gun_right.png")
		elif direction.x < 0:
			$Sprite2D.texture = preload("res://sprite/gun/gun_left.png")
		elif direction.y > 0:
			$Sprite2D.texture = preload("res://sprite/gun/gun_front.png")
		elif direction.y < 0:
			$Sprite2D.texture = preload("res://sprite/gun/gun_back.png")

func _process(delta: float) -> void:
	if time_since_last_shot > 0:
		time_since_last_shot -= delta
#	if is_picked:
	var player = get_parent()
	change_sprite(player.current_direction) 
	if Input.is_action_pressed("enter") and time_since_last_shot <= 0:
		shoot(player.current_direction)
		time_since_last_shot = shoot_cooldown
			

func shoot(direction: Vector2):
	var player = get_parent()
	var b = bullet.instantiate()
	get_tree().current_scene.add_child(b)
	if direction == Vector2.ZERO: direction = Vector2.UP
	var spawn_offset = direction * 20.0 
	b.global_position = global_position + spawn_offset
	b.direction = direction
