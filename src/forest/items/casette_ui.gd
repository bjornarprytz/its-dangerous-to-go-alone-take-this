extends Control
class_name CasetteUI

const PLAYING_SCALE : float = 1.5

func set_data(data: CasetteData):
	$Casette.data = data

func _on_casette_started():
	var tween = create_tween().set_parallel()
	tween.tween_property($Casette, 'scale', Vector2.ONE * PLAYING_SCALE, 1.0)
	tween.tween_property(self, 'custom_minimum_size', Vector2(90.0, 50.0) * PLAYING_SCALE, 1.0)

func _on_casette_stopped():
	var tween = create_tween().set_parallel()
	tween.tween_property($Casette, 'scale', Vector2.ONE, 1.0)
	tween.tween_property(self, 'custom_minimum_size', Vector2(90.0, 50.0), 1.0)
