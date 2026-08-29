class_name Tile extends RefCounted

var position: Vector2
var tile_index: int

func _init(p_position: Vector2 = Vector2.ZERO, p_tile_index: int = 0) -> void:
	position = p_position
	tile_index = p_tile_index
