extends CharacterBody2D
class_name Player

@export var move_speed = 50.0

var push_force = Vector2.ZERO

func _ready() -> void:
	$Animation.animation_changed.connect($Animation.play)

func _physics_process(_delta: float) -> void:
	var move_vector = Vector2.ZERO
	var walk_factor = 1.0
	var animation_name = ''
	
	if (Input.is_key_pressed(KEY_A)):
		move_vector += Vector2.LEFT
		animation_name = 'walk-left'
	if (Input.is_key_pressed(KEY_D)):
		move_vector += Vector2.RIGHT
		animation_name = 'walk-right'
	if (Input.is_key_pressed(KEY_W)):
		move_vector += Vector2.UP
		animation_name = 'walk-up'
	if (Input.is_key_pressed(KEY_S)):
		move_vector += Vector2.DOWN
		animation_name = 'walk-down'
		
	if (Input.is_key_pressed(KEY_SHIFT)):
		walk_factor = 0.5
	
	if (move_vector == Vector2.ZERO):
		animation_name = 'idle'
	
	if ($Animation.animation != animation_name):
		$Animation.animation = animation_name
	
	velocity = (move_vector.normalized() * move_speed * walk_factor) + push_force
	
	move_and_slide()
	
