extends Control

@export var tiles_list: ItemList
@export var tile_manager: TileManager

func _ready() -> void:
	call_deferred("populate_tiles_list")

func populate_tiles_list() -> void:
	for tile_texture in tile_manager.tile_textures:
		tiles_list.add_icon_item(tile_texture)
