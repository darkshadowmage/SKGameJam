extends Node

var restart_timer: SceneTreeTimer

func start_restart_timer():
	if restart_timer:
		restart_timer = null

	print("Restart timer started (10 min)")
	restart_timer = get_tree().create_timer(600)  # 600 seconds = 10 minutes
	await restart_timer.timeout
	restart_game()

func restart_game():
	print("Restarting current scene...")
	TransitionLayer.change_scene("res://scenes/menu.tscn")
	
