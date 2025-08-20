extends Area2D

signal player_entered_hill
signal player_left_hill

func _on_body_entered(body):
	if body is Player:
		player_entered_hill.emit()

func _on_body_exited(body:):
	if body is Player:
		player_left_hill.emit()
