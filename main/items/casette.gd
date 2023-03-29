@tool
extends Node2D
class_name Casette

func set_data(data : CasetteData):
	$Label.text = data.label
	$ColorBand.modulate = data.color
	
