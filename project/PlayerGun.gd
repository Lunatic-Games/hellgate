extends Node2D

const OFFSET = 16

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var ammo_tracker = get_tree().root.find_node("Hud/AmmoText")

var bullet_scene = preload("res://Bullet.tscn")
var able_to_shoot = true
var max_ammo = 3
var ammo = max_ammo
var firerate = 1.4
var bullet_count = 3

var reloading = false

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var direction_pointing = player.global_position.direction_to(mouse_pos).normalized()
	mouse_pos += direction_pointing * OFFSET
	
	global_position = player.global_position
	global_position += direction_pointing * OFFSET
	if !reloading:
		look_at(mouse_pos)
	
	if Input.is_action_just_pressed("shoot"):
		if ammo <= 0:
			if !reloading:
				reload()
			
		elif able_to_shoot:
			for x in range(bullet_count):
				var bullet = bullet_scene.instance()
				bullet.global_position = global_position + direction_pointing * ($Sprite.texture.get_width() - 3)
				get_tree().root.add_child(bullet)
				var offset = direction_pointing.rotated(rand_range(-PI/8, PI/8))
				bullet.init_bullet(offset)
			ammo -= 1
			able_to_shoot = false
			$FirerateTimer.start()
			


func _on_FirerateTimer_timeout():
	able_to_shoot = true

func reload():
	reloading = true
	$Tween.interpolate_property(self, "rotation", rotation, rotation + 360, 0.4, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	print("FINISHED TWEEN")
	ammo = max_ammo
	reloading = false
