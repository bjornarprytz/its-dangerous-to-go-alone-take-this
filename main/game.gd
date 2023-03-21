extends Node2D

@onready var dialogue : Dialogue = $Camera/UI/Dialogue


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Screen.show()
	dialogue.hide()
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	
	tween.tween_property($Screen, 'modulate:a', 0.0, 2.0)
	
	await tween.finished
	
	dialogue.show()
	dialogue.next()

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_pressed() and dialogue != null):
		dialogue.next()

func _on_dialogue_dialogue_finished() -> void:
	AudioPlayer.switch("res://sound/takethis.wav")
	$Camera.lock_on_player = true
