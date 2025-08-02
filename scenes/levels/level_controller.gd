extends Node

@export var number_of_side_objectives : int = 0
@export var end : Ender
@onready var level_complete: Control = $Level_Complete
@export var nextLevel: PackedScene


func _ready():
	global.number_of_side_objectives = number_of_side_objectives
	end.level_complete.connect(_trigger_end)
	global.can_interact = true

func _trigger_end():
	### Open Menu & Stop Game Interaction
	level_complete.visible = true
	global.can_interact = false
	
	### Stars Counting
	# See how many bulbs gotten vs total bulbs. 
	# Subtract from 3, for number of bulbs at level end screen given
	var bulbs = 3 - (number_of_side_objectives - global.side_objectives)
	
	### Level Transition
	# await get_tree().create_timer(1).timeout
	# get_tree().change_scene_to_packed(nextLevel)
