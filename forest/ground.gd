extends Node2D
class_name ForestMap

signal entered_cave

@onready var moon_reflection_shader = preload("res://forest/water_reflection_shader_material.tres")
@onready var casettes = $Casettes

@export var camera : Node2D

func _ready() -> void:
	assert(camera)

func _physics_process(_delta: float) -> void:
	var cam_x = Vector2(camera.position.x * 0.001, camera.position.y * 0.001 -100.0)
	moon_reflection_shader.set_shader_parameter("displacement", cam_x)


func _on_cave_entrance_body_entered(body):
	if (body is Player):
		entered_cave.emit()
