class_name SaveLoad extends Node

@export var main: Main
const path: String = "user://save.json"

func _ready() -> void:
	load_level()

func save_level() -> void:
	var file := FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		printerr(error_string(FileAccess.get_open_error()))
		return
	
	var level: Array[Tile] = []
	
	for spawned_tile in main.get_all_tiles():
		var tile := Tile.new(0, spawned_tile.global_position)
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
				main.spawn_tile(tile.position)
