extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

func _on_area_shape_entered(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	global.connections += 1
	global.side_objectives += 1
	sprite_2d.frame = 1
