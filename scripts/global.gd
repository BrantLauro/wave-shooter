extends Node

var child_node_creation = null
var player = null

func instance_node(node, localtion, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = localtion
	return node_instance
