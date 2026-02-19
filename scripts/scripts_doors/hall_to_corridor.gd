extends Area2D

var entered: bool = false
var player: CharacterBody2D

func _process(delta: float) -> void:
	if entered and Input.is_action_just_pressed("enter"):
		GameState.player_position_hall = player.global_position
		get_tree().change_scene_to_file("res://scenes/corredor.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		entered = true
		player = body

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		entered = false
		player = null
