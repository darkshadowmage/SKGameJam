extends Control

signal dialogue_finished()

var dialogue = []
var current_dialogue_id = 0
var d_active = false

func _ready():
	$NinePatchRect.modulate.a = 0

func start():
	if d_active:
		return
	d_active = true
	$NinePatchRect.modulate.a = 1
	dialogue = load_dialogue()
	print("Loaded dialogue:", dialogue)
	current_dialogue_id = -1
	next_script()
	
func load_dialogue():
	var file = FileAccess.open("res://dialogue/rosie_dialogue1.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content

func next_script():
	current_dialogue_id += 1
	
	if current_dialogue_id == dialogue.size():
		d_active = false
		$NinePatchRect.modulate.a = 0.0
		dialogue_finished.emit()
		return
	if current_dialogue_id > dialogue.size():
		return
	
	var entry = dialogue[current_dialogue_id]
	$NinePatchRect/Name.text = entry.get("name", "")
	$NinePatchRect/Text.text = entry.get("text", "")

func _input(event):
	if !d_active:
		return
	if event.is_action_pressed("BasicAction"):
		next_script()
