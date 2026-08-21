class_name Tile extends RefCounted

@export var id: int = 0
@export var position: Vector2 = Vector2(0, 0)

func _init(p_id: int = 0, p_position: Vector2 = Vector2(0, 0)) -> void:
	id = p_id
	position = p_position
