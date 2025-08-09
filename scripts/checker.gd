extends Area2D

const BROKEN_POINT_PARTICLES = preload("res://scenes/misc/broken_point_particles.tscn")
var particles: CPUParticles2D

var has_collided: bool = false

func _ready() -> void:
	particles = BROKEN_POINT_PARTICLES.instantiate()
	self.add_child(particles)
	# particles.emitting = true
	global.level_not_complete.connect(_reset)
	global.level_check.connect(_play_particles)

func _reset():
	has_collided = false
	if particles.emitting:
		particles.emitting = false

func _play_particles():
	await get_tree().create_timer(.25).timeout
	print(has_collided)
	if not has_collided and get_parent().checked:
		particles.emitting = true

func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.get_parent() != self.get_parent():
		has_collided = true
