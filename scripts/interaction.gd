extends Node2D

@export var tile_manager: TileManager
@export var save_load: SaveLoad
@export var mode_manager: ModeManager

func _process(_delta: float) -> void:
	if Input.is_action_pressed("interaction_0"):
		var mouse_position := get_global_mouse_position().snapped(Vector2(tile_manager.TILE_SIZE, tile_manager.TILE_SIZE))
		if tile_manager.is_tile_at_position(mouse_position) == false:
			tile_manager.spawn_tile(mouse_position)
	
	if Input.is_action_pressed("interaction_1"):
		var mouse_position := get_global_mouse_position().snapped(Vector2(tile_manager.TILE_SIZE, tile_manager.TILE_SIZE))
		var tiles: Array[Node] = tile_manager.get_tiles_at_position(mouse_position)
		for spawned_tile in tiles:
			spawned_tile.queue_free()
	
	if Input.is_action_just_pressed("save"):
		save_load.save_level()
	
	if Input.is_action_just_pressed("change_mode"):
		mode_manager.switch_editor_mode()
