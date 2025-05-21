extends CharacterBody2D


var speed = 300.0
const JUMP_VELOCITY = -400.0

var focusing = false
var focus_point = Vector2(0,0)
const rotation_speed = 2

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
		velocity = Vector2((relative_focus_point.x + randi_range(-5,5)),(relative_focus_point.y)+ randi_range(-5,5)) # adds some randomness to movement
		velocity = velocity.normalized() * speed
		
	else:
		velocity = Vector2(0,0)
		
	
	if(velocity != Vector2(0,0)):
		$animations.play("moving_animation")
	else:
		$animations.play("idle_companion")
	
	move_and_slide()



func _on_vision_body_entered(body: Node2D) -> void:
	focus_point = body.global_position
	
	focusing = true




func _rotate_to_focus():
	var focus_dir = get_angle_to(focus_point)


func _on_vision_body_exited(body: Node2D) -> void:
	focusing = false
