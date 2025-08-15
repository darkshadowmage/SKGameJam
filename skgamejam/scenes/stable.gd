extends StaticBody2D

signal player_entered
signal player_left

func _on_hide_area_body_entered(_body):
	player_entered.emit()

func _on_hide_area_body_exited(_body):
	player_left.emit()
