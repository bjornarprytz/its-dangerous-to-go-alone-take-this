extends Control

var in_transition : bool = false

func _on_start_button_pressed() -> void:
	_transition()

func _transition():
	if in_transition:
		return

	in_transition = true;
	
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC).set_parallel()
	
	var audio = AudioPlayer.node()
		
	tween.tween_property($Clouds, 'position:y', -get_viewport_rect().size.y, 5.0)
	tween.tween_property($Clouds, 'material:shader_parameter/alpha', 0.0, 5.0)
	tween.tween_property($Moon, 'position:y', -get_viewport_rect().size.y, 5.0)
	tween.tween_property(audio, 'volume_db', -15.0, 5.0)


	await tween.finished
	
	get_tree().change_scene_to_file("res://game.tscn")
