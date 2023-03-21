extends Camera2D

@export var player : Node2D

var lock_on_player: bool

func _ready() -> void:
	assert(player)

func _physics_process(_delta: float) -> void:
	if (lock_on_player):
		position = player.position
