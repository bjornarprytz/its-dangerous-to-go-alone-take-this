extends AudioStreamPlayer2D

func _ready() -> void:
	finished.connect(play)

func node():
	return self

func switch(file_path : String):
	stop()
	stream = load(file_path)
	play()
