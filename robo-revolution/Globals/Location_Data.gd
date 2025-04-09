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
	
	
var location_data: Dictionary = {
	locations.Scrapyard:{
		"id": 0,
		"name": "Scrapyard",
		"description" : "Increase chance to spawn trash items",
		"unlocked": true,
		"key_needed": false,
		"base_cost": 0,
		"priColour": "#CE3CDF",
		"secColour": "#AB1FBB",
		"sprite_position": Vector2(0,0)
	},
	locations.Underground:{
		"id": 1,
		"name": "Underground",
		"description" : "Increase chance to spawn trash items",
		"unlocked": false,
		"key_needed": false,
		"base_cost": 5000,
		"priColour": "#DF3E3C",
		"secColour": "#B32617",
		"sprite_position": Vector2(1,0)
	},
	locations.Ocean:{
		"id": 2,
		"name": "Ocean",
		"description" : "Increase chance to spawn trash items",
		"unlocked": false,
		"base_cost": 45600,
		"key_needed": false,
		"priColour": "#3C6EDF",
		"secColour": "#1343AE",
		"sprite_position": Vector2(0,1)
	},
	locations.Alien:{
		"id": 3,
		"name": "Alien",
		"description" : "Increase chance to spawn trash items",
		"unlocked": false,
		"base_cost": 57800000,
		"key_needed": true,
		"priColour": "#3CDFB6",
		"secColour": "#1FC198",
		"sprite_position": Vector2(1,1)
	}
}



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(locations.Scrapyard)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
