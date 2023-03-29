extends Resource
class_name CasetteData

@export var color : Color
@export var label : String


static func Create(c: Color, l: String) -> CasetteData:
	var data = CasetteData.new()
	data.color = c
	data.label = l
	return data
