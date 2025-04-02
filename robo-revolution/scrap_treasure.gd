extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contact_monitor = true
	
	max_contacts_reported = 1
	

func _spawn_loot_type(item):
	
	
	$AnimatedSprite2D.play(item.name)
	
	
	#print(scrap_treasure_types.filter( func(item): return item))
	#print(scrap_treasure_types.filter( func(item): return item == "scarp"))
	#$AnimatedSprite2D.animation = scrap_treasure_types.filter( func(item): return item == "scarp")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func get_value() -> int:
	return 3
