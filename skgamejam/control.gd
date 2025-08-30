extends Control

func _ready():
	MusicController.play_music()

func _on_play_pressed():
	TimerManager.start_restart_timer()
	TransitionLayer.change_scene("res://scenes/bedroom.tscn")
	MusicController.play_music()

func _on_exit_pressed():
		get_tree().quit()
