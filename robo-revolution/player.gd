extends Area2D

@export var speed = 400
@export var health = 100
var screen_size
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	var mouse_pos = get_viewport().get_mouse_position()
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
		
	
	
	$AnimatedSprite2D.rotation = (mouse_pos - position).angle() + deg_to_rad(90)
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO,screen_size)
