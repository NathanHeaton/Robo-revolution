extends Node

@export var scrap_treasure: PackedScene

var item_data: Dictionary = {
	"scrap":{
		"name": "scrap",
		"value": 3,
		"rarity": 0,
		"type": "scrap",
		"weight": 3,
		"locations":[LocationData.locations.Scrapyard,LocationData.locations.Underground,LocationData.locations.Ocean,LocationData.locations.Alien], 
		"variants": 4
	},
	"plastic":{
		"name": "plastic",
		"value": 4,
		"rarity": 0,
		"type": "scrap",
		"weight": 2,
		"locations":[LocationData.locations.Scrapyard,LocationData.locations.Underground,LocationData.locations.Ocean], 
		"variants": 3
	},
	"rusty_nails":{
		"name": "rusty_nails",
		"value": 2,
		"rarity": 0,
		"type": "scrap",
		"weight": 1,
		"locations":[LocationData.locations.Scrapyard,LocationData.locations.Underground,LocationData.locations.Ocean], 
		"variants": 3
	},
	"gears":{
		"name": "gears",
		"value": 3,
		"rarity": 0,
		"type": "scrap",
		"weight": 1,
		"locations":[LocationData.locations.Scrapyard], 
		"variants": 4
	},
	"computer_chips": {
		"name": "computer_chips",
		"value": 6,
		"rarity": 1,
		"type": "scrap",
		"weight": 1,
		"locations": [LocationData.locations.Scrapyard, LocationData.locations.Underground],
		"variants": 3
	},
	"vehicle_components": {
		"name": "vehicle_components",
		"value": 10,
		"rarity": 1,
		"type": "scrap",
		"weight": 15,
		"locations": [LocationData.locations.Scrapyard, LocationData.locations.Underground],
		"variants": 2
	},
	"wires": {
		"name": "wires",
		"value": 4,
		"rarity": 1,
		"type": "scrap",
		"weight": 1,
		"locations": [LocationData.locations.Scrapyard, LocationData.locations.Underground],
		"variants": 3
	},
	"robot_parts": {
		"name": "robot_parts",
		"value": 50,
		"rarity": 2,
		"type": "scrap",
		"weight": 20,
		"locations": [LocationData.locations.Underground],
		"variants": 4
	},
	"motherboard": {
		"name": "motherboard",
		"value": 35,
		"rarity": 2,
		"type": "scrap",
		"weight": 2,
		"locations": [LocationData.locations.Underground],
		"variants": 3
	},
	"metal": {
		"name": "metal",
		"value": 40,
		"rarity": 2,
		"type": "scrap",
		"weight": 3,
		"locations": [LocationData.locations.Underground, LocationData.locations.Ocean],
		"variants": 4
	},
	"seashells": {
		"name": "seashells",
		"value": 700,
		"rarity": 3,
		"type": "scrap",
		"weight": 3,
		"locations": [LocationData.locations.Ocean],
		"variants": 3
	},
	"ship_wreckage": {
		"name": "ship_wreckage",
		"value": 1500,
		"rarity": 3,
		"type": "scrap",
		"weight": 50,
		"locations": [LocationData.locations.Ocean],
		"variants": 4
	},
	"broken_jewels": {
		"name": "broken_jewels",
		"value": 2000,
		"rarity": 3,
		"type": "scrap",
		"weight": 4,
		"locations": [LocationData.locations.Ocean],
		"variants": 4
	},
	"alien_parts": {
		"name": "alien_parts",
		"value": 4000,
		"rarity": 4,
		"type": "scrap",
		"weight": 50,
		"locations": [LocationData.locations.Alien],
		"variants": 3
	},
	"alien_scrap_metal": {
		"name": "alien_scrap_metal",
		"value": 3000,
		"rarity": 4,
		"type": "scrap",
		"weight": 30,
		"locations": [LocationData.locations.Alien],
		"variants": 4
	},
	"gold_plates": {
		"name": "gold_plates",
		"value": 60,
		"rarity": 0,
		"type": "treasure",
		"weight": 2,
		"locations": [LocationData.locations.Scrapyard, LocationData.locations.Underground],
		"variants": 2
	},
	"rubies": {
		"name": "rubies",
		"value": 80,
		"rarity": 1,
		"type": "treasure",
		"weight": 1,
		"locations": [LocationData.locations.Scrapyard, LocationData.locations.Underground, LocationData.locations.Ocean],
		"variants": 1
	},
	"gold_bars": {
		"name": "gold_bars",
		"value": 600,
		"rarity": 2,
		"type": "treasure",
		"weight": 7,
		"locations": [LocationData.locations.Underground],
		"variants": 1  # Unique appearance
	},
	"pearls": {
		"name": "pearls",
		"value": 9000,
		"rarity": 3,
		"type": "treasure",
		"weight": 1,
		"locations": [LocationData.locations.Ocean],
		"variants": 1 
	},
	"alien_artifacts": {
		"name": "alien_artifacts",
		"value": 50000,
		"rarity": 4,
		"type": "treasure",
		"weight": 3,
		"locations": [LocationData.locations.Alien],
		"variants": 1
	},
	"power_crystals": {
		"name": "power_crystals",
		"value": 1,  # figure out power crystal system later
		"rarity": 4,
		"type": "treasure",
		"weight": 1,
		"locations": [LocationData.locations.Alien],
		"variants": 1,
	}
}

var pickable_items = []
var pickable_scrap =[]
var pickable_treasure =[]

func spawn_item(location: String, type: String, item_scene):
	
	var item = pick_item(location, type)
	
	var item_instance = item_scene.instantiate()
	item_instance.z_index = -1
	item_instance._spawn_loot_type(item)
	
	return item_instance

func pick_item(location: String, type: String ):
	var item # the specific loot item that is picked
	for items in item_data: # goes through all items to find the right item
		if (item_data[items].get("rarity") <= GameStats.rarity_lvl && _in_correct_location(items)):
			item = item_data[items]
			if (item_data[items].get("type") == "scrap"):
				pickable_scrap.append(item)# adds the valid item that can be chosen from to an array
			else :
				pickable_treasure.append(item)
	
	_decide_luck()
	item = pickable_items.pick_random()
	
	return item


func _decide_luck():
	randomize()# makes vbarients more random
	var items = pickable_scrap
	var luck_roll =0
	
	luck_roll = randi_range(0,50)
	var luck_needed = 43 - int(GameStats.sum_luck_lvl() * (0.5 if LocationData.CURRENT_LOCATION == LocationData.locations.Scrapyard else 1))# if it is the scrapyard
	
	if (luck_roll >= luck_needed && pickable_treasure):
		items = pickable_treasure
	pickable_items = items

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _in_correct_location(items) -> bool:
	var in_location = false
	var locations = item_data[items]["locations"]
	for location in locations:
		if (location == LocationData.CURRENT_LOCATION):
			in_location = true
			return in_location
	return in_location
