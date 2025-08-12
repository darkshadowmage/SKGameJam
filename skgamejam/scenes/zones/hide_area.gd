extends Area2D

func _on_body_entered(_body: CharacterBody2D):
	print("hello")
	var parent = get_parent()
	parent.modulate.a = 0.2

func _on_body_exited(_body: Node2D):
	print("bye")
	var parent = get_parent()
	parent.modulate.a = 1
