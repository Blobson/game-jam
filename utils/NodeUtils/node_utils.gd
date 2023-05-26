class_name NodeUtils extends Node

static func replace_node(from: Node, to: Node):
	var parent = from.get_parent()
	from.queue_free()
	parent.add_child(to)
