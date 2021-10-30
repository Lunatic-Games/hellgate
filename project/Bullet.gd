extends Node2D

var direction
var speed = 500
var lifespan = 0.2
var damage = 1

func init_bullet(travel_direction):
	direction = travel_direction
	$Lifespan.start(lifespan)

func _physics_process(delta):
	if direction:
		global_position += direction * speed * delta


func _on_Lifespan_timeout():
	call_deferred("free")


func _on_Area2D_area_entered(area):
	area.get_parent().take_damage(damage)
	call_deferred("free")
