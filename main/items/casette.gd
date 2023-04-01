@tool
extends Node2D
class_name Casette

signal started
signal stopped
var is_playing : bool

const ANIMATION_LENGTH = 25.0

var data : CasetteData :
	set(val):
		$Label.text = val.label
		$ColorBand.modulate = val.color
		if (val.music and val.music.get_length() > 0): 
			$Animation.speed_scale = ANIMATION_LENGTH / val.music.get_length()
		data = val

func _ready():
	AudioPlayer.switched_casette.connect(_on_casette_switch)
	print("Casette spawned ", data.label)
	
func _on_casette_switch(_playing_casette : CasetteData):
	var was_playing = is_playing
	
	if (_playing_casette.label == data.label):
		is_playing = true
		if (!was_playing):
			started.emit()
			$Animation.play()
	else:
		is_playing = false
		if (was_playing):
			stopped.emit()
			$Animation.pause()
