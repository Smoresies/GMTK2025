extends Node

@onready var sfx_button_press: AudioStreamPlayer = $sfx_button_press


func _on_main_menu_pressed() -> void:
	sfx_button_press.play()
	await sfx_button_press.finished
	get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")
