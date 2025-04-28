extends CharacterBody2D
signal push

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	UpgradeManager.connect("upgrade", Callable(self, "_upgrade"))

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
		velocity = velocity.normalized() * GameStats.stats["physical"]["speed"]
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
			body.apply_central_impulse(push_direction * GameStats.stats["physical"]["strength"])  # Adjust push force


func _on_body_entered(body: Node2D) -> void:
	#hide()
	push.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	 # function for pushing items
	

func _upgrade(upgrade):
	match upgrade["name"]:
		"Speed":
			speed_upgrade(upgrade["level"])
		"Strength":
			strength_upgrade(upgrade["level"])
		"Combo":
			combo_upgrade(upgrade["level"])
		"Combo Increase":
			combo_increase_upgrade(upgrade["level"])
		"Surge Protection":
			surge_protection_upgrade(upgrade["level"])
		"Armour":
			Armour_upgrade(upgrade["level"])
		"Water Proof":
			Water_Proof_upgrade(upgrade["level"])
		"Basic Waterproofing":
			Basic_Waterproofing_upgrade(upgrade["level"])
		"Surge Redistributor":
			Surge_Redistributor_upgrade(upgrade["level"])


func strength_upgrade(level: int):
	var new_strength = 1 + log(level + 2) * 15 + (level / 5)
	GameStats.set_stat("physical", "strength", new_strength)
	GameStats.set_stat("physical", "max_health", GameStats.stats["physical"]["max_health"] + level * 15)

func speed_upgrade(level: int):
	var new_speed = 400 + log(level + 2) * 50
	GameStats.set_stat("physical", "speed", new_speed)

func combo_upgrade(level: int):
	print("Applying Combo upgrade, level:", level)

func combo_increase_upgrade(level: int):
	print("Applying Combo Increase upgrade, level:", level)

func surge_protection_upgrade(level: int):
	GameStats.set_stat("physical", "surge_protection", level)
	print("Surge Protection:", level)

func Armour_upgrade(level: int) -> void:
	var new_armour_mult = snapped(1 + log(level) * 2, 0.1)
	GameStats.set_stat("physical", "armour_mult", new_armour_mult)
	print(new_armour_mult, "armour lvl", level)

func Water_Proof_upgrade(level: int) -> void:
	GameStats.set_stat("physical", "water_proof", true)
	GameStats.set_stat("physical", "max_health", GameStats.stats["physical"]["max_health"] + level * 100)

func Basic_Waterproofing_upgrade(level: int) -> void:
	GameStats.set_stat("physical", "basic_water_proof", level)


func Surge_Redistributor_upgrade(level: int) -> void:
	pass


func _on_regen_timeout() -> void:
	if(GameStats.stats["physical"]["health"] < GameStats.stats["physical"]["max_health"] && LocationData.CURRENT_LOCATION == LocationData.locations.Scrapyard):
		GameStats.set_stat("physical","health", GameStats.stats["physical"]["health"] + 2)
