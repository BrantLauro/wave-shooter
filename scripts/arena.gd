extends Node2D

export(Array, PackedScene) var enemies

func _ready():
	Global.child_node_creation = self
	Global.points = 0

func _exit_tree():
	Global.child_node_creation = null

func _on_TimerEnemySpawn_timeout():
	var enemy_position = Vector2(rand_range(-160, 670), rand_range(-90, 390))
	while enemy_position.x < 640 and enemy_position.x > -80 and enemy_position.y < 360 and enemy_position.y > -45:
		enemy_position = Vector2(rand_range(-160, 670), rand_range(-90, 390))
	var enemy_amount = round(rand_range(0, enemies.size() - 1))
	Global.instance_node(enemies[enemy_amount], enemy_position, self)

func _on_DifficultyTimer_timeout():
	if $TimerEnemySpawn.wait_time > 0.50:
		$TimerEnemySpawn.wait_time -= 0.25
