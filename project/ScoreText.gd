extends RichTextLabel

var score = 0

func _on_Timer_timeout():
	score += 1
	bbcode_text = "[shake][center]Score: " + String(score)
