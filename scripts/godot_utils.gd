class_name GodotUtils

static func instantiate(scene: PackedScene, parent: Node, pos: Vector2 = Vector2.ZERO) -> Node:
	var instance = scene.instantiate()
	parent.add_child(instance)
	
	if instance is Node2D:
		instance.global_position = pos
	return instance

static func get_component(node: Node, type: Script) -> Node:
	if node == null:
		print("Null node!")
		return null;
	
	for child in node.get_children():
		if is_instance_of(child, type):
			return child
	return null
