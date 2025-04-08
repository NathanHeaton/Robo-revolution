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
# convert enum to string when needed
var location_to_string: Dictionary = {
	locations.Scrapyard:"Scrapyard",
	locations.Underground:"Underground",
	locations.Ocean:"Ocean",
	locations.Alien:"Alien"}
	

var location_data: Dictionary = {
	locations.Scrapyard:{
		"name": "Scrapyard",
		"description" : "Increase chance to spawn trash items",
		"unlocked": true,
		"cost": 0,
		"priColour": "#CE3CDF",
		"secColour": "#AB1FBB",
		"sprite_position": Vector2(0,0)
	},
	locations.Underground:{
		"name": "Underground",
		"description" : "Increase chance to spawn trash items",
		"unlocked": false,
		"cost": 5000,
		"priColour": "#CE3CDF",
		"secColour": "#AB1FBB",
		"sprite_position": Vector2(1,0)
	},
	locations.Ocean:{
		"name": "Ocean",
		"description" : "Increase chance to spawn trash items",
		"unlocked": false,
		"cost": 5000000,
		"priColour": "#CE3CDF",
		"secColour": "#AB1FBB",
		"sprite_position": Vector2(0,1)
	},
	locations.Alien:{
		"name": "Alien",
		"description" : "Increase chance to spawn trash items",
		"unlocked": false,
		"cost": 500000000,
		"priColour": "#CE3CDF",
		"secColour": "#AB1FBB",
		"sprite_position": Vector2(1,1)
	}
}



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(locations.Scrapyard)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
