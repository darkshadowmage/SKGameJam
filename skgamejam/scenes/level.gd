extends Node2D
class_name LevelParent


func _on_exit_area_body_entered(_body:):
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	TransitionLayer.change_scene("res://scenes/inside.tscn")
