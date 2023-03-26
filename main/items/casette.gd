extends Node2D
class_name Casette

func set_color(color: Color):
	$ColorBand.modulate = color

func set_mix_tape_number(n : int):
	$Label.text = "Mix tape #" + str(n)
