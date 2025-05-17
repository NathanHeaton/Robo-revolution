extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_music_slider_value_changed(100) 
	_on_sfx_slider_value_changed(100) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1,linear_to_db(value))
	AudioServer.set_bus_mute(1, value < 0.05)


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2,linear_to_db(value))
	AudioServer.set_bus_mute(2, value < 0.05)


func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_mute(0, value < 0.05)
