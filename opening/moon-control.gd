extends Sprite2D

var in_transition : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_loops()
	
	tween.tween_property(self, "material:shader_parameter/amount", 5.0, 0.4)
	tween.tween_property(self, "material:shader_parameter/amount", -5.0, 0.4)
	tween.tween_property(self, "material:shader_parameter/amount", 0, 0.2)
	tween.tween_interval(5.0)
