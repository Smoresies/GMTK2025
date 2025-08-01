extends Area2D


func _on_area_shape_entered(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	global.connections += 1
	print(global.connections, " ", global.expected_connections)
	if global.connections == global.expected_connections:
		print("You win!")
