extends Node2D

@onready  var audiostreamer: AudioStreamPlayer = $AudioStreamPlayer

func play_music():
	print("ok")
	audiostreamer.stream = preload("res://music/StrossaGame_Import_new.wav")
	audiostreamer.play()
	
