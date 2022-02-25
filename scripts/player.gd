extends Sprite

var speed = 150
var mov = Vector2.ZERO
var shoot = preload("res://scenes/shoot.tscn")
var reloaded = true
var dead = false

func _ready():
	Global.player = self

func _exit_tree():
	Global.player = null

func _process(delta: float):
	mov.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	mov.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	if dead == false:
		global_position += speed * mov * delta
	
	if Input.is_action_pressed("shoot") and Global.child_node_creation != null and reloaded and dead == false:
		Global.instance_node(shoot, global_position, Global.child_node_creation)
		reloaded = false
		$ReloadTimer.start()

func _on_ReloadTimer_timeout():
	reloaded = true

func _on_HitBox_area_entered(area: Area2D):
	if area.is_in_group("enemy"):
		visible = false
		dead = true
		yield(get_tree().create_timer(1), "timeout")
		get_tree().reload_current_scene()
