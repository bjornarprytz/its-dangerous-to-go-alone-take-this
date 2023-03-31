extends AudioStreamPlayer2D

func _ready() -> void:
	finished.connect(play)

func node():
	return self

func switch(music : Resource):
	stop()
	stream = music
	play()
