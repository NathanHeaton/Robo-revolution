extends Node

@export var scrap_treasure: PackedScene
@export var cost_display: PackedScene
@export var companions: PackedScene
# Called when the node enters the scene tree for the first time.


signal rarity_upgraded(rarity)

func _ready() -> void:
	newGame()
	Money.MONEY = 51000000000
	Money.POWER_C = 35
	GameStats.set_stat("luck","item_spawn_region", Rect2(Vector2(30,30),Vector2(1920 - 60, 1080 - 60)))
	UpgradeManager.connect("upgrade", Callable(self, "_upgrade"))
	connect("rarity_upgraded",Callable($Player, "_set_rarity_sprite"))
	$HUD.connect("prestiged", Callable(self, "_prestige"))
	if (GameStats.stats["companion"]["amount"] > 0):
		_spawn_companions()

func _spawn_companions():
	for companion in GameStats.stats["companion"]["amount"]:
		var new_comp = companions.instantiate()
		add_child(new_comp)
		new_comp.position = Vector2(400, 800)


# Called every frame. 'delta' is the elapsed time since the previous frame
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
	if (GameStats.stats["physical"]["water_proof"]):
		return
	elif (GameStats.stats["physical"]["basic_water_proof"] > 0):
		GameStats.set_stat("physical", "health", GameStats.stats["physical"]["health"] - (4 - GameStats.stats["physical"]["basic_water_proof"]))
	else:
		GameStats.set_stat("physical", "health", GameStats.stats["physical"]["health"] - 4)

var first_time_in_underground = true

func _underground_hazards():
	if (first_time_in_underground):
		$power_surge.start()
		first_time_in_underground = false
	

func _apply_mult_to_collected_item(value):
	value = (value * GameStats.stats["mult"]["powerC_mult"])
	return value

func _on_item_collector_collect(body: Node) -> void:
	var gain = 1
	if (body.get_currency() == "money"):
		gain = _apply_mult_to_collected_item(body.get_value())
		Money.MONEY += gain
	elif (body.get_currency() == "powerC"):
		gain = body.get_value()
		Money.POWER_C += gain
	#$HUD.update_money()
	print(cost_display)
	_handle_collected_item_text(body,gain)
	body.collect()

func _handle_collected_item_text(body,gain):
	var cost_display_scene = cost_display.instantiate()
	cost_display_scene.position = body.position
	cost_display_scene.setup_animation(body.get_value(),body.get_currency(),body.get_type(),gain)
	add_child(cost_display_scene)

func _prestige():
	Money.POWER_C += Money.MONEY / GameStats.stats["other"]["powerC_conversion_rate"]
	Money.MONEY = 0
	_reset_upgrades()
	

func _reset_upgrades():
	for upgradeSections in UpgradeData.upgrades.keys():
		for upgrades in UpgradeData.upgrades[upgradeSections]:
			var current = UpgradeData.upgrades[upgradeSections][upgrades]
			current["cost"] = current["base_cost"]
			current["level"] = 0
			UpgradeManager.emit_signal("level_changed", current["id"])


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
		"3X Sell Value":
			_3X_Sell_Value_upgrade(upgrade["level"])
		"Alien Key":
			_give_alien_key()

func _spawnrate_upgrade(level: int):
	GameStats.set_stat("luck","spawn_time",snapped(clamp(4 + log(level + 1) * -1.15, 0.1, 5), 0.01))
	$loot_spawn_timer.wait_time = GameStats.stats["luck"]["spawn_time"]

func _give_alien_key():
	GameStats.set_stat("other","alien_key", true)
func _rarity_upgrade(level: int):
	if 	GameStats.stats["luck"]["scrapyard"] < 1:
		GameStats.stats["luck"]["rarity_lvl"] + 1
		GameStats.set_stat("luck", "rarity_lvl",null )
		emit_signal("rarity_upgraded","rarity")
	GameStats.set_stat("luck","scrapyard", level)

func _rarity_upgrade_plus(level: int):
	if GameStats.stats["luck"]["underground"] < 1:
		GameStats.stats["luck"]["rarity_lvl"] + 1
		GameStats.set_stat("luck", "rarity_lvl", null)
		emit_signal("rarity_upgraded","rarity+")
	GameStats.set_stat("luck","underground", level)

func _rarity_upgrade_2plus(level: int):
	if (GameStats.stats["luck"]["ocean"] < 1):
		GameStats.stats["luck"]["rarity_lvl"] + 1
		GameStats.set_stat("luck", "rarity_lvl",null )
		emit_signal("rarity_upgraded","rarity++")
	GameStats.set_stat("luck","ocean", level)

func _rarity_upgrade_3plus(level: int):
	if (GameStats.stats["luck"]["alien"] < 1):
		GameStats.stats["luck"]["rarity_lvl"] + 1
		GameStats.set_stat("luck", "rarity_lvl",null )
		emit_signal("rarity_upgraded","rarity+++")
	GameStats.set_stat("luck","alien", level)

func _3X_Sell_Value_upgrade(level: int):
	GameStats.set_stat("mult", "powerC_mult", level * 3)

func _item_focuser_upgrade(level: int):
	var x = 30 + log(level + 1) * 150
	GameStats.set_stat("luck", "item_spawn_region", Rect2(Vector2(x, x), Vector2(1920 - x, 1080 - x)))

func respawn():
	Money.MONEY = Money.MONEY * 0.1
	#$Player.start($Start_Position.position)

func item_spawn_location() -> Vector2: # picks where to spawn the loot items and avoids the center of the screen
	var rndLocation = Vector2(
	randi_range(GameStats.stats["luck"]["item_spawn_region"].position.x,GameStats.stats["luck"]["item_spawn_region"].size.x),
	randi_range(GameStats.stats["luck"]["item_spawn_region"].position.y,GameStats.stats["luck"]["item_spawn_region"].size.y)
	)
	if (rndLocation.x > 820 && rndLocation.x < 1150):#spawned ontop of the collector
		if(rndLocation.y > 325 && rndLocation.y < 725):
			item_spawn_location()
	return rndLocation

func _spawn_loot() -> void:
	var loot = $Item_creator.spawn_item("Scrapyard", "scrap", scrap_treasure)
	var rotation_dir = 0
	rotation_dir = randf_range(-PI / 4, PI/4)
	add_child(loot) #adds loot to main scene
	loot.position = item_spawn_location()
	loot.rotation = rotation_dir

func _on_hud_start_game() -> void:
	newGame()

var time_for_surge = 20
func _on_power_surge_timeout() -> void:
	$surge_duration.start()
	GameStats.set_stat("physical", "health", GameStats.stats["physical"]["health"] - 10)

func _update_surge_time():
	time_for_surge = randf_range(time_for_surge-3,time_for_surge+3)
	$power_surge.wait_time = time_for_surge
	

func _on_surge_duration_timeout() -> void:# surge has ended
	print("surge has ended")
	_update_surge_time()
	$power_surge.start()
	print(	$power_surge.wait_time, " is the new surge wait time")
