class_name PieceSpawner
extends Node2D

@export var piece : PackedScene
@export var num_pieces : int = 3
@export var sprite : CompressedTexture2D

@onready var sprite_2d: Sprite2D = $Sprite2D/Sprite2D
# @onready var sprite_2d: Sprite2D = $Sprite2D
@onready var initialSize: Vector2 = scale
@onready var label: Label = $Label
@onready var sfx_spawn_piece: AudioStreamPlayer = $sfx_spawn_piece

var hovering: bool = false

func _ready():
	sprite_2d.texture = sprite
	label.text = str(num_pieces)

func _process(_delta: float) -> void:
	if hovering and global.can_interact:
		if Input.is_action_just_pressed("click") and num_pieces > 0:
			sfx_spawn_piece.play()
			num_pieces -= 1
			label.text = str(num_pieces)
			var new_piece = piece.instantiate()
			new_piece.position = Vector2(global_position.x + 126, global_position.y)
			new_piece.deleting_self.connect(_piece_deleted)
			self.get_parent().add_child(new_piece)


func _piece_deleted():
	num_pieces += 1
	label.text = str(num_pieces)
	# print("A PIECE WAS DELETED!")


func _on_area_2d_mouse_entered() -> void:
	if not global.is_dragging:
		hovering = true
		scale *= Vector2(1.25, 1.25)


func _on_area_2d_mouse_exited() -> void:
	if not global.is_dragging:
		hovering = false
		scale = initialSize
