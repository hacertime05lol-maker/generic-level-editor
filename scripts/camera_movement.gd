extends Camera2D

var previous_position: Vector2 = Vector2.ZERO
var move_camera: bool = false

var zoom_strenght: float = 1
var target_zoom: float
var zoom_lerp_speed: float = 16
var min_zoom: float = 0.1
var max_zoom: float = 500
var zoom_factor: float = 1.1

func _ready() -> void:
	target_zoom = zoom.x

func _unhandled_input(event: InputEvent) -> void:
	handle_camera_zooming(event)
	handle_camera_dragging(event)

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
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			target_zoom = clamp(target_zoom * zoom_factor * zoom_strenght, min_zoom, max_zoom)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			target_zoom = clamp(target_zoom / zoom_factor * zoom_strenght, min_zoom, max_zoom)

func _process(delta: float) -> void:
	if zoom.x != target_zoom:
		var new_zoom = lerp(zoom.x, target_zoom, zoom_lerp_speed * delta)
		zoom = Vector2(new_zoom, new_zoom)
