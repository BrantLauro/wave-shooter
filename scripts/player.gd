extends Sprite

var speed = 150
var mov = Vector2.ZERO
var shoot = preload("res://scenes/shoot.tscn")
var reloaded = true

func _process(delta: float):
	mov.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	mov.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	global_position += speed * mov * delta
	
	if Input.is_action_pressed("shoot") and Global.child_node_creation != null and reloaded:
		Global.instance_node(shoot, global_position, Global.child_node_creation)
		reloaded = false
		$ReloadTimer.start()


func _on_ReloadTimer_timeout():
	reloaded = true
