extends Node

# @export var number_of_side_objectives : int = 0
@export var end : Ender
@export var nextLevel: PackedScene


@onready var level_complete: Control = $Level_Complete
@onready var bulb_1: AnimatedSprite2D = $Level_Complete/HBoxContainer/ColorRect/MarginContainer/ColorRect/Bulb1
@onready var bulb_2: AnimatedSprite2D = $Level_Complete/HBoxContainer/ColorRect/MarginContainer/ColorRect/Bulb2
@onready var bulb_3: AnimatedSprite2D = $Level_Complete/HBoxContainer/ColorRect/MarginContainer/ColorRect/Bulb3


func _ready():
	# global.number_of_side_objectives = number_of_side_objectives
	end.level_complete.connect(_trigger_end)
	global.can_interact = true

func _trigger_end():
	### Brief pause for effect
	await get_tree().create_timer(1).timeout
	
	### Open Menu & Stop Game Interaction
	level_complete.visible = true
	# global.can_interact = false
	
	### Stars Counting
	# See how many bulbs gotten vs total bulbs. 
	# Subtract from 3, for number of bulbs at level end screen given
	var bulbs = max(0, 3 - (global.number_of_side_objectives - global.side_objectives))
	for i in range(0, bulbs):
		match i:
			0:
				bulb_1.play("lit")
			1:
				bulb_2.play("lit")
			2:
				bulb_3.play("lit")
			
	### Level Transition
	# await get_tree().create_timer(1).timeout


func _on_next_level_pressed() -> void:
	get_tree().change_scene_to_packed(nextLevel)


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")


func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()
