extends Control
class_name Inventory


func _ready():
	EventBus.get_item.connect(add_item)

func add_item(item_spawner: PackedScene):
	var item = item_spawner.instantiate() as Control
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
