extends Control

var live_size = 20

func on_change_lives(player_lives):
	$Lives.rect_size.x = player_lives * live_size
