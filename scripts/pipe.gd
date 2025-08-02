extends Draggable

@export var colliders: Array[CollisionShape2D] = []
@onready var electricity: Line2D = $Electricity

var checked: bool = false

func _ready() -> void:
	global.level_not_complete.connect(_reset)

func checker_triggered(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if _area.get_parent() == self:
		return
	global.connections += 1
	if not checked:
		checked = true
		for c in colliders:
			c.set_deferred("disabled", false)
			global.expected_connections += 1
		electricity.visible = true


func _reset():
	for c in colliders:
		c.set_deferred("disabled", true)
	checked = false
	electricity.visible = false
