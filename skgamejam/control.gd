extends Control


func _on_play_pressed():
	TransitionLayer.change_scene("res://scenes/bedroom.tscn")

func _on_exit_pressed():
	get_tree().quit()
