extends Node2D

@export var casette_data : CasetteData : 
	set(val):
		casette_data = val
		$Casette.set_data(val)

var _time : float

func _physics_process(delta):
	_time += (delta * 4.0)
	$Casette.position.y = cos(_time) -1.0

func _on_area_2d_body_entered(body):
	if (body is Player):
		EventBus.get_casette.emit(casette_data)
		queue_free()
