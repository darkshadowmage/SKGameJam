extends Area2D

signal player_entered_hill
signal player_left_hill

func _on_body_entered(_body):
	player_entered_hill.emit()

func _on_body_exited(_body:):
	player_left_hill.emit()
