@tool
extends Node2D
class_name Casette

signal started
signal stopped

var is_playing : bool

var data : CasetteData :
	set(val):
		$Label.text = val.label
		$ColorBand.modulate = val.color
		if (val.music and val.music.get_length() > 0):
			var nFrames = $TapeAnimation.sprite_frames.get_frame_count("Tape") # Assumes FPS==1
			$TapeAnimation.speed_scale = nFrames / val.music.get_length()
		data = val

func _ready():
	if not Engine.is_editor_hint():
		AudioPlayer.switched_casette.connect(_on_casette_switch)
		$TapeAnimation.animation_finished.connect(_on_tape_ran_out)
	
func _on_casette_switch(_playing_casette : CasetteData):
	var was_playing = is_playing
	
	if (_playing_casette.label == data.label):
		is_playing = true
		if (!was_playing):
			started.emit()
			$CasetteAnimation.play()
			$TapeAnimation.play()
	else:
		is_playing = false
		if (was_playing):
			stopped.emit()
			$CasetteAnimation.pause()
			$TapeAnimation.pause()
			
func _on_tape_ran_out():
	$CasetteAnimation.pause()
	AudioPlayer.stop_music()
