extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LocationData.connect("change_location",Callable(self, "_on_location_change"))
	_on_location_change()





func _on_location_change():
	play(LocationData.location_data[LocationData.CURRENT_LOCATION].get("name"))
