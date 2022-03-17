extends Sprite

var speed = 75
var mov = Vector2.ZERO
var dizzy = false
var knockback = 6
var hp = 3
var blood_particle = preload("res://scenes/blood_particle.tscn")

func _process(delta: float):
	if Global.player != null and dizzy == false:
		mov = global_position.direction_to(Global.player.global_position)
	elif dizzy:
		mov = lerp(mov, Vector2.ZERO, 0.3)
	global_position += mov * speed * delta
	if hp <= 0 and Global.child_node_creation != null:
		Global.points += 10
		if Global.camera != null:
			Global.camera.shake_screen(50, 0.1)
		var blood_particle_instance = Global.instance_node(blood_particle, global_position, Global.child_node_creation)
		blood_particle_instance.rotation = mov.angle()
		queue_free()

func _on_HitBox_area_entered(area: Area2D):
	if area.is_in_group("damage") and dizzy == false:
		modulate = Color.white
		area.get_parent().queue_free()
		mov = -mov * knockback
		dizzy = true
		hp -= 1
		$BreathTimer.start()

func _on_BreathTimer_timeout():
	modulate = Color("f3065f")
	dizzy = false
