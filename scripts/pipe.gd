extends Draggable

@export var colliders: Array[CollisionShape2D] = []

var checked: bool = false

func checker_triggered(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if _area.get_parent() == self:
		return
	global.connections += 1
	if not checked:
		checked = true
		for c in colliders:
			c.set_deferred("disabled", false)
			global.expected_connections += 1
		await get_tree().create_timer(0.25).timeout
		for c in colliders:
			c.set_deferred("disabled", true)
		# IF ERROR OR TURNS BACK ON TOO FAST, ADD A TIMER HERE
		checked = false
