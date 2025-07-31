class_name BoardSpace
extends StaticBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var is_empty = true

func _ready():
	modulate = Color(Color.MEDIUM_PURPLE, 0.7)

func _process(_delta):
	if global.is_dragging:
		# visible = true
		collision_shape_2d.disabled = false
	else:
		# visible = false
		collision_shape_2d.disabled = true
