extends RigidBody2D

var value = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()# makes vbarients more random
	contact_monitor = true
	
	max_contacts_reported = 1
	

func _spawn_loot_type(item):
	
	$AnimatedSprite2D.play(item.name)
	var rnd_frame = randi_range(0,item.variants-1)
	print(rnd_frame)
	print(item.name)
	$AnimatedSprite2D.frame = rnd_frame

	$AnimatedSprite2D.pause()
	value = item.value
	mass = item.weight
	
	#print(scrap_treasure_types.filter( func(item): return item))
	#print(scrap_treasure_types.filter( func(item): return item == "scarp"))
	#$AnimatedSprite2D.animation = scrap_treasure_types.filter( func(item): return item == "scarp")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func get_value() -> int:
	return value
	
