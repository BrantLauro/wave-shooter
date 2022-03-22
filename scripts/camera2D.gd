extends Camera2D

var camera_shake_intensity = 0
var camera_shake_init = false

func _ready():
	Global.camera = self

func _exit_tree():
	Global.camera = null

func _process(delta : float):
	zoom = lerp(zoom, Vector2(1,1), 0.3)
	if camera_shake_init:
		global_position += Vector2(rand_range(-camera_shake_intensity, camera_shake_intensity), 
		rand_range(-camera_shake_intensity, camera_shake_intensity)) * delta

func shake_screen(intensity, time):
	zoom = Vector2(1,1) - Vector2(intensity * -0.002, intensity * -0.002)
	camera_shake_intensity = intensity
	$TimerCamera.wait_time = time
	$TimerCamera.start()
	camera_shake_init = true

func _on_TimerCamera_timeout():
	camera_shake_init = false
