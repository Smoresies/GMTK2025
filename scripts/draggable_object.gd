class_name Draggable
extends Node2D

var draggable: bool = false
var is_inside_droppable: bool = false
var body_ref
var offset: Vector2
var initialPos: Vector2
var last_body : BoardSpace = null
@onready var initialSize: Vector2 = scale

func _process(_delta):
	if draggable:
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			global.is_dragging = true
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			global.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_droppable and body_ref:
				tween.tween_property(self, "position", body_ref.position, 0.2).set_ease(Tween.EASE_OUT)
				if last_body:
					last_body.is_empty = true
				last_body = body_ref
				body_ref.is_empty = false
				body_ref.modulate = Color(Color.MEDIUM_PURPLE, 0.7)
				body_ref = null
			else:
				tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)
			# draggable = false


func _on_area_2d_mouse_entered() -> void:
	if not global.is_dragging:
		draggable = true
		scale *= Vector2(1.05, 1.05)


func _on_area_2d_mouse_exited() -> void:
	if not global.is_dragging:
		draggable = false
		scale = initialSize

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("droppable") and body is BoardSpace:
		if not body.is_empty:
			return
		is_inside_droppable = true
		body.modulate = Color(Color.REBECCA_PURPLE, 1)
		if body_ref != null:
			body_ref.modulate = Color(Color.MEDIUM_PURPLE, 0.7)
		body_ref = body


# func _on_area_2d_body_exited(body: Node2D) -> void:
	# if body.is_in_group("droppable"):
		# is_inside_droppable = false
		# body.modulate = Color(Color.MEDIUM_PURPLE, 0.7)
