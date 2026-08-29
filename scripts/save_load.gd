class_name SaveLoad extends Node

@export var tile_manager: TileManager
const path: String = "user://save.json"

func _ready() -> void:
	call_deferred("load_level")

func save_level() -> void:
	var file := FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		printerr(error_string(FileAccess.get_open_error()))
		return
	
	var level: Array[Tile] = []
	
	for spawned_tile in tile_manager.get_all_tiles():
		var spawned_tile_data: SpawnedTileData = spawned_tile as SpawnedTileData
		var tile := Tile.new(spawned_tile_data.tile_name, spawned_tile.global_position)
		level.append(tile)
	
	file.store_var(level, true)
	file.close()

func load_level() -> void:
	if FileAccess.file_exists(path):
		var file := FileAccess.open(path, FileAccess.READ)
		if file == null:
			printerr(error_string(FileAccess.get_open_error()))
			return
		
		var level: Array[Tile] = file.get_var(true)
		file.close()
		
		if level != null:
			for tile in level:
				tile_manager.spawn_tile(tile.position, tile.tile_name)

func delete_level() -> void:
	if FileAccess.file_exists(path):
		var delete_status = DirAccess.remove_absolute(path)
		if delete_status != OK:
			push_error("Failed to delete level file. Error code: ", delete_status)
