extends Camera2D

var previous_position: Vector2 = Vector2.ZERO
var move_camera: bool = false

func _unhandled_input(event: InputEvent) -> void:
	handle_camera_dragging(event)
	handle_camera_zooming(event)

func handle_camera_dragging(event: InputEvent) -> void:
	if event.is_action_pressed("move_camera_button"):
		previous_position = get_global_mouse_position()
		move_camera = true
	elif event.is_action_released("move_camera_button"):
		move_camera = false
	
	if event is InputEventMouseMotion and move_camera:
		position += previous_position - get_global_mouse_position()

func handle_camera_zooming(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var scroll_delta: float = 0
		
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			scroll_delta = event.factor
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			scroll_delta = -event.factor
		
		if (zoom.x + scroll_delta) <= 0:
			return
		
		zoom.x += scroll_delta
		zoom.y += scroll_delta
