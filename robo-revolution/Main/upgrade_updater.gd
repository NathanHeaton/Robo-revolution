extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UpgradeManager.connect("upgrade", Callable(self, "_upgrade"))
	connect("rarity_upgraded",Callable($Player, "_set_rarity_sprite"))


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
		"Combo":
			_combo_upgrade(upgrade["level"])
		"Combo Increase":
			_combo_increase_upgrade(upgrade["level"])

func _combo_upgrade(level: int):
	if(!GameStats.stats["combo"]["bought"]):
		GameStats.stats["combo"]["bought"] = true
		GameStats.set_stat("combo","bought",null)
	else:
		print("bought combo")
		GameStats.set_stat("combo","duration",snapped(clamp(4 + log(level + 1) * -1.15, 0.1, 5), 0.01))
	
func _spawnrate_upgrade(level: int):
	GameStats.set_stat("luck","spawn_time",snapped(clamp(4 + log(level + 1) * -1.15, 0.1, 5), 0.01))
	get_parent().get_node("loot_spawn_timer").wait_time = GameStats.stats["luck"]["spawn_time"]

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


func _combo_increase_upgrade(level: int):
	# add logic
	GameStats.set_stat("combo", "multiplier", 1.0 + (level * 0.05)) 

func _item_focuser_upgrade(level: int):
	var x = 30 + log(level + 1) * 150
	GameStats.set_stat("luck", "item_spawn_region", Rect2(Vector2(x, x), Vector2(1920 - x, 1080 - x)))
