extends KinematicBody2D

var speed = 40
var health
var max_health
var alive = true
var player

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]

func _physics_process(delta):
	# Move towards the  player
	if alive and is_instance_valid(player):
		var direction_to_player = global_position.direction_to(player.global_position)
		move_and_slide(direction_to_player * speed)

func take_damage(damage):
	health -= damage
	if health <= 0:
		die()
	else:
		var hp_bar = float(health)/float(max_health)
		$HealthBar.value = hp_bar * 100
		$HitAnim.play("hit")

func die():
	alive = false
	$HitAnim.play("death")
	remove_child($OutgoingHitBox)
	remove_child($IncomingHitBox)
	$HealthBar.value = 0
	yield(get_tree().create_timer(3), "timeout")
	remove_self()

func set_stats(times_triggered):
	health = int(rand_range(1, 3)) * times_triggered
	max_health = health
	speed = int(rand_range(30, 70))

func remove_self():
	call_deferred("free")
