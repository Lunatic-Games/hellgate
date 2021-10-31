extends KinematicBody2D

var speed = 150
var alive = true

onready var game_over_ui = get_tree().get_nodes_in_group("game_over_ui")[0]

func _physics_process(delta):
	if ! alive:
		return
	
	var direction = Vector2(0,0)
	
	
	if Input.is_action_pressed("up"):
		direction.y -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1
	
	if direction == Vector2(0, 0):
		if $WalkAnim.is_playing():
			$WalkAnim.stop()
			$WalkAnim.play("end")
	else:
		$WalkAnim.play("walk")
	
	direction = direction.normalized()
	move_and_slide_with_snap(direction * speed, Vector2(0, 1))


func _on_HitBox_body_entered(body):
	if !alive:
		return
	
	if body.is_in_group("enemy"):
		die()

func die():
	$DeathPlayer.play("death")
	alive = false
	yield(get_tree().create_timer(1), "timeout")
	you_lose()


func you_lose():
	game_over_ui.visible = true
