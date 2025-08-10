extends Label

var tween

func _ready():
	var init_scale := scale
	tween = get_tree().create_tween().set_loops()
	tween.tween_property(self, "scale", scale * 0.9, 1).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", init_scale, 1).set_ease(Tween.EASE_IN_OUT).set_delay(0.1)
	pass

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_PREDELETE:
			tween.stop()
