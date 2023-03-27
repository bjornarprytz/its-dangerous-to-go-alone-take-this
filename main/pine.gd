extends Node2D

var _player: Player = null

@export var push_strength = 250.0
const MAX_RESISTANCE = 100.0

var _resistance : float = 0.0

func _physics_process(delta: float) -> void:
	if (_player):
		var dir = (_player.global_position - global_position).normalized()
		_resistance = min(_resistance + (push_strength * delta), MAX_RESISTANCE)
		_player.push_force = (dir * _resistance)

func _on_area_2d_body_entered(body: Node2D) -> void:
	var player = body as Player
	if (player):
		_player = player


func _on_area_2d_body_exited(body: Node2D) -> void:
	var player = body as Player
	if (player):
		_resistance = 0.0
		_player.push_force = Vector2.ZERO
		_player = null
