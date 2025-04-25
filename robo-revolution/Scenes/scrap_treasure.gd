extends RigidBody2D

var value = 0
var item 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()# makes vbarients more random
	if (LocationData.CURRENT_LOCATION == 2):
		linear_damp = 0.5
	else:
		linear_damp = 2.0  # Higher = more resistance
	

func _spawn_loot_type(t_item):
	item = t_item
	if (item == null):
		print("error: item is null")
		return
	$AnimatedSprite2D.play(item.name)
	var rnd_frame = randi_range(0,item.variants-1)
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
	

func get_type():
	var type = "money"
	if (item.name == "power_crystals"):
		type = "powerC"
		
	return type

func _on_despawn_start_timeout() -> void:
	$fade_out_player.play("fade_out")


func _on_fade_out_player_animation_finished(anim_name: StringName) -> void:
	queue_free()


func collect():
	$fade_out_player.stop()
	$CollisionShape2D.disabled = true
	$collect.play("collect")
	
	



func _on_collect_animation_finished(anim_name: StringName) -> void:
	
	queue_free()
