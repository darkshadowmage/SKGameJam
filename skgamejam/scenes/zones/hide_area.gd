extends Area2D

func _on_body_entered(body):
	if body is Player:
		
		print("hello")
		var parent = get_parent()
		parent.modulate.a = 0.2

func _on_body_exited(body):
	if body is Player:
		print("bye")
		var parent = get_parent()
		parent.modulate.a = 1
