extends Node

@export var scrap_treasure: PackedScene
# Called when the node enters the scene tree for the first time.



func _ready() -> void:
	newGame()
	Money.MONEY = 51000000000
	GameStats.item_spawn_region = [Vector2(30,30),Vector2(1920 - 60, 1080 - 60)]
	UpgradeManager.connect("upgrade", Callable(self, "_upgrade"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_item_collector_collect(body: Node) -> void:
	Money.MONEY += body.get_value()
	$HUD.update_money()
	
	
	body.collect()
	
	

func newGame():
	Money.MONEY = 0
	$HUD.show_message("Collect Scrap and treasure")
	$HUD.update_money()
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
	if (rndLocation.x > 820 && rndLocation.x < 1150):
		if(rndLocation.y > 325 && rndLocation.y < 725):
			rndLocation = Vector2(rndLocation.x + 400, rndLocation.y+ 400)
	
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
	
