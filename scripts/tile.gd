class_name Tile extends RefCounted

@export var tile_name: String
@export var position: Vector2

func _init(p_tile_name: String = "", p_position: Vector2 = Vector2.ZERO) -> void:
	tile_name = p_tile_name
	position = p_position
