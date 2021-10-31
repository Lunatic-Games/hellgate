extends Control

onready var game_scene = load("res://TestRoom.tscn")


func _on_Button_pressed():
	get_tree().current_scene.queue_free()
	get_tree().change_scene_to(game_scene)


func _on_LinkButton_pressed():
	OS.shell_open("https://lunatic-games.itch.io/spifin")
