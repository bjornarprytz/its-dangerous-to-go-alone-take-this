@tool
extends Node2D
class_name Casette

signal started
signal stopped

var is_playing : bool

@onready var label : RichTextLabel = $CasetteAnimation/C/Label

var data : CasetteData :
	set(val):
		$CasetteAnimation/C/Label.text = val.label
		$CasetteAnimation/ColorBand.modulate = val.color
		if (val.music and val.music.get_length() > 0):
			var nFrames = $TapeAnimation.sprite_frames.get_frame_count("Tape") # Assumes FPS==1
			$TapeAnimation.speed_scale = nFrames / val.music.get_length()
		data = val

func _ready():
	if not Engine.is_editor_hint():
		AudioPlayer.switched_casette.connect(_on_casette_switch)
		$TapeAnimation.animation_finished.connect(_on_tape_ran_out)
	
	$CasetteAnimation/C/Label.position = Vector2.ZERO # Hack because some UI sets the position  way outside the screen for some reason (related to the low scale 0.04)?
	
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
