extends Sprite

signal change_lives(player_lives)
var speed = 150
var mov = Vector2.ZERO
var shoot = preload("res://scenes/shoot.tscn")
var reloaded = true
var dead = false
var max_lives = 3
var lives = max_lives
var reload_time = 0.1
var danage = 1
var standard_danage = danage
var standard_reload_time = reload_time
var reset_power = []

func _ready():
	Global.player = self
	connect("change_lives", get_parent().get_node("UI/Control"), "on_change_lives")
	emit_signal("change_lives", max_lives)
	Global.danage_texture = get_parent().get_node("UI/Control/DanageTexture")

func _exit_tree():
	Global.player = null

func _process(delta: float):
	mov.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	mov.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	global_position.x = clamp(global_position.x, 24, 616)
	global_position.y = clamp(global_position.y, 24, 336)
	if dead == false:
		global_position += speed * mov * delta
	
	if Input.is_action_pressed("shoot") and Global.child_node_creation != null and reloaded and dead == false:
		var instace_shoot = Global.instance_node(shoot, global_position, Global.child_node_creation)
		instace_shoot.danage = danage
		reloaded = false
		$ReloadTimer.start()

func _on_ReloadTimer_timeout():
	reloaded = true
	$ReloadTimer.wait_time = reload_time

func _on_HitBox_area_entered(area: Area2D):
	if area.is_in_group("enemy"):
		lives -= 1
		emit_signal("change_lives", lives)
		Global.danage_texture.show()
		yield(get_tree().create_timer(0.1), "timeout")
		Global.danage_texture.hide()
	if lives <= 0:
		visible = false
		dead = true
		yield(get_tree().create_timer(1), "timeout")
		get_tree().change_scene("res://scenes/start_screen.tscn")
		Global.save_game()

func _on_ReloadTimerCooldown_timeout():
	modulate = Color("2271d7")
	if reset_power.find("ReloadTimer") != null:
		reload_time = standard_reload_time
		reset_power.erase("ReloadTimer")
	if reset_power.find("danage") != null:
		danage = standard_danage
		reset_power.erase("danage")
