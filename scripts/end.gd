class_name Ender
extends Area2D

signal level_complete()

func _on_area_shape_entered(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	global.connections += 1
	print(global.connections, " ", global.expected_connections)
	if global.connections == global.expected_connections:
		level_complete.emit()
		print("You win!")
