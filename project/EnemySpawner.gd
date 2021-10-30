extends Node2D

var times_triggered = 0
var time_till_spawn = 30

onready var enemy_scene = preload("res://Enemy.tscn")

func _on_SpawnTimer_timeout():
	
	# Animate
	$SpawnAnim.play("spawn")
	# Increase time to spawn
	times_triggered += 1

func spawn():
	# Spawn the unit
	var enemy = enemy_scene.instance()
	enemy.global_position = global_position
	get_tree().root.add_child(enemy)
	enemy.set_stats(times_triggered)


func _on_SpawnAnim_animation_finished(anim_name):
	time_till_spawn = max(30 - (times_triggered/5), 2)
	$SpawnTimer.start(time_till_spawn)
