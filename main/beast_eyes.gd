extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_frame_changed() -> void:
	match frame:
		0:
			_set_glow(1.0)
		1,3: 
			_set_glow(0.3)
		2:
			_set_glow(0.0)

func _set_glow(energy: float):
	$Eye1.energy = energy
	$Eye2.energy = energy
