extends Node2D
class_name LevelParent


func _on_exit_area_body_entered(body):
	if body is Player:
		Globals.next_spawn = "SpawnBedroom"
		$Player/AnimatedSprite2D.play("idle")
		var tween = create_tween()
		tween.tween_property($Player, "speed", 0, 0.5)
		TransitionLayer.change_scene("res://scenes/inside.tscn")
