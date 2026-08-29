class_name TileManager extends Node2D

@export var tile: PackedScene
@export var tiles_parent_node: Node

var tile_textures_path: String = "res://art/tile_textures/"
var tile_textures: Array[Texture2D] = []

const tile_collision_mask: int = 2
const TILE_SIZE: int = 16

func _ready() -> void:
	load_tile_textures()

func spawn_tile(pos: Vector2, tile_name: String) -> void:
	var new_tile: Node = GodotUtils.instantiate(tile, tiles_parent_node, pos)
	
	var new_texture: Texture2D = null
	for texture in tile_textures:
		if GodotUtils.get_texture_name(texture) == tile_name:
			new_texture = texture
			break
	
	if new_texture == null:
		printerr("Texture not present!")
		return
	
	var tile_sprite: Sprite2D = new_tile.get_child(0) as Sprite2D
	tile_sprite.texture = new_texture
	
	var spawned_tile_data: SpawnedTileData = new_tile as SpawnedTileData
	spawned_tile_data.tile_name = tile_name

func is_tile_at_position(pos: Vector2) -> bool:
	return get_tiles_at_position(pos).size() > 0

func get_tiles_at_position(pos: Vector2) -> Array[Node]:
	var query := PhysicsPointQueryParameters2D.new()
	query.position = pos
	query.collide_with_areas = true
	query.collision_mask = tile_collision_mask
	
	var space_state := get_world_2d().direct_space_state
	var results := space_state.intersect_point(query)
	
	var tiles: Array[Node] = []
	for result in results:
		if result.has("collider") and is_instance_valid(result.collider):
			tiles.append(result.collider)
			
	return tiles

func get_all_tiles() -> Array[Node]:
	return tiles_parent_node.get_children()

func load_tile_textures() -> void:
	tile_textures.clear()
	
	var dir: DirAccess = DirAccess.open(tile_textures_path)
	if not dir:
		push_error("Failed to open directory: " + tile_textures_path)
		return
	
	dir.list_dir_begin()
	var file_name := dir.get_next()
	
	while file_name != "":
		if not dir.current_is_dir():
			var resource_name := file_name.trim_suffix(".import")
			
			var ext := resource_name.get_extension().to_lower()
			if ext in ["png", "jpg", "jpeg", "webp", "svg"]:
				var full_path := tile_textures_path + resource_name
				
				if ResourceLoader.exists(full_path):
					var texture := ResourceLoader.load(full_path) as Texture2D
					if texture and not tile_textures.has(texture):
						tile_textures.append(texture)
		
		file_name = dir.get_next()
	
	dir.list_dir_end()
