extends Node

@export var scrap_treasure: PackedScene


var pickable_items = []
var pickable_scrap = []
var pickable_treasure = []

func spawn_item(location: String, type: String, item_scene):
	var item = pick_item()
	var item_instance = item_scene.instantiate()
	item_instance.z_index = -1
	item_instance.spawn_loot_type(ItemData.items[item])
	return item_instance

func pick_item():
	var rnd_item # the specific loot item that is picked
	for item in ItemData.items: # goes through all items to find the right item
		if (ItemData.items[item].get("rarity") <= GameStats.stats["luck"]["rarity_lvl"] && _in_correct_location(item)):
			rnd_item = ItemData.items[item]
			if (ItemData.items[item].get("type") == "scrap"):
				pickable_scrap.append(item)# adds the valid item that can be chosen from to an array
			else :
				pickable_treasure.append(item)
	_decide_luck()
	rnd_item = pickable_items.pick_random()
	
	return rnd_item

func _decide_luck():
	randomize()# makes vbarients more random
	var items = pickable_scrap
	var luck_roll =0
	luck_roll = randi_range(0,50)
	var luck_needed = 43 #- int(GameStats.stats["luck"]["scrapyard"] * (0.5 if LocationData.CURRENT_LOCATION == LocationData.locations.Scrapyard else 1))# if it is the scrapyard
	
	if (luck_roll >= luck_needed && pickable_treasure):
		items = pickable_treasure
	pickable_items = items

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _in_correct_location(item) -> bool:
	var in_location = false
	var locations = ItemData.items[item]["locations"]
	for location in locations:
		if (location == LocationData.CURRENT_LOCATION):
			in_location = true
			return in_location
	return in_location
