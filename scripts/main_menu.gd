extends Node

@export var nextLevel: PackedScene
# @export var LevelSelect: PackedScene
# @export var Credits: PackedScene



func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_packed(nextLevel)
