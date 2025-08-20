extends CharacterBody2D
class_name Player

@export var max_speed: int = 225
var speed: int = max_speed

func _process(_delta):
	
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_just_pressed("Right"):
		$AnimatedSprite2D.play("walking_right")
		
	if Input.is_action_just_pressed("Left"):
		$AnimatedSprite2D.play("walking_left")
		
	if Input.is_anything_pressed() == false:
		$AnimatedSprite2D.play("idle")
				

	
