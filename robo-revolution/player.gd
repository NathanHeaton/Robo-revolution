extends CharacterBody2D
signal push

@export var speed = 400
@export var health = 100
var screen_size
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

func _spawn():
	position = Vector2.ZERO
	show()
	$CollisionShape2D.disabled = false
	

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	var mouse_pos = get_viewport().get_mouse_position()
	var angle_to_mouse = (mouse_pos - position).angle() + deg_to_rad(90)
	
	if Input.is_action_pressed("move_right"):
		velocity.x +=1
	if Input.is_action_pressed("move_up"):
		velocity.y -=1
	if Input.is_action_pressed("move_left"):
		velocity.x -=1
	if Input.is_action_pressed("move_down"):
		velocity.y +=1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:	
		$AnimatedSprite2D.stop()
	

	$AnimatedSprite2D.rotation = angle_to_mouse
	$player_body.rotation = angle_to_mouse - deg_to_rad(90)

	$pushing_area.rotation = angle_to_mouse
	
	move_and_slide()
	
	
	position = position.clamp(Vector2.ZERO,screen_size)
	
	for body in $pushing_area.get_overlapping_bodies():  # Use Area2D method
		if body is RigidBody2D:
			var push_direction = (body.position - position).normalized()
			body.apply_central_impulse(push_direction * 5)  # Adjust push force




func _on_body_entered(body: Node2D) -> void:
	#hide()
	push.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	 # function for pushing items
