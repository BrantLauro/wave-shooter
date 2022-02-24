extends Node2D

func _ready():
	Global.child_node_creation = self

func _exit_tree():
	Global.child_node_creation = null
