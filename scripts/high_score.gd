extends Label

func _ready():
	text = String(Global.high_score)

func _process(delta: float):
	if Global.points > Global.high_score:
		Global.high_score = Global.points