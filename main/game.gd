extends Node2D

@onready var ui : TakeThisUI = $Camera/UI


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Screen.show()
	ui.hide()
	EventBus.dialogue_finished.connect(_on_dialogue_finished, CONNECT_ONE_SHOT)
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	
	tween.tween_property($Screen, 'modulate:a', 0.0, 2.0)
	
	await tween.finished
	
	ui.show()
	ui.dialogue.next()

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_pressed() && ui.dialogue != null):
		ui.dialogue.next()

func _on_dialogue_finished() -> void:
	AudioPlayer.switch("res://sound/takethis_oneminute.wav")
	$Camera.lock_on_player = true
