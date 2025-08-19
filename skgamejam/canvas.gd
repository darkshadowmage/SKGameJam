extends Control

var canvas_size := Vector2i(256, 256)
var image: Image
var texture: ImageTexture
var drawing := false
var brush_color: Color = Color.BLACK
var brush_size := 3

func _ready():
	# Create an image to draw on
	image = Image.create(canvas_size.x, canvas_size.y, false, Image.Format.FORMAT_RGBA8)
	image.fill(Color.WHITE)  # Start with white canvas

	texture = ImageTexture.create_from_image(image)
	$TextureRect.texture = texture
	
	$TextureRect.custom_minimum_size = canvas_size
	$TextureRect.scale = Vector2(2,2)
	
	var screen_size = get_viewport_rect().size
	var texture_size = Vector2(canvas_size) * $TextureRect.scale
	$TextureRect.position = (screen_size - texture_size) / 2
	$TextureRect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	$ColorPicker.color_changed.connect(_on_color_changed)
	$ColorPicker.set_pick_color(brush_color)
	
func _on_color_changed(new_color: Color) -> void:
	brush_color = new_color
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		drawing = event.pressed

	if event is InputEventMouseMotion and drawing:
		draw_at_mouse(event.position)

func draw_at_mouse(screen_pos: Vector2):
	var local_mouse = screen_pos - $TextureRect.global_position
	# Adjust for scale
	var scaled_pos = local_mouse / $TextureRect.scale
	# Convert to image pixel position
	var image_pos = Vector2i(scaled_pos)

	@warning_ignore("integer_division")
	for dx in range(-brush_size / 2, brush_size / 2 + 1):
		@warning_ignore("integer_division")
		for dy in range(-brush_size / 2, brush_size / 2 + 1):
			var x = image_pos.x + dx
			var y = image_pos.y + dy
			if x >= 0 and y >= 0 and x < canvas_size.x and y < canvas_size.y:
				image.set_pixel(x, y, brush_color)
				
	texture = ImageTexture.create_from_image(image)
	$TextureRect.texture = texture

func _on_clear_pressed():
	image.fill(Color.WHITE)
	texture = ImageTexture.create_from_image(image)
	$TextureRect.texture = texture
	
func _on_save_pressed():
	# Ensure the save directory exists
	var gallery_path = "user://gallery_images"
	DirAccess.make_dir_absolute(gallery_path)
	var dir = DirAccess.open(gallery_path)
	var max_slots = 23
	var file_name: String
	var files_psa = dir.get_files()
	var files = Array(files_psa)
	
	files = files.filter(func(f):
		return f.ends_with(".png")
		)
		# Sort files numerically by index (e.g. painting_1.png → 1)
	files.sort_custom(_numeric_sort)
	
	if files.size() >= max_slots:
		var oldest_file = files[0]
		dir.remove(oldest_file)
		
		var max_index = 0
		for f in files:
			var num_str = f.get_basename().get_slice("_", 1)
			var num = int(num_str)
			if num > max_index:
				max_index = num
			
			var next_index = max_index + 1
			file_name = "painting_%d.png" % next_index
	else:
		var max_index = 0
		for f in files:
			if f.begins_with("painting_") and f.ends_with(".png"):
				var num_str = f.get_basename().get_slice("_", 1)
				var num = int(num_str)
				if num > max_index:
					max_index = num
		var next_index = max_index + 1
		file_name = "painting_%d.png" % next_index
		
	var save_path = gallery_path + "/" + file_name
	var _saver = image.save_png(save_path)

func _on_back_pressed():
	TransitionLayer.change_scene("res://scenes/outside.tscn")


func _numeric_sort(a: String, b: String) -> bool:
	var num_a = int(a.get_basename().get_slice("_", 1))
	var num_b = int(b.get_basename().get_slice("_", 1))
	return num_a < num_b

func _on_brush_size_slider_value_changed(value: float) -> void:
	brush_size = int(value)
