extends Node2D

signal player_in_range(success: bool)
signal player_not_in_range(player_close_enough)

var player_close: bool = false

func _on_area_2d_body_entered(_body):
	player_close = true
	player_in_range.emit(player_close)
	print("ok")
	
func _on_area_2d_body_exited(_body):
	player_close = false
	player_not_in_range.emit(player_close)
	print("ok")
	
func _process(_delta: float) -> void:
	if player_close and Input.is_action_just_pressed("BasicAction"):
		TransitionLayer.change_scene("res://scenes/canvas.tscn")
