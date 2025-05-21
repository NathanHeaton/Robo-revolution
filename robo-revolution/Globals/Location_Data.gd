extends Node

signal change_location

# all locations
enum locations {Scrapyard,
Underground,
Ocean,
Alien
}
# current location
var CURRENT_LOCATION_SAFE: locations = locations.Scrapyard

var CURRENT_LOCATION: locations = locations.Scrapyard:
	get:
		return CURRENT_LOCATION_SAFE
	set(value):
		CURRENT_LOCATION_SAFE = value
		emit_signal("change_location")
	


var location_to_enum = {
	"Alien":3,
	"Scrapyard":0,
	"Underground":1,
	"Ocean":2,
	
}

var location_data: Dictionary = {
	locations.Scrapyard:{
		"id": 0,
		"name": "Scrapyard",
		"description" : "Increase chance to spawn trash items.\nContains: scrap, plastic, rusty nails, gears, computer chips, vehicle components, wires, gold plates, rubies",
		"unlocked": true,
		"key_needed": false,
		"base_cost": 0,
		"sprite_position": Vector2(290,65)
	},
	locations.Underground:{
		"id": 1,
		"name": "Underground",
		"description" : "Be careful of power surges\nContains: scrap, plastic, rusty nails, computer chips, vehicle components, wires, robot_parts, motherboard, metal, gold plates, rubies, gold_bars",
		"unlocked": false,
		"key_needed": false,
		"base_cost": 5000,
		"sprite_position": Vector2(800,190)
	},
	locations.Ocean:{
		"id": 2,
		"name": "Ocean",
		"description" : "Water dammage likely.\nContains: scrap, plastic, rusty nails, metal, seashells, ship wreckage, broken jewels, rubies, pearls",
		"unlocked": false,
		"base_cost": 45600,
		"key_needed": false,
		"sprite_position": Vector2(32,285)
	},
	locations.Alien:{
		"id": 3,
		"name": "Alien",
		"description" : "watch out for alien patrollers.\nContains: scrap, alien parts, alien scrap metal, alien artifacts, power crystals",
		"unlocked": false,
		"base_cost": 5780000,
		"key_needed": true,
		"sprite_position": Vector2(800,400)
	}
}
