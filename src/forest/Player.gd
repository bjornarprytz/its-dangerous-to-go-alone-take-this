extends CharacterBody2D
class_name Player

@export var move_speed = 200.0

var push_force = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	var move_vector = Vector2.ZERO
	var walk_factor = 1.0
	
	if (Input.is_key_pressed(KEY_W)):
		move_vector += Vector2.UP
	if (Input.is_key_pressed(KEY_A)):
		move_vector += Vector2.LEFT
	if (Input.is_key_pressed(KEY_D)):
		move_vector += Vector2.RIGHT
	if (Input.is_key_pressed(KEY_S)):
		move_vector += Vector2.DOWN
	if (Input.is_key_pressed(KEY_SHIFT)):
		walk_factor = 0.5
	
	
	velocity = (move_vector.normalized() * move_speed * walk_factor) + push_force
	
	move_and_slide()
	