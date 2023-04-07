extends Node2D
class_name ForestMap

signal entered_cave

func _on_cave_entrance_body_entered(body):
	if (body is Player):
		entered_cave.emit()
