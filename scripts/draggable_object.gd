class_name Draggable
extends Node2D

var draggable: bool = false
var is_inside_droppable: bool = false
var body_ref : BoardSpace = null
var last_body : BoardSpace = null
var offset: Vector2
var initialPos: Vector2

@onready var initialSize: Vector2 = scale
@export var sfx_settled: AudioStreamPlayer

signal deleting_self()

func _process(_delta):
	if draggable and global.can_interact:
		if Input.is_action_just_pressed("click"):
			if not global.is_dragging:
				initialPos = global_position
				offset = get_global_mouse_position() - global_position
				global.is_dragging = true
			elif global.is_dragging:
				draggable = false
				return
		elif Input.is_action_just_pressed("right_click") and not global.is_dragging:
			if last_body:
				last_body.held_piece = null
				# print("Fixed the body!")
			emit_signal("deleting_self")
			queue_free()
			return
			
			
		if Input.is_action_just_pressed("rotate"):
			rotation_degrees += 90
			
			
		if Input.is_action_pressed("click"):
			if not global.is_dragging:
				global.is_dragging = true
			global_position = get_global_mouse_position() - offset
			
			
		elif Input.is_action_just_released("click"):
			global.is_dragging = false
			if is_inside_droppable and body_ref:
				### We were in a space AND the place we want to go has something there
				if body_ref.held_piece and body_ref.held_piece != self:
					# print("BR held piece AND isn't us")
					### First check if we have a previous space. If not, we cannot swap
					if not last_body:
						return
					### If we do have a previous space then other piece can go there
					body_ref.held_piece.update_pos(last_body.position)
					### And we update its body_ref
					last_body.held_piece = body_ref.held_piece
					last_body.held_piece.body_ref = last_body
					
				# Update our pos, play sfx, and update needed variables
				update_pos(body_ref.position)
				sfx_settled.play()
				# If the last body exists, holds a piece, and that piece is us!
				if last_body and last_body.held_piece and last_body.held_piece == self:
					# Tell it to no longer hold a piece
					# print("nulling last body")
					last_body.held_piece = null
				last_body = body_ref
				body_ref.held_piece = self
				body_ref = null
			elif last_body: # Prevent weird offset bug
				update_pos(last_body.position)
			#else:
				#tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)
			# draggable = false


func _on_area_2d_mouse_entered() -> void:
	if not global.is_dragging:
		# print("can drag!")
		draggable = true
		scale = initialSize * Vector2(1.05, 1.05)


func _on_area_2d_mouse_exited() -> void:
	if not global.is_dragging:
		draggable = false
		scale = initialSize

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("droppable") and body is BoardSpace:
		#if not body.is_empty:
			#return
		is_inside_droppable = true
		body_ref = body

func update_pos(pos: Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", pos, 0.2).set_ease(Tween.EASE_OUT)
# func _on_area_2d_body_exited(body: Node2D) -> void:
	# if body.is_in_group("droppable"):
		# is_inside_droppable = false
		# body.modulate = Color(Color.MEDIUM_PURPLE, 0.7)
