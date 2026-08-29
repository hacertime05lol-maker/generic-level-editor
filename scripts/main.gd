class_name Main extends Node2D

@export var player_scene: PackedScene
var current_player: Node = null

func spawn_player() -> void:
	current_player = GodotUtils.instantiate(player_scene, self, Vector2.ZERO)

func destroy_player() -> void:
	if current_player != null:
		current_player.queue_free()
