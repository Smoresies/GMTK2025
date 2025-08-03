extends Label

func _ready():
	var init_scale := scale
	var tween = get_tree().create_tween().set_loops()
	tween.tween_property(self, "scale", scale * 0.9, 1).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", init_scale, 1).set_ease(Tween.EASE_IN_OUT)
	pass
