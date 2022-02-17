extends Sprite

var speed = 150
var mov = Vector2.ZERO

func _process(delta: float):
	mov.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	mov.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	
	global_position += speed * mov * delta
