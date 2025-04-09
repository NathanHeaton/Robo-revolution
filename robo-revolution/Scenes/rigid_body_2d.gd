extends Area2D

signal collect(body)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var collectors = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = collectors[0] # scrapyard collector
	z_index = -2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass





func _on_body_entered(body: Node) -> void:
	if body is RigidBody2D:
		emit_signal("collect", body)
		body.linear_velocity = Vector2.ZERO #cancels velocity
		var direction = get_viewport_rect().size/2 - body.global_position
		var distance = direction.length()
		distance = direction.normalized()
		var force = distance * 200
		body.apply_central_impulse(force)
