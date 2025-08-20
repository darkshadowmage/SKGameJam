extends LevelParent

@onready var slots_a = $Gallery/BoxContainerA.get_children()
@onready var slots_b = $Gallery/BoxContainerB.get_children()
var slot_image_paths: Dictionary = {}
@onready var image_popup: PopupPanel = $Gallery/ImagePopUp
@onready var big_image_rect: TextureRect = $Gallery/ImagePopUp/BigPopUp

func _ready():
	load_saved_canvases()
	big_image_rect.custom_minimum_size = Vector2(512,512)
	
func _on_slot_button_pressed(image_path: String):
	var img = Image.load_from_file(image_path)
	if img == null:
		print("Could not load image at: ", image_path)
		return
	var tex = ImageTexture.create_from_image(img)
	big_image_rect.texture = tex
	image_popup.popup_centered()

func load_saved_canvases():
	var dir = DirAccess.open("user://gallery_images")
	if dir == null:
		print("Gallery directory not found.")
		return
	var files_psa = dir.get_files()
	var files = Array(files_psa)
	# Filter only .png files
	files = files.filter(func(f):
		return f.ends_with(".png")
		)
		# Sort files numerically by index (e.g. painting_1.png → 1)
	files.sort_custom(_numeric_sort)
	
	for i in range(files.size()):
		var path = "user://gallery_images/" + files[i]
		var img = Image.load_from_file(path)
		img.resize(32,32, Image.Interpolation.INTERPOLATE_BILINEAR)
		var tex = ImageTexture.create_from_image(img)
		
		var slot_node: TextureRect
		var button_node: Button
		
		if i < slots_a.size():
			slot_node = slots_a[i]
		elif i < slots_a.size() + slots_b.size():
				slot_node = slots_b[i - slots_a.size()]
		else:
			break 
		slot_node.texture = tex
		
		button_node = slot_node.get_node_or_null("Button")
		if button_node == null:
			print("⚠️ No Button found in slot: ", slot_node.name)
			continue
		if not button_node.pressed.is_connected(_on_slot_button_pressed):
			button_node.pressed.connect(func():
				_on_slot_button_pressed(path)
			)

func _numeric_sort(a: String, b: String) -> bool:
	var num_a = int(a.get_basename().get_slice("_", 1))
	var num_b = int(b.get_basename().get_slice("_", 1))
	return num_a < num_b
	
func _unhandled_input(event: InputEvent) -> void:
	if image_popup.visible:
		if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
			image_popup.hide()
		elif event is InputEventMouseButton and event.pressed:
			if not image_popup.get_global_rect().has_point(event.global_position):
				image_popup.hide()

func _on_exit_area_body_entered(body):
	if body is Player:
		var tween = create_tween()
		tween.tween_property($Player, "speed", 0, 0.5)
		TransitionLayer.change_scene("res://scenes/outside.tscn")

func _on_area_2d_body_exited(body):
	if body is Player:
		var tween = create_tween()
		tween.tween_property($Player, "speed", 0, 0.5)
		TransitionLayer.change_scene("res://scenes/bedroom.tscn")
