extends Camera2D

@export var player : Node2D

@onready var ui : TakeThisUI = $UI
@onready var curtain = $Curtain

@onready var moon_reflection_shader = preload("res://forest/water_reflection_shader_material.tres")

var lock_on_player: bool

func _ready() -> void:
	assert(player)

func _physics_process(_delta: float) -> void:
	if (lock_on_player):
		position = player.position
	
	moon_reflection_shader.set_shader_parameter("parallax_offset", (-position - Vector2(0.0, 150.0)))
