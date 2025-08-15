extends CharacterBody2D

@export var max_speed: int = 225
var speed: int = max_speed

func _process(_delta):
	
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed
	move_and_slide()
	
	#var player_direction = (get_global_mouse_position() - position).normalized()
				

	
