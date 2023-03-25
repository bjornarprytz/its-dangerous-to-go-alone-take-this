extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC).set_parallel()
	
	tween.tween_property($Scene, 'position:y', -get_viewport_rect().size.y*2.0, 2.0)
	
	await tween.finished
	
	get_tree().change_scene_to_file("res://main/game.tscn")
