class_name Ender
extends Area2D

var _complete : bool = false

signal level_complete()

func _ready():
	global.level_check.connect(_checking)

func _on_area_shape_entered(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	global.connections += 1
	print(global.connections, " ", global.expected_connections)
	if global.connections == global.expected_connections:
		_complete = true
		level_complete.emit()
		# print("You win!")

func _checking():
	await get_tree().create_timer(2).timeout
	if not _complete:
		global.level_not_complete.emit()
