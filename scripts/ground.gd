extends Area2D

@onready var electricity: Line2D = $"../Electricity"
@onready var collision_shape_2d: CollisionShape2D = $"../Area2D/CollisionShape2D"

func _ready() -> void:
	global.level_not_complete.connect(_reset)

func _on_area_shape_entered(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	# global.connections += 1
	electricity.visible = true
	collision_shape_2d.set_deferred("disabled", false)

func _reset():
	electricity.visible = false
	collision_shape_2d.set_deferred("disabled", true)
