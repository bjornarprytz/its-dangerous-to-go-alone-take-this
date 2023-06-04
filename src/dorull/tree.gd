extends Node3D
class_name PineTree


@onready var tree_sprite : Sprite3D = $Tree

func _ready() -> void:
	var total_frames = tree_sprite.hframes * tree_sprite.vframes
	var random_frame = randi() % total_frames
	tree_sprite.frame = random_frame
