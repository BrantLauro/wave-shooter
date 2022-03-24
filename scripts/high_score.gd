extends Label

func _ready():
	Global.load_game()
	text = String(Global.high_score)

func _process(_delta):
	if Global.points > Global.high_score:
		Global.high_score = Global.points
