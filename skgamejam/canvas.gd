extends Control

# Canvas size
var canvas_width = 600
var canvas_height = 800

# Brush settings
var brush_size = 10
var brush_color = Color(0, 0, 0)  # Default brush color is black

# Store the drawn lines
var current_line = []

# For drawing
var drawing = false

# Used for canvas clearing and storing the drawing
var lines = []

func _ready():
	# Set the size of the canvas (this node)
	var canvas_background = ColorRect.new()
	canvas_background.color = Color(1, 1, 1)  # White background for the canvas
	canvas_background.size = Vector2(canvas_width, canvas_height)
	add_child(canvas_background)
	
	# Enable input processing for mouse events
	set_process_input(true)

func _process(delta):
	# This function is used to update the view (this is where we redraw the lines)
	queue_redraw()

func _draw():
	# Draw all the lines stored in the 'lines' array
	for line in lines:
		draw_polyline(line, brush_color, brush_size, true)

	# Draw the current line the user is drawing (if any)
	if current_line.size() > 1:
		draw_polyline(current_line, brush_color, brush_size, true)

func _input(event):
	# Handle mouse input events
	if event is InputEventMouseMotion:
		if drawing:
			# If the mouse is moving and the user is holding the left mouse button
			current_line.append(event.position)
			queue_redraw()  # Redraw the canvas

	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Start drawing when the mouse button is pressed
				drawing = true
				current_line = [event.position]  # Start a new line at the mouse position
			else:
				# Stop drawing when the mouse button is released
				if current_line.size() > 1:
					lines.append(current_line)  # Save the completed line
				drawing = false
				current_line = []  # Clear the current line

# Additional method to clear the canvas (reset the drawing)
func clear_canvas():
	lines.clear()
	current_line.clear()
	queue_redraw()
