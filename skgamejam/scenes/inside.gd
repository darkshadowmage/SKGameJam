extends LevelParent

@onready var slots_a = $Gallery/BoxContainerA.get_children()
@onready var slots_b = $Gallery/BoxContainerB.get_children()

func _ready():
	load_saved_canvases()

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
		if i < slots_a.size():
			slots_a[i].texture = tex
		elif i < slots_a.size() + slots_b.size():
				slots_b[i - slots_a.size()].texture = tex
		else:
			break  # No more slots available

func _numeric_sort(a: String, b: String) -> bool:
	var num_a = int(a.get_basename().get_slice("_", 1))
	var num_b = int(b.get_basename().get_slice("_", 1))
	return num_a < num_b

func _on_exit_area_body_entered(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	TransitionLayer.change_scene("res://scenes/outside.tscn")

func _on_delete_gallery_pressed() -> void:
	var gallery_path = "user://gallery_images"
	var dir = DirAccess.open(gallery_path)
	if dir == null:
		return
		
	for file_name in dir.get_files():
		dir.remove(file_name)
