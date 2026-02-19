extends StaticBody2D
class_name Pickable

var bullet = preload("res://prefabs/bullet.tscn")

var shoot_cooldown: float = 0.15
var time_since_last_shot: float = 0.0

var is_picked: bool = false

func change_sprite(direction: Vector2) -> void:
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
	if is_picked:
		var player = get_parent().get_parent()
		change_sprite(player.current_direction) 
		if Input.is_action_pressed("enter") and time_since_last_shot <= 0:
			shoot(player.current_direction)
			time_since_last_shot = shoot_cooldown
			

func shoot(direction: Vector2):
	var player = get_parent().get_parent()
	var b = bullet.instantiate()
	owner.add_child(b)
	var spawn_offset = direction * 15.0 
	b.global_position = global_position + spawn_offset
	b.direction = direction
