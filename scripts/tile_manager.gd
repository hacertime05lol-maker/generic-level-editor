class_name TileManager extends Node2D

@export var tile: PackedScene
@export var tiles_parent_node: Node
@export var tile_collision_mask: int = 2

@export var tile_sprites: Array[Texture2D]
var selected_tile: int = 0

const TILE_SIZE: int = 16

func spawn_tile(pos: Vector2) -> void:
	var tile: Node = GodotUtils.instantiate(tile, tiles_parent_node, pos)

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
