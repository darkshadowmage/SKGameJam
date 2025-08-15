extends Area2D

signal player_entered_strossa

func _on_body_entered(_body:):
	player_entered_strossa.emit()
