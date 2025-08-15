extends LevelParent

func _on_stable_player_entered():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1.2,1.2), 1)
	
func _on_hill_entered_player_entered_hill():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.5,0.5), 2)
	var tween_offset = get_tree().create_tween()
	tween_offset.tween_property($Player/Camera2D, "offset", Vector2(0,-500), 2)

func _on_stable_player_left():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1,1), 1)

func _on_hill_entered_player_left_hill():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1,1), 2)
	var tween_offset = get_tree().create_tween()
	tween_offset.tween_property($Player/Camera2D, "offset", Vector2(0,0), 2)

func _on_enter_strossa_player_entered_strossa():
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	get_tree().change_scene_to_file("res://scenes/inside.tscn")
