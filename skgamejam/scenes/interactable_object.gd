extends Node2D
class_name Interactable_Object

var player_in_range := false

func _on_body_entered(body: Node):
	if body.name == "Player":
		player_in_range = true

func _on_body_exited(body: Node):
	if body.name == "Player":
		player_in_range = false

func _process(_delta:float) -> void:
	if player_in_range and Input.is_action_just_pressed("BasicAction"):
		print("ok")
