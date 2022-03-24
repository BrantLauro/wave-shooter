extends Node

var child_node_creation = null
var player = null
var points = 0
var high_score = 0
var camera = null
var danage_texture = null

func instance_node(node, localtion, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = localtion
	return node_instance

func save():
	var dic_save = {
		"high_score": high_score
	}
	return dic_save

func save_game():
	var saved_game = File.new()
	saved_game.open_encrypted_with_pass("user://savedgame1.save", File.WRITE, "0000")
	saved_game.store_line(to_json(save()))
	saved_game.close()

func load_game():
	var saved_game = File.new()
	if not saved_game.file_exists("user://savedgame1.save"):
		print("ERROR LOADING FILE")
		return
	saved_game.open_encrypted_with_pass("user://savedgame1.save", File.READ, "0000")
	var actual_line = parse_json((saved_game.get_line()))
	high_score = actual_line["high_score"]
	saved_game.close()
