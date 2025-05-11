extends Panel

var item_sprite_scene : PackedScene = preload("res://Scenes/item_sprites.tscn")
var amount = 0
var amount_completed = 0
var difficulty = 0
var item
var step
var complete = false
var failed = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_complete() -> bool:
	return complete

func set_complete():
	complete = true

func set_failed():
	failed = true

func get_item():
	return item
	

func update_amount_collected():
	amount_completed += 1
	if amount_completed == amount:
		set_complete()
	_change_description()

func get_intial_data(t_amount, t_difficulty, t_step):
	step = t_step
	amount = t_amount
	difficulty = t_difficulty
	var item_name = pick_item()
	item = ItemData.items[item_name]
	_change_sprite()
	_change_description()
	_change_amount()


func _change_sprite():
	var sprite = item_sprite_scene.instantiate()
	sprite.play(item.name)
	sprite.speed_scale = 0.1
	sprite.centered = false
	sprite.get_child(0).visible = false
	$task/HBoxContainer/loot_texture.add_child(sprite)
	

func _change_description():
	$task/HBoxContainer/loot_details.text = str(step)+ ". " + item["name"] + " "+ str(amount_completed)+"/" + str(amount)
	

func _change_amount():
	pass

var pickable_scrap = []

func pick_item():
	var rnd_item # the specific loot item that is picked
	for item in ItemData.items: # goes through all items to find the right item
		if (ItemData.items[item].get("rarity") <= GameStats.stats["luck"]["rarity_lvl"] && _in_correct_location(item)):
			rnd_item = ItemData.items[item]
			if (ItemData.items[item].get("type") == "scrap"):
				pickable_scrap.append(item)# adds the valid item that can be chosen from to an array
	rnd_item = pickable_scrap.pick_random()
	
	return rnd_item



func _in_correct_location(item) -> bool:
	var in_location = false
	var locations = ItemData.items[item]["locations"]
	for location in locations:
		if (location == LocationData.CURRENT_LOCATION):
			in_location = true
			return in_location
	return in_location
	
