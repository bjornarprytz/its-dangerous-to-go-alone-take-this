extends CanvasLayer
class_name TakeThisUI

@onready var dialogue : Dialogue = $Dialogue
@onready var inventory : Inventory = $Inventory


@export var hero: Node2D
@export var helper: Node2D
@export var camera: Node2D

func _ready():
	dialogue.hero = hero
	dialogue.helper = helper
	dialogue.camera = camera
