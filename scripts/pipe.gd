class_name Pipe
extends Draggable

@export var colliders: Array[CollisionShape2D] = []
@export var is_immobile: bool = false
@onready var electricity: Line2D = $Electricity

var checked: bool = false


func _ready() -> void:
	global.level_not_complete.connect(_reset)

func checker_triggered(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	### If we collided with ourselves OR if this piece is being dragged OR if we aren't on a proper space
	if _area.get_parent() == self or (not last_body and not is_immobile):
		return
	# print(self.name, " Collision happened!")
	global.connections += 1
	if not checked:
		checked = true
		for c in colliders:
			c.set_deferred("disabled", false)
			global.expected_connections += 1
			# print(self.name, " Added an expected connection")
		electricity.visible = true


func _reset():
	for c in colliders:
		c.set_deferred("disabled", true)
	checked = false
	electricity.visible = false
