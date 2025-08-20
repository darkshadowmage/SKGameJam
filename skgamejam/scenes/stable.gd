extends StaticBody2D

signal player_entered
signal player_left

func _on_hide_area_body_entered(body):
	if body is Player:
		player_entered.emit()

func _on_hide_area_body_exited(body):
	if body is Player:
		player_left.emit()
