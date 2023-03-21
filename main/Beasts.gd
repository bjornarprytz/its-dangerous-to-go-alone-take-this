extends Node2D

var beast_spawner = preload("res://main/beast_eyes.tscn")

# Called when the node enters the scene tree for the first time.

func _spawn_beasts():
	var screen_size = get_viewport_rect().size
	for i in 5:
		var pos = Vector2(randf_range(0.0, 300.0), randf_range(0.0, screen_size.y))
		_spawn_beast(pos)
	for i in 5:
		var pos = Vector2(randf_range(800.0, screen_size.x), randf_range(0.0, screen_size.y))
		_spawn_beast(pos)
	for i in 5:
		var pos = Vector2(randf_range(0.0, screen_size.x), randf_range(0.0, 150.0))
		_spawn_beast(pos)
	for i in 5:
		var pos = Vector2(randf_range(0.0, screen_size.x), randf_range(550.0, screen_size.y))
		_spawn_beast(pos)

func _spawn_beast(pos : Vector2):
	var beast = beast_spawner.instantiate() as AnimatedSprite2D
	add_child(beast)
	beast.position = pos
	beast.scale = Vector2.ONE * (randf_range(0.5, 1.5))
	beast.speed_scale = randf() + 0.5
	beast.modulate = Color(randf(), randf(), randf())
	beast.play()


func _on_dialogue_dialogue_finished() -> void:
	_spawn_beasts()
