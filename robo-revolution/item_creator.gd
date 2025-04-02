extends Node

@export var scrap_treasure: PackedScene

var item_data: Dictionary = {
	"scrap":{
		"name": "scrap",
		"value": 3,
		"rarity": 0,
		"type": "scrap",
		"weight": 2,
		"locations":["Scrapyard","UndergroundStorage"] 
	},
	"plastic":{
		"name": "plastic",
		"value": 3,
		"rarity": 3,
	},
}

func spawn_item(rarity: int, location: String, type: String, item_scene):
	
	var item = pick_item(rarity, location, type)
	
	var item_instance = item_scene.instantiate()
	item_instance._spawn_loot_type(item)
	
	return item_instance

func pick_item(rarity: int, location: String, type: String ):
	var item # the specific loot item that is picked
	var keys = item_data.keys()
	
	for items in item_data: # goes through all items to find the right item
		if (item_data[items].get("rarity") == rarity):
			item = item_data[items]
		
	
	return item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
