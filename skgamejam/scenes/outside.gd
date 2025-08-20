extends LevelParent

func _ready():
	
	if Globals.next_spawn == "SpawnStrossa":
		var spawn = $SpawnStrossa
		if spawn:
			$Player.global_position = spawn.global_position
	if Globals.next_spawn == "SpawnCanvas":
		var spawn = $SpawnCanvas
		if spawn:
			$Player.global_position = spawn.global_position

func _on_stable_player_entered():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1.7,1.7), 1)
	
func _on_stable_player_left():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1.5,1.5), 1)
	
func _on_hill_entered_player_entered_hill():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.5,0.5), 2)
	var tween_offset = get_tree().create_tween()
	tween_offset.tween_property($Player/Camera2D, "offset", Vector2(0,-500), 2)

func _on_hill_entered_player_left_hill():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1.5,1.5), 2)
	var tween_offset = get_tree().create_tween()
	tween_offset.tween_property($Player/Camera2D, "offset", Vector2(0,0), 2)

func _on_enter_strossa_player_entered_strossa():
	Globals.next_spawn = "SpawnOutside"
	$Player/AnimatedSprite2D.play("idle")
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	TransitionLayer.change_scene("res://scenes/inside.tscn")

func _on_painting_canvas_player_in_range(success: bool):
	if success:
		print("okia")
