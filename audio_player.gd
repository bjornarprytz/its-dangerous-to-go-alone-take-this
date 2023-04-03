extends AudioStreamPlayer

signal switched_casette(data : CasetteData)

var _swith_casette_sound = preload("res://sound/fx/Tape i kassetten.wav")
var _press_play_sound = preload("res://sound/fx/Knapp på kassettspiller.wav")

var seconds_left_of_current_casette: 
	get: 
		if (!stream):
			return 0.0
		
		return stream.get_length()

func _ready() -> void:
	finished.connect(play)

func node():
	return self

func stop_music():
	stop()
	print("Stop the music, start the creepy")

func switch(casette: CasetteData):
	stop()
	
	await play_effect(_swith_casette_sound)
	await play_effect(_press_play_sound)
	
	stream = casette.music
	play()
	switched_casette.emit(casette)
	print("Switched track to ", casette.label)

func play_effect(effect: AudioStream):
	stream = effect
	play()
	await finished
