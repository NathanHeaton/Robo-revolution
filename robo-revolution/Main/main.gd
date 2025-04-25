extends Node

@export var scrap_treasure: PackedScene
# Called when the node enters the scene tree for the first time.



func _ready() -> void:
	newGame()
	Money.MONEY = 51000000000
	Money.POWER_C = 35
	GameStats.item_spawn_region = [Vector2(30,30),Vector2(1920 - 60, 1080 - 60)]
	UpgradeManager.connect("upgrade", Callable(self, "_upgrade"))
	$HUD.connect("prestiged", Callable(self, "_prestige"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match LocationData.CURRENT_LOCATION:
		LocationData.locations.Scrapyard:
			pass
		LocationData.locations.Underground:
			_underground_hazards()
		LocationData.locations.Ocean:
			_ocean_hazards()
		LocationData.locations.Alien:
			print("in Alien")
			

func _ocean_hazards():
	if (GameStats.water_proof):
		return
	elif ( GameStats.basic_water_proof > 0):
		GameStats.health = GameStats.health - (4 - GameStats.basic_water_proof)
	else:
		GameStats.health = GameStats.health - 4

var first_time_in_underground = true

func _underground_hazards():
	if (first_time_in_underground):
		$power_surge.start()
		first_time_in_underground = false
	

	
func _on_item_collector_collect(body: Node) -> void:
	if (body.get_type() == "money"):
		Money.MONEY += body.get_value()
	elif (body.get_type() == "powerC"):
		Money.POWER_C += body.get_value()
	#$HUD.update_money()
	
	
	body.collect()
	
	

func _prestige():
	Money.POWER_C += Money.MONEY / GameStats.powerC_conversion_rate
	Money.MONEY = 0

func newGame():
	Money.MONEY = 0
	$HUD.show_message("Collect Scrap and treasure")
	#$Player.position($Start_Position.position)
	

func _upgrade(upgrade):
	match upgrade["name"]:
		"Spawn Rate":
			_spawnrate_upgrade(upgrade["level"])
		"Rarity":
			_rarity_upgrade(upgrade["level"])
		"Rarity+":
			_rarity_upgrade_plus(upgrade["level"])
		"Rarity++":
			_rarity_upgrade_2plus(upgrade["level"])
		"Rarity+++":
			_rarity_upgrade_3plus(upgrade["level"])
		"Item Focuser":
			_item_focuser_upgrade(upgrade["level"])


func _spawnrate_upgrade(level: int):
	var wait = snapped(clamp(4 +log(level +1)*-1.15,0.1,5),0.01)
	$loot_spawn_timer.wait_time = wait

func _rarity_upgrade(level: int):
	if (level == 1):
		GameStats.rarity_lvl +=1
	GameStats.luck_lvl[0] = level

func _rarity_upgrade_plus(level: int):
	if (level == 1):
		GameStats.rarity_lvl +=1
	GameStats.luck_lvl[1] = level

func _rarity_upgrade_2plus(level: int):
	if (level == 1):
		GameStats.rarity_lvl +=1
	GameStats.luck_lvl[2] = level
	
func _rarity_upgrade_3plus(level: int):
	if (level == 1):
		GameStats.rarity_lvl +=1
	GameStats.luck_lvl[3] = level
	print(GameStats.luck_lvl)

func _item_focuser_upgrade(level: int):
	var x = 30+log(level+1)* 150
	GameStats.item_spawn_region = [Vector2(x,x),Vector2(1920 - x, 1080 - x)]


func respawn():
	Money.MONEY = Money.MONEY * 0.1
	#$Player.start($Start_Position.position)
	

func item_spawn_location() -> Vector2: # picks where to spawn the loot items and avoids the center of the screen
	var rndLocation = Vector2(
	randi_range(GameStats.item_spawn_region[0].x,GameStats.item_spawn_region[1].x),
	randi_range(GameStats.item_spawn_region[0].y,GameStats.item_spawn_region[1].y)
	)
	if (rndLocation.x > 820 && rndLocation.x < 1150):#spawned ontop of the collector
		if(rndLocation.y > 325 && rndLocation.y < 725):
			item_spawn_location()
	
	return rndLocation



func _spawn_loot() -> void:
	var loot = $Item_creator.spawn_item("Scrapyard", "scrap", scrap_treasure)
	
	var rotation_dir = 0
	rotation_dir = randf_range(-PI / 4, PI/4)
	
	loot.position = item_spawn_location()
	loot.rotation = rotation_dir
	
	add_child(loot) #adds loot to main scene


func _on_hud_start_game() -> void:
	newGame()
	

var time_for_surge = 20
func _on_power_surge_timeout() -> void:
	$surge_duration.start()
	
	GameStats.health = GameStats.health - 10
	
	
	
func _update_surge_time():
	time_for_surge = randf_range(time_for_surge-3,time_for_surge+3)
	$power_surge.wait_time = time_for_surge
	


func _on_surge_duration_timeout() -> void:# surge has ended
	print("surge has ended")
	_update_surge_time()
	$power_surge.start()
	print(	$power_surge.wait_time, " is the new surge wait time")
