extends Draggable

@onready var send_right: CollisionShape2D = $Area2D/SendRight

var checked: bool = false


func checker_triggered(_area: Area2D) -> void:
	print("checked!")
	if not checked:
		send_right.disabled = false
		checked = true
