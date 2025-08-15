extends LevelParent

func _on_exit_area_body_entered(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	get_tree().change_scene_to_file("res://scenes/outside.tscn")
