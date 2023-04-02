extends AudioStreamPlayer

signal switched_casette(data : CasetteData)

var seconds_left_of_current_casette: 
	get: 
		if (!stream):
			return 0.0
		
		return stream.get_length()

func _ready() -> void:
	finished.connect(play)

func node():
	return self

func switch(casette: CasetteData):
	stop()
	stream = casette.music
	play()
	switched_casette.emit(casette)
	print("Switched track to ", casette.label)
