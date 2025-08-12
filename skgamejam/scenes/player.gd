extends CharacterBody2D

func _process(_delta):
	
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * 500
	move_and_slide()
	
	look_at(get_global_mouse_position())
	
	#var player_direction = (get_global_mouse_position() - position).normalized()
				

	
