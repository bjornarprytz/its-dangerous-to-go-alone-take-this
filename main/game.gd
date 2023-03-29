extends Node2D

@onready var ui : TakeThisUI = $Camera/UI

@onready var casettes_left = $Casettes.get_child_count() + 1 # +1 is the casette you get from the helper

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Screen.show()
	ui.hide()
	EventBus.dialogue_finished.connect(_on_dialogue_finished, CONNECT_ONE_SHOT)
	EventBus.get_casette.connect(_on_casette_pickup)
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

func _on_casette_pickup(_data: CasetteData) -> void:
	casettes_left -= 1
	print("Casettes left: ", casettes_left)
	
	if (casettes_left == 0):
		print("Game win!")
