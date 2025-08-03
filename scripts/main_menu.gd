extends Node

@export var nextLevel: PackedScene
# @export var LevelSelect: PackedScene
# @export var Credits: PackedScene
@onready var sfx_button_press: AudioStreamPlayer = $sfx_button_press



func _on_start_game_pressed() -> void:
	sfx_button_press.play()
	await sfx_button_press.finished
	get_tree().change_scene_to_packed(nextLevel)
