extends Resource
class_name CasetteData

@export var color : Color
@export var label : String
@export var music : AudioStream


static func Create(c: Color, l: String, m: AudioStream) -> CasetteData:
	var data = CasetteData.new()
	data.color = c
	data.label = l
	data.music = m
	return data
