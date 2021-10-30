extends ProgressBar

onready var firerate_timer = get_parent().get_node("FirerateTimer")
onready var player_gun = get_tree().get_nodes_in_group("player_gun")[0]

func _process(delta):
	if firerate_timer.time_left > 0:
		value = (1 - firerate_timer.time_left/player_gun.firerate) * 100
	else:
		value = 0
