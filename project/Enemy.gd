extends KinematicBody2D

var speed = 40
var health = 1

onready var player = get_tree().get_nodes_in_group("player")[0]

func _physics_process(delta):
	# Move towards the  player
	var direction_to_player = global_position.direction_to(player.global_position)
	move_and_slide(direction_to_player * speed)

func take_damage(damage):
	health -= damage
	if health <= 0:
		call_deferred("free")
