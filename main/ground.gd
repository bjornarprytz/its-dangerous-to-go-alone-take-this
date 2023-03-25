extends Node2D

@onready var moon_reflection_shader = preload("res://main/water_reflection_shader_material.tres")

@export var camera : Node2D

func _ready() -> void:
	assert(camera)

func _physics_process(_delta: float) -> void:
	var cam_x = Vector2(camera.position.x * 0.001, camera.position.y * 0.001 -100.0)
	moon_reflection_shader.set_shader_parameter("displacement", cam_x)
