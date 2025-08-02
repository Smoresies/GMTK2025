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
	level_complete.visible = true
	global.can_interact = false
	# await get_tree().create_timer(1).timeout
	# get_tree().change_scene_to_packed(nextLevel)
