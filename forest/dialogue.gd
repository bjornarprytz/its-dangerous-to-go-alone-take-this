extends Control
class_name Dialogue

enum SPEAKER {
	Same,
	Hero,
	Helper
}

var lines = [
	{
		"words": "It's dangerous to go alone! Take this!",
		"speaker": SPEAKER.Helper
	},
	{
		"words": "Thanks man!",
		"speaker": SPEAKER.Hero,
		"event": 
		{
			"emitter": Game.get_boomblaster
		}
	},
	{
		"words": "Don't thank me yet... it has no rewind button... heh :sweat_smile:",
		"speaker": SPEAKER.Helper
	},
	{
		"words": "...",
		"speaker": SPEAKER.Hero
	},
	{
		"words": "Don't worry though! There are several mix tapes scattered around the woods, and I found you one of them!",
		"speaker": SPEAKER.Helper
	},
	{
		"words": "You might actually survive getting through the forest if you find them all, heh.",
		"speaker": SPEAKER.Helper,
		"event": 
		{
			"emitter": Game.get_casette,
			"arg": CasetteData.Create(Color.BLUE, "Mix tape #7", preload("res://sound/takethis_oneminute.wav"))
		}
	}
	
]

@onready var words : RichTextLabel = $HBox/Words
@onready var speaker : Sprite2D = $HBox/Container/Speaking

var _tween : Tween
var _camera_tween : Tween
var _current_line : int = 0
var _done_speaking : bool = true

func next():
	if (!_done_speaking):
		_faster()
	elif (_current_line == lines.size()):
		Game.dialogue_finished.emit()
		queue_free()
	else:
		var line = lines[_current_line]
		_speak(line["words"], line["speaker"])
		if ("event" in line):
			if ("arg" in line["event"]):
				line["event"]["emitter"].emit(line["event"]["arg"])
			else:
				line["event"]["emitter"].emit()
		_current_line += 1

func _speak(what: String,  who: SPEAKER=SPEAKER.Same):
	if (who == SPEAKER.Helper):
		speaker.modulate = Color.YELLOW
	if (who == SPEAKER.Hero):
		speaker.modulate = Color.BLUE
	
	words.visible_ratio = 0.0
	_done_speaking = false
	words.text = what
	
	if (_tween != null):
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(words, 'visible_ratio', 1.0, 3.0)
	await _tween.finished
	
	_done_speaking = true

func _faster():
	if (_tween != null):
		_tween.kill()
	_done_speaking = true
	words.visible_ratio = 1.0
