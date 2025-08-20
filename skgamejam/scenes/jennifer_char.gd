extends CharacterBody2D

var current_state = IDLE
var is_chatting = false
var player
var player_in_chat_zone = false

enum {
	IDLE
}

func _process(_delta):
	if current_state == 0:
		$Jennifer.play("default")

func _input(event):
	if event.is_action_pressed("BasicAction") and player_in_chat_zone:
		$DialogueKata.start()
		var tween = get_tree().create_tween()
		tween.tween_property($"../../Player/Camera2D", "zoom", Vector2(1.7,1.7), 1)
		is_chatting = true

func _on_area_2d_body_entered(body):
	if body is Player:
		player_in_chat_zone = true
		var tween = get_tree().create_tween()
		tween.tween_property($"../../Player/Camera2D", "zoom", Vector2(1.7,1.7), 1)

func _on_area_2d_body_exited(body):
	if body is Player:
		player_in_chat_zone = false
		var tween = get_tree().create_tween()
		tween.tween_property($"../../Player/Camera2D", "zoom", Vector2(1.5,1.5), 1)

func _on_dialogue_kata_dialogue_finished():
	is_chatting = false
