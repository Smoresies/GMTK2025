extends Draggable

@onready var send_right: CollisionShape2D = $Area2D/SendRight

var checked: bool = false

func checker_triggered(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if not checked:
		send_right.set_deferred("disabled", false)
		checked = true
		
