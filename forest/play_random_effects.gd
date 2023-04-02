extends AudioStreamPlayer2D

@export var effects : Array[AudioStream]
@export var frequency := 0.2

func _physics_process(delta: float) -> void:
	if (effects != null and effects.size() > 0 and !playing and randf() < (frequency * delta)):
		stream = effects.pick_random()
		play()
		
		
