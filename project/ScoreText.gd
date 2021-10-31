extends RichTextLabel

var score = 0
onready var player = get_tree().get_nodes_in_group("player")[0]

func _on_Timer_timeout():
	if !player.alive:
		return
	
	score += 1
	bbcode_text = "[shake][center]Score: " + String(score)
