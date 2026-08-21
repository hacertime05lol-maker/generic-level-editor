extends Node2D

@export var main: Main
@export var save_load: SaveLoad

func _process(_delta: float) -> void:
	if Input.is_action_pressed("interaction_0"):
		var mouse_position := get_global_mouse_position().snapped(Vector2(main.TILE_SIZE, main.TILE_SIZE))
		if main.is_tile_at_position(mouse_position) == false:
			main.spawn_tile(mouse_position)
	
	if Input.is_action_pressed("interaction_1"):
		var mouse_position := get_global_mouse_position().snapped(Vector2(main.TILE_SIZE, main.TILE_SIZE))
		var tiles: Array[Node] = main.get_tiles_at_position(mouse_position)
		for spawned_tile in tiles:
			spawned_tile.queue_free()
	
	if Input.is_action_just_pressed("save"):
		save_load.save_level()
