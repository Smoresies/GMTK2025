class_name Starter
extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("space"):
		global.side_objectives = 0
		collision_shape_2d.disabled = false
		await get_tree().create_timer(0.25).timeout
		collision_shape_2d.disabled = true
		global.connections = 0
		global.expected_connections = 0
