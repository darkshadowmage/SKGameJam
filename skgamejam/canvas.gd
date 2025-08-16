extends Control

var canvas_size := Vector2i(256, 256)
var image: Image
var texture: ImageTexture
var drawing := false
var brush_color: Color = Color.BLACK

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

	if image_pos.x >= 0 and image_pos.y >= 0 and image_pos.x < canvas_size.x and image_pos.y < canvas_size.y:
		image.set_pixel(image_pos.x, image_pos.y, brush_color)
		texture = ImageTexture.create_from_image(image)
		$TextureRect.texture = texture


func _on_clear_pressed():
	image.fill(Color.WHITE)
	texture = ImageTexture.create_from_image(image)
	$TextureRect.texture = texture
	
func _on_save_pressed():
	# Ensure the save directory exists
	var dir = DirAccess.open("user://gallery_images")
	if dir == null:
		# Directory doesn't exist—let's create it
		DirAccess.make_dir_absolute("user://gallery_images")
		dir = DirAccess.open("user://gallery_images")
		if dir == null:
			push_error("Failed to open gallery_images even after creating it.")
			return
	
	var existing_files = dir.get_files()
	
	# Count existing images
	var max_index = 0
	for f in existing_files:
		if f.begins_with("painting_") and f.ends_with(".png"):
			var num_str = f.get_basename().get_slice("_", 1)
			var num = int(num_str)
			if num > max_index:
				max_index = num
	var next_index = max_index + 1
	var save_path = "user://gallery_images/painting_%d.png" % next_index

	var saver = image.save_png(save_path)
	if saver != OK:
		print("Failed to save image: ", saver)
	else:
		print("Saved painting to ", save_path)

func _on_back_pressed():
	TransitionLayer.change_scene("res://scenes/outside.tscn")
