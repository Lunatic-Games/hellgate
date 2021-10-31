extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("wiggle")


func _on_LinkButton_focus_entered():
	$ScaleAnim.play("up")



func _on_LinkButton_focus_exited():
	$ScaleAnim.play("down")
