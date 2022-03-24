extends Sprite

export(String) var player_var_modifier
export(float) var player_var_value
export(float) var power_reload_time = 2

func _on_HitBox_area_entered(area: Area2D):
	if area.is_in_group("player"):
		area.get_parent().set(player_var_modifier, player_var_value)
		area.get_parent().get_node("ReloadTimerCooldown").wait_time = power_reload_time
		area.get_parent().get_node("ReloadTimerCooldown").start()
		area.get_parent().reset_power.append(name)
		queue_free()
		area.get_parent().modulate = Color.green
