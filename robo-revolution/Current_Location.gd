extends Node

signal change_location

# all locations
enum locations {Scrapyard,
Underground,
Ocean,
Alien
}
# current location
var CURRENT_LOCATION = locations.Scrapyard

# convert enum to string when needed
var location_to_string: Dictionary = {
	locations.Scrapyard:"Scrapyard",
	locations.Underground:"Underground",
	locations.Ocean:"Ocean",
	locations.Alien:"Alien"}


func get_current_locations()->locations:
	emit_signal("change_location")
	return CURRENT_LOCATION

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(locations.Scrapyard)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
