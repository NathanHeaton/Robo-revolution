extends Area2D

func _ready() -> void:
	z_index = -2
	set_collector()
	LocationData.connect("change_location", Callable(self,"set_collector"))


func _on_body_entered(body: Node) -> void:

	if body is RigidBody2D && body.has_method("get_item"):
		body.linear_velocity = Vector2.ZERO #cancels velocity
		var direction = get_viewport_rect().size/2 - body.global_position
		var distance = direction.length()
		distance = direction.normalized()
		var force = distance * 500
		body.reset_velocity()
		body.apply_central_impulse(force)
		set_collection_animation()
		ItemData.emit_signal("collected_item", body, body.get_item())
		$collect_sfx.pitch_scale = randf_range(0.7, 1.3)
		$collect_sfx.play()
		

func set_collector():
	$collectors.play(LocationData.location_data[LocationData.CURRENT_LOCATION]["name"]+"_standby")


func set_collection_animation():
	$collectors.play(LocationData.location_data[LocationData.CURRENT_LOCATION]["name"]+"_collect")
	$collection_time.start()

func _on_collection_time_timeout() -> void:
	set_collector()
