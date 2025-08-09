class_name Starter
extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sfx_button_press: AudioStreamPlayer = $"../../sfx_button_press"

func _ready() -> void:
	global.level_not_complete.connect(_reset)

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("space") and not global.is_dragging:
		_level_check()

func _reset():
	collision_shape_2d.disabled = true
	global.connections = 0
	global.expected_connections = 0
	global.can_interact = true

func _level_check():
	global.level_check.emit()
	global.side_objectives = 0
	collision_shape_2d.disabled = false
	global.can_interact = false
	sfx_button_press.play()
	await sfx_button_press.finished

func _on_button_pressed() -> void:
	if global.can_interact:
		_level_check()
