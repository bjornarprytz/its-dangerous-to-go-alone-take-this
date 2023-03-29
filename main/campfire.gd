extends Sprite2D
class_name Fire


var _total_time : float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_total_time += (delta * randf_range(6.0, 12.0))
	$Light.scale = Vector2.ONE * (1.0 + (cos(_total_time) * 0.05))
