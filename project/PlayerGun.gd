extends Node2D

const OFFSET = 16

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var ammo_tracker = get_tree().get_nodes_in_group("ammo_ui")[0]

var bullet_scene = preload("res://Bullet.tscn")
var able_to_shoot = true
var max_ammo = 3
var ammo = max_ammo
var firerate = 0.45
var bullet_count = 6

var reloading = false

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var direction_pointing = player.global_position.direction_to(mouse_pos).normalized()
	mouse_pos += direction_pointing * OFFSET
	
	if not player.alive:
		return
	
	global_position = player.global_position
	global_position += direction_pointing * OFFSET
	if !reloading:
		look_at(mouse_pos)
	
	if mouse_pos.x < player.global_position.x:
		scale.y = -1
	else:
		scale.y = 1
	
	if Input.is_action_just_pressed("shoot"):
		if ammo <= 0:
			if !reloading:
				reload()
			
		elif able_to_shoot:
			for x in range(bullet_count):
				var bullet = bullet_scene.instance()
				bullet.global_position = global_position + direction_pointing * ($Sprite.texture.get_width() - 3)
				get_tree().root.add_child(bullet)
				
				if x != 0:
					var offset = direction_pointing.rotated(rand_range(-PI/8, PI/8))
					bullet.init_bullet(offset)
				else:
					bullet.init_bullet(direction_pointing)
				
			ammo -= 1
			able_to_shoot = false
			$FirerateTimer.start()
			ammo_tracker.update_ammo(ammo, max_ammo)
		
	
	if Input.is_action_just_pressed("reload") and ammo != max_ammo:
		reload()


func _on_FirerateTimer_timeout():
	able_to_shoot = true
	$TweenShootable.interpolate_property($Sprite, "scale", $Sprite.scale, $Sprite.scale*1.3, 0.4, Tween.TRANS_EXPO, Tween.EASE_IN)
	$TweenShootable.interpolate_property($Sprite, "scale", $Sprite.scale*1.3, $Sprite.scale, 0.1, Tween.TRANS_EXPO, Tween.EASE_IN, 0.4)
	$TweenShootable.start()

func reload():
	reloading = true
	$Tween.interpolate_property(self, "rotation", rotation, rotation + 360, 0.4, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	ammo = max_ammo
	reloading = false
	ammo_tracker.update_ammo(ammo, max_ammo)
	able_to_shoot = false
	$FirerateTimer.start()
