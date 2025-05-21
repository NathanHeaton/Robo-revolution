extends CharacterBody2D


var speed = 300.0
const JUMP_VELOCITY = -400.0

var focusing = false
var looking_at_player = false
var focus_point = Vector2(0,0)
const rotation_speed = 2
var waiting = false
var searching = false
var searching_direction = 1

func _ready() -> void:
	UpgradeManager.connect("upgrade", Callable(self, "_upgrade"))
	$animations.play("idle_companion")
	
func set_inital_stats(t_speed):
	speed = t_speed


func _physics_process(delta: float) -> void:
	var relative_focus_point = focus_point - global_position
	if (focusing):
		randomize()
		var focus_dir = get_angle_to(focus_point)
		rotation = rotate_toward(rotation,focus_dir, deg_to_rad(15*rotation_speed) * -1 *delta)
		velocity = Vector2((relative_focus_point.x ),(relative_focus_point.y)) # adds some randomness to movement
		velocity = velocity.normalized() * speed
	else:
		velocity = Vector2(0,0)
		if(searching):
			rotate(deg_to_rad(2* searching_direction))#rotate_toward(rotation,randi_range(0,800))), deg_to_rad(15*rotation_speed) *delta)# rotates to a random place on the screen
	
	if(velocity != Vector2(0,0)):
		$animations.play("moving_animation")
	else:
		$animations.play("idle_companion")
	
	move_and_slide()



func _on_vision_body_entered(body: Node2D) -> void:
	if body is RigidBody2D && body.has_method("get_item"):
		focus_point = body.global_position
		focusing = true
	else:
		looking_at_player = true
		




func _rotate_to_focus():
	var focus_dir = get_angle_to(focus_point)


func _on_vision_body_exited(body: Node2D) -> void:
	focusing = false


func _on_grab_area_body_entered(body: Node2D) -> void:
	if body is RigidBody2D && body.has_method("get_item"):
		body.linear_velocity = Vector2.ZERO #cancels velocity
		var direction = get_viewport_rect().size/2 - body.global_position
		var distance = direction.length()
		distance = direction.normalized()
		var force = distance * 500
		body.reset_velocity()
		body.apply_central_impulse(force)
		ItemData.emit_signal("collected_item", body, body.get_item())
		#$collect_sfx.pitch_scale = randf_range(0.7, 1.3)
		#$collect_sfx.play()


func _on_wait_timeout() -> void:
	waiting = false
	searching = true
	searching_direction = randi_range(-1,1)
	if(searching_direction == 0):
		searching_direction = -1
	$searching.wait_time = randi_range(0.5,2.8)
	$searching.start()


func _on_searching_timeout() -> void:
	waiting = true
	searching = false
	$wait.wait_time = randf_range(0.5,0.8)
	$wait.start()
	
