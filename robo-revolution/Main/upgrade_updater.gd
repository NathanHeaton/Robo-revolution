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
		"Super Combo":
			_super_combo_upgrade(upgrade["level"])
		"Super Combo Aligner":
			_super_combo_aligner_upgrade(upgrade["level"])
		"Surge Chances":
			_surge_chances_upgrade(upgrade["level"])
		"Companion":
			_companion_upgrade(upgrade["level"])
		"Refinement":
			_refinement_upgrade(upgrade["level"])
		"Rarity+":
			_rarity_upgrade_plus(upgrade["level"])
				# Ocean Upgrades
		"Rarity++":
			_rarity_upgrade_2plus(upgrade["level"])
		"Companion Upgrades":
			apply_companion_upgrades()
		"Prestige":
			apply_prestige()
		"Sea Drill":
			apply_sea_drill()
		"Drill Burst":
			apply_drill_burst()
		# Alien Upgrades
		"Rarity+++":
			_rarity_upgrade_3plus(upgrade["level"])
		"Auto Combo":
			apply_auto_combo()
		"Alien Interface":
			apply_alien_interface()
		"Alien Refinement":
			apply_alien_refinement()
		"Alien Signal":
			apply_alien_signal()
		"Alien Controller":
			apply_alien_controller()
		"Synergy":
			apply_synergy()

# Scrapyard
#============================================================================================================================

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

func _rarity_upgrade(level: int):
	if 	GameStats.stats["luck"]["scrapyard"] < 1:
		GameStats.stats["luck"]["rarity_lvl"] + 1
		GameStats.set_stat("luck", "rarity_lvl",null )
		emit_signal("rarity_upgraded","rarity")
	GameStats.set_stat("luck","scrapyard", level)

func _combo_increase_upgrade(level: int):
	# add logic
	GameStats.set_stat("combo", "multiplier", 1.0 + (level * 0.05)) 

func _item_focuser_upgrade(level: int):
	var x = 30 + log(level + 1) * 150
	GameStats.set_stat("luck", "item_spawn_region", Rect2(Vector2(x, x), Vector2(1920 - x, 1080 - x)))
	

# underground upgrades
#============================================================================================================================
func _rarity_upgrade_plus(level: int):
	if GameStats.stats["luck"]["underground"] < 1:
		GameStats.stats["luck"]["rarity_lvl"] + 1
		GameStats.set_stat("luck", "rarity_lvl", null)
		emit_signal("rarity_upgraded","rarity+")
	GameStats.set_stat("luck","underground", level)

func _super_combo_upgrade(level: int):
	print("Applying Super Combo upgrade")

func _super_combo_aligner_upgrade(level: int):
	print("Applying Super Combo Aligner upgrade")

func _surge_chances_upgrade(level: int):
	print("Applying Surge Chances upgrade")

func _companion_upgrade(level: int):
	print("Applying Companion upgrade")

func _refinement_upgrade(level: int):
	print("Applying Refinement upgrade")
	

# ocean
#============================================================================================================================
func _rarity_upgrade_2plus(level: int):
	if (GameStats.stats["luck"]["ocean"] < 1):
		GameStats.stats["luck"]["rarity_lvl"] + 1
		GameStats.set_stat("luck", "rarity_lvl",null )
		emit_signal("rarity_upgraded","rarity++")
	GameStats.set_stat("luck","ocean", level)

func apply_companion_upgrades():
	pass

func apply_prestige():
	pass

func apply_sea_drill():
	pass

func apply_drill_burst():
	pass

# Alien
#============================================================================================================================
func _rarity_upgrade_3plus(level: int):
	if (GameStats.stats["luck"]["alien"] < 1):
		GameStats.stats["luck"]["rarity_lvl"] + 1
		GameStats.set_stat("luck", "rarity_lvl",null )
		emit_signal("rarity_upgraded","rarity+++")
	GameStats.set_stat("luck","alien", level)

func apply_auto_combo():
	pass

func apply_alien_interface():
	pass

func apply_alien_refinement():
	pass

func apply_alien_signal():
	pass

func apply_alien_controller():
	pass

func apply_synergy():
	pass

# Power Crystal
# ====================================================================================================

func _3X_Sell_Value_upgrade(level: int):
	GameStats.set_stat("mult", "powerC_mult", level * 3)

func _give_alien_key():
	GameStats.set_stat("other","alien_key", true)
