class_name PieceSpawner
extends Node2D

@export var piece : PackedScene
@export var num_pieces : int = 3
@export var sprite : CompressedTexture2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var initialSize: Vector2 = scale

var hovering: bool = false

func _ready():
	sprite_2d.texture = sprite


func _process(_delta: float) -> void:
	if hovering:
		if Input.is_action_just_pressed("click") and num_pieces > 0:
			num_pieces -= 1
			var new_piece = piece.instantiate()
			new_piece.position = Vector2(global_position.x + 126, global_position.y)
			self.get_parent().add_child(new_piece)


func _on_area_2d_mouse_entered() -> void:
	if not global.is_dragging:
		hovering = true
		scale *= Vector2(1.05, 1.05)


func _on_area_2d_mouse_exited() -> void:
	if not global.is_dragging:
		hovering = false
		scale = initialSize
