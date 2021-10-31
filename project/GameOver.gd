extends Control

onready var game_scene = load("res://TestRoom.tscn")
onready var menu_scene = load("res://Menu.tscn")



func _on_Button_pressed():
	get_tree().current_scene.queue_free()
	get_tree().change_scene_to(game_scene)


func _on_Button2_pressed():
	get_tree().current_scene.queue_free()
	get_tree().change_scene_to(menu_scene)
