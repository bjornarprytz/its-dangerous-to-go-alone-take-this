extends Node
class_name GameInterface

signal on_dialogue_finished()
signal on_game_win()
signal on_get_boomblaster()
signal on_pickup_casette(data: CasetteData)

var _tracks: Array[String]
var has_boomblaster: bool
var casettes_collected: Array[CasetteData]

@onready var end_music : CasetteData = CasetteData.Create(Color.ANTIQUE_WHITE, "End Credits", preload("res://sound/tracks/morningistheend - 02.04.2023, 12.26.wav"))

func win_game():
	AudioPlayer.switch(end_music)
	on_game_win.emit()

func get_boomblaster():
	if (has_boomblaster):
		push_error("Got boomblaster a second time, but why?")
	
	has_boomblaster = true
	on_get_boomblaster.emit()

func pick_up_casette(data: CasetteData):
	var track_name = data.music.resource_name
	
	var track_index = _tracks.find(track_name)
	if (track_index == -1):
		push_error("Could not find track: ", track_name)
	else:
		_tracks.remove_at(track_index)
		casettes_collected.push_back(data)
	
	on_pickup_casette.emit(data)

func _ready() -> void:
	var tracks = get_all_tracks("res://sound/tracks", ".wav")
	
	for t in tracks:
		_tracks.push_back(t)
	
func get_all_tracks(path: String, file_ext := "") -> Array[String]:
	var dir = DirAccess.open(path)
	var files : Array[String] = []
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name.ends_with(file_ext):
			if !dir.current_is_dir():
				files.push_back(file_name)
			file_name = dir.get_next()
	else:
		push_error("An error occurred when trying to get all tracks from path: ", path)
	
	return files
