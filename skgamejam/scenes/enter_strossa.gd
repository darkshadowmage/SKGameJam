extends Area2D

signal player_entered_strossa

func _on_body_entered(body:):
	if body is Player:
		player_entered_strossa.emit()
