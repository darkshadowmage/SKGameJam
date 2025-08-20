extends Node2D

signal player_in_range(success: bool)
signal player_not_in_range(player_close_enough)

var player_close: bool = false

func _on_area_2d_body_entered(body):
	if body is Player:
		player_close = true
		player_in_range.emit(player_close)
	
func _on_area_2d_body_exited(body):
	if body is Player:
		player_close = false
		player_not_in_range.emit(player_close)
		print("ok")
		
func _process(_delta: float):
	if player_close and Input.is_action_just_pressed("BasicAction"):
		Globals.next_spawn = "SpawnCanvas"
		TransitionLayer.change_scene("res://scenes/canvas.tscn")
