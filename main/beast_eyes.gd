extends AnimatedSprite2D

var move_speed : float = 15.0
var target : Node2D

var to_avoid: Array[Node2D]
var player_is_too_close : bool

func _ready() -> void:
	assert(target)

func _on_frame_changed() -> void:
	match frame:
		0:
			_set_glow(1.0)
		1,3: 
			_set_glow(0.3)
		2:
			_set_glow(0.0)
			_lurch()

func _physics_process(delta: float) -> void:
	if (player_is_too_close):
		var direction = (position - target.position).normalized()
	
		translate(direction * move_speed)

func _lurch():
	var direction = Vector2.ZERO
	
	if (to_avoid.size() != 0):
		var biggest_fear = to_avoid[0]
		direction = (position - biggest_fear.position).normalized()
	else:
		direction = (target.position - position).normalized()
	
	translate(direction * move_speed)

func _set_glow(energy: float):
	$Eye1.energy = energy
	$Eye2.energy = energy


func _on_safe_space_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var danger = area.owner
	
	if (danger is Player):
		player_is_too_close = true
		frame = 2
		pause()
	elif (to_avoid.find(danger) == -1):
		to_avoid.push_back(danger)


func _on_safe_space_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var danger = area.owner
	var danger_idx = to_avoid.find(danger)
	
	if (danger is Player):
		player_is_too_close = false
		play()
	elif (danger_idx != -1):
		to_avoid.remove_at(danger_idx)
			
