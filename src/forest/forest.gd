extends Node2D

@onready var ui : TakeThisUI = $Camera.ui
@onready var curtain = $Camera.curtain

func _ready() -> void:
	curtain.show()
	ui.hide()
	Game.on_dialogue_finished.connect(_on_dialogue_finished, CONNECT_ONE_SHOT)
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	
	tween.tween_property(curtain, 'modulate:a', 0.0, 1.0)
	
	await tween.finished
	
	ui.show()
	ui.dialogue.next()

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_pressed() && ui.dialogue != null):
		ui.dialogue.next()

func _on_dialogue_finished() -> void:
	$Camera.lock_on_player = true

func _on_cave_entered() -> void:
	var tween = create_tween()
	
	tween.tween_property(curtain, 'modulate:a', 1.0, 1.0)
	
	await tween.finished
	
	get_tree().change_scene_to_file("res://cave/cave.tscn")
	
