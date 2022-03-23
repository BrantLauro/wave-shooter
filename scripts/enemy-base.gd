extends Sprite

export(int) var speed = 75
export(int) var knockback = 600
export(int) var hp = 3
onready var actual_color = modulate
var mov = Vector2.ZERO
var dizzy = false
var blood_particle = preload("res://scenes/blood_particle.tscn")

func _process(delta: float):
	if hp <= 0 and Global.child_node_creation != null:
		Global.points += 10
		if Global.camera != null:
			Global.camera.shake_screen(50, 0.1)
		var blood_particle_instance = Global.instance_node(blood_particle, global_position, Global.child_node_creation)
		blood_particle_instance.rotation = mov.angle()
		blood_particle_instance.modulate = Color.from_hsv(actual_color.h, 1, 0.35)
		queue_free()

func enemy_base_mov(delta):
	if Global.player != null and dizzy == false:
		mov = global_position.direction_to(Global.player.global_position)
		global_position += mov * speed * delta
	elif dizzy:
		mov = lerp(mov, Vector2.ZERO, 0.3)
		global_position += mov * delta

func _on_HitBox_area_entered(area: Area2D):
	if area.is_in_group("damage") and dizzy == false:
		modulate = Color.white
		area.get_parent().queue_free()
		mov = -mov * knockback
		dizzy = true
		hp -= area.get_parent().danage
		$BreathTimer.start()

func _on_BreathTimer_timeout():
	modulate = actual_color
	dizzy = false
