extends RigidBody2D

signal collect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var collectors = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = collectors[0] # scrapyard collector

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass





func _on_body_entered(body: Node) -> void:
	collect.emit()
