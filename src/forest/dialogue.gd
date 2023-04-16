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
			"func": Game.get_boomblaster
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
		"speaker": SPEAKER.Helper
	}
	
]

@onready var words : RichTextLabel = $HBox/Words
@onready var speaker : Sprite2D = $HBox/Container/Speaking
@onready var helper_sprite = preload("res://sprites/characters/helper-head.png")
@onready var hero_sprite = preload("res://sprites/characters/hero-head.png")


var _tween : Tween
var _current_line := 0
var _done_speaking := true

func next():
	show()
	if (!_done_speaking):
		_faster()
	elif (_current_line == lines.size()):
		Game.on_dialogue_finished.emit()
		queue_free()
	else:
		var line = lines[_current_line]
		_speak(line["words"], line["speaker"])
		if ("event" in line):
			if ("arg" in line["event"]):
				line["event"]["func"].call(line["event"]["arg"])
			else:
				line["event"]["func"].call()
		_current_line += 1

func _speak(what: String,  who: SPEAKER=SPEAKER.Same):
	if (who == SPEAKER.Helper):
		speaker.texture = helper_sprite
	if (who == SPEAKER.Hero):
		speaker.texture = hero_sprite
	
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
