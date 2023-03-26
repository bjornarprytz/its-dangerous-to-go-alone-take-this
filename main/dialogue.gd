extends Control
class_name Dialogue

signal dialogueFinished

var hero: Node2D
var helper: Node2D
var camera: Node2D

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
			"emitter": EventBus.get_item,
			"arg": preload("res://main/items/boomblaster.tscn")
		}
	},
	{
		"words": "Don't thank me yet... it has no rewind button... heh :sweat_smile:",
		"speaker": SPEAKER.Helper
	},
	{
		"words": "...",
		"speaker": SPEAKER.Hero
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
		dialogueFinished.emit()
		queue_free()
	else:
		var line = lines[_current_line]
		_speak(line["words"], line["speaker"])
		if ("event" in line):
			line["event"]["emitter"].emit(line["event"]["arg"])
		_current_line += 1
		

func _speak(what: String,  who: SPEAKER=SPEAKER.Same):
	if (who == SPEAKER.Helper):
		speaker.modulate = Color.YELLOW
	if (who == SPEAKER.Hero):
		speaker.modulate = Color.BLUE
		
	_focus_speaker(who)
	
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

func _focus_speaker(character: SPEAKER):
	if (_camera_tween != null):
		_camera_tween.kill()
	
	_camera_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	if (character == SPEAKER.Helper):
		_camera_tween.tween_property(camera, 'position', helper.position, 1.0)
	else:
		_camera_tween.tween_property(camera, 'position', hero.position, 1.0)
	
	await _camera_tween.finished
