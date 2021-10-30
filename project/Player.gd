extends KinematicBody2D

var speed = 150

func _physics_process(delta):
	var direction = Vector2(0,0)
	
	if Input.is_action_pressed("up"):
		direction.y -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1
	
	direction = direction.normalized()
	move_and_slide_with_snap(direction * speed, Vector2(0, 1))

func update_ammo(ammo, max_ammo):
	pass
