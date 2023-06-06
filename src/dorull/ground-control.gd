extends CSGCylinder3D

@export	var rotate_speed := -.05

@onready var tree_spawner = preload("res://dorull/tree.tscn")

func _ready() -> void:
	for i in 250:
		spawn_tree()

func spawn_tree():
	print("Spawn tree")
	var tree = tree_spawner.instantiate() as PineTree
	
	add_child(tree)

	tree.rotate(Vector3.UP, randf_range(0, 360))
	# get the tree to the surface
	tree.tree_sprite.position.z = radius - 0.2
	tree.position.y = [randf_range(-4.0, -1.9), randf_range(-.5, 2.0)].pick_random()

func _physics_process(delta: float) -> void:
	rotate(Vector3.UP, rotate_speed * delta)
