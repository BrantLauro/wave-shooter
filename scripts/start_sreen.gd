extends Control

func _on_CreditButton_pressed():
	get_tree().change_scene("res://scenes/credits.tscn")

func _on_StartButton_pressed():
	get_tree().change_scene("res://scenes/arena.tscn")
