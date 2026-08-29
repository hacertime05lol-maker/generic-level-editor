extends Camera2D

const zoom_strenght: float = 1
const zoom_lerp_speed: float = 16
const min_zoom: float = 0.1
const max_zoom: float = 500
const zoom_factor: float = 1.1

var move_camera: bool = false
var target_zoom: float

func _ready() -> void:
	target_zoom = zoom.x

func _unhandled_input(event: InputEvent) -> void:
	handle_camera_zooming(event)
	handle_camera_dragging(event)

func handle_camera_dragging(event: InputEvent) -> void:
	if event.is_action_pressed("move_camera_button"):
		move_camera = true
	elif event.is_action_released("move_camera_button"):
		move_camera = false
	
	if event is InputEventMouseMotion and move_camera:
		position -= event.relative * (1.0 / zoom.x)

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
