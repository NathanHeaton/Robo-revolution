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
	ItemData.connect("collected_item",Callable(self,"_on_item_collector_collect"))
	$HUD.connect("prestiged", Callable(self, "_prestige"))
	if (GameStats.stats["companion"]["amount"] > 0):
		_spawn_companions()
	_pick_track()
	

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
	if (GameStats.combo == true):
		value = value *  GameStats.stats["combo"]["combo_mult"]
		print("combo is active")
	return value


func _on_item_collector_collect(body,item):
	var gain = 1
	if (body.get_currency() == "money"):
		gain = _apply_mult_to_collected_item(body.get_value())
		Money.MONEY += gain
	elif (body.get_currency() == "powerC"):
		gain = body.get_value()
		Money.POWER_C += gain
	#$HUD.update_money()
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
	

func respawn():
	Money.MONEY = Money.MONEY * 0.1
	#$Player.start($Start_Position.position)

func _on_hud_start_game() -> void:
	newGame()

var time_for_surge = 20
func _on_power_surge_timeout() -> void:
	$surge_duration.start()
	$power_surge/surge_sfx.play()
	GameStats.set_stat("physical", "health", GameStats.stats["physical"]["health"] - 10)

func _update_surge_time():
	time_for_surge = randf_range(time_for_surge-3,time_for_surge+3)
	$power_surge.wait_time = time_for_surge
	

func _on_surge_duration_timeout() -> void:# surge has ended
	_update_surge_time()
	$power_surge.start()


func _pick_track() -> void:
	var track = randi_range(1,2)
	get_node("track_" + str(track)).play()
	


func _on_track_2_finished() -> void:
	_pick_track()


func _on_track_1_finished() -> void:
	_pick_track()
