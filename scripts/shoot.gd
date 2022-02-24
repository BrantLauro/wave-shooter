extends Sprite

var mov = Vector2(1,0)
var speed = 250
var unique_dir = true

func _process(delta: float):
	if unique_dir:
		look_at(get_global_mouse_position())
		unique_dir = false
	global_position += mov.rotated(rotation) * speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
