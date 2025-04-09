extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LocationData.connect("change_location",Callable(self, "_on_location_change"))
	print(LocationData.location_data[LocationData.CURRENT_LOCATION].get("name"))
	_on_location_change()





func _on_location_change():
	print(LocationData.location_data[LocationData.CURRENT_LOCATION].get("name"))
	play(LocationData.location_data[LocationData.CURRENT_LOCATION].get("name"))
