extends Node3D

@export var speed : float = 10.0

enum DIRECTION
{
	STRAIGHT,
	LEFT,
	RIGHT
}

var _direction : DIRECTION = DIRECTION.STRAIGHT

func _physics_process(delta: float) -> void:
	
	match _direction:
		DIRECTION.LEFT:
			if (position.y > 10):
				start_turn_straight()
			else:
				translate(Vector3.UP * speed * delta)
		DIRECTION.RIGHT:
			if (position.y < -10):
				start_turn_straight()
			else:
				translate(Vector3.DOWN * speed * delta)

func _unhandled_key_input(event):
	
	match event.keycode:
		KEY_A:
			if (event.is_pressed()):
				start_turn_left()
			else:
				start_turn_straight()
		KEY_D:
			if (event.is_pressed()):
				start_turn_right()
			else:
				start_turn_straight()

func start_turn_left():
	_direction = DIRECTION.LEFT
	$Sprite.flip_h = true
	create_tween().tween_property($Sprite, 'rotation_degrees:x', -20, 0.4)

func start_turn_right():
	_direction = DIRECTION.RIGHT
	create_tween().tween_property($Sprite, 'rotation_degrees:x', 20, 0.4)

func start_turn_straight():
	_direction = DIRECTION.STRAIGHT
	$Sprite.flip_h = false
	create_tween().tween_property($Sprite, 'rotation:x', 0, 0.4)
