extends CharacterBody2D

var current_state = WALK_RIGHT
var is_chatting = false
var player
var player_in_chat_zone = false

enum 
{
	WALK_RIGHT,
	WALK_LEFT
}

func _process(_delta):
	if current_state == 0:
		$Slugma.play("walk_right")
	elif current_state == 1:
		$Slugma.play("walk_left")
	
func _on_chat_detection_area_body_exited(_body):
	player_in_chat_zone = false

func _input(event):
	if event.is_action_pressed("BasicAction") and player_in_chat_zone:
		$DialogueSlugma.start()
		is_chatting = true

func _on_slugma_detect_body_entered(body):
	if body is Player:
		player_in_chat_zone = true
		var tween = get_tree().create_tween()
		tween.tween_property($"../../Player/Camera2D", "zoom", Vector2(1.7,1.7), 1)

func _on_slugma_detect_body_exited(body):
	if body is Player:
		player_in_chat_zone = false
		var tween = get_tree().create_tween()
		tween.tween_property($"../../Player/Camera2D", "zoom", Vector2(1.5,1.5), 1)

func _on_dialogue_slugma_dialogue_finished():
	is_chatting = false
