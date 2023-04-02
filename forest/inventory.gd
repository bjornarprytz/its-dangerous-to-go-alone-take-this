extends Control
class_name Inventory


@onready var boomblaster_spawner = preload("res://forest/items/boomblaster.tscn")
@onready var casette_spawner = preload("res://forest/items/casette_ui.tscn")

func _ready():
	if (Game.has_boomblaster):
		add_boomblaster()
	Game.on_get_boomblaster.connect(add_boomblaster)
	Game.on_pickup_casette.connect(add_casette)

func add_boomblaster():
	var boomblaster = boomblaster_spawner.instantiate() as Control
	_add_item(boomblaster)

func add_casette(data: CasetteData):
	var casette = casette_spawner.instantiate() as CasetteUI
	casette.set_data(data)
	_add_item(casette)

func _add_item(item: Control):
	$VBox.add_child(item)
	$VBox.move_child(item, 0)
	
	var blink_timer = get_tree().create_timer(0.5)
	
	for i in 6:
		await  blink_timer.timeout
		if (i % 2 == 0):
			item.hide()
		else:
			item.show()
		blink_timer = get_tree().create_timer(0.5)
