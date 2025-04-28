extends Control

var upgrade_card_scene = preload("res://UI/upgrade_card.tscn")
var location_card_scene = preload("res://UI/location_card.tscn")

signal start_game
signal prestiged


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var card = location_card_scene.instantiate()
	_hide_panels()
	generate_upgrade_cards()
	generate_location_cards()
	LocationData.connect("change_location", Callable(self, "_on_change_location"))
	Money.connect("money_changed", Callable(self, "_on_money_changed"))
	Money.connect("powerC_changed", Callable(self, "_on_powerC_changed"))
	GameStats.connect("stats_changed", Callable(self, "_manage_stat_change"))
	_update_health()
	

func _hide_panels():
	$Scrapyard_upgrade_panel.hide()
	$Locations_panel.hide()
	$Underground_upgrade_panel.hide()
	$Ocean_upgrade_panel.hide()
	$Alien_upgrade_panel.hide()
	$Power_Crystal_upgrade_panel.hide()
	$Companion_upgrade_panel.hide()
	$Prestige_panel.hide()
	$profile_panel.hide()
	$stats_panel.hide()
	$settings_panel.hide()
	$achievements_panel.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_message(text):
	pass
	#$Message.text = text
	#$Message.show()
	#$Message_Timer.start()
	

func _on_money_changed():
	$MarginContainer/money_panel/VBoxContainer/money_box/money.text = Money.covert_Scientific_format(Money.MONEY)
	_prestige_handeler()
	

func _manage_stat_change(type,stat):
	match stat:
		"health":
			_update_health()

func _prestige_handeler():
	$Prestige_panel/Scrapyard_content/Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/VBoxContainer/MarginContainer/conversion/PanelContainer/money_box/money.text = Money.covert_Scientific_format(Money.MONEY)
	$Prestige_panel/Scrapyard_content/Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/VBoxContainer/MarginContainer/conversion/PanelContainer3/powerC_box/powerC.text = Money.covert_Scientific_format(Money.MONEY / GameStats.stats["other"]["powerC_conversion_rate"])

func _update_health():
	$MarginContainer/right_hud/health.anchor_left = 0
	$MarginContainer/right_hud/health_text.text = "health (" + str(GameStats.stats["physical"]["health"]) + "/" + str(GameStats.stats["physical"]["max_health"]) + ")"
	if (GameStats.stats["physical"]["health"] == 0):
		$MarginContainer/right_hud/health.anchor_right = 0
	else:
		$MarginContainer/right_hud/health.anchor_right = (GameStats.stats["physical"]["health"]/ GameStats.stats["physical"]["max_health"])

func _on_powerC_changed():
	$MarginContainer/money_panel/VBoxContainer/powerC_box/powerC.text = Money.covert_Scientific_format(Money.POWER_C)

func _on_change_location():
	$MarginContainer/right_hud/location.text = "Location: " + str(LocationData.location_data[LocationData.CURRENT_LOCATION].get("name"))

func _on_message_timer_timeout():
	$Message.hide()


func generate_upgrade_cards() -> void:
	for currentLocationCard in UpgradeData.upgrades.keys():
		var location: Dictionary = UpgradeData.upgrades[currentLocationCard].duplicate() # might need to change if alter dict values
		for upgrade in location:
			var card = upgrade_card_scene.instantiate()
			var path = "" + str(currentLocationCard) + "_upgrade_panel/Scrapyard_content/ScrollContainer/Upgrades"
			get_node(path).add_child(card)
			card.get_inital_data(location[upgrade].get("description"),
			location[upgrade].get("base_cost"),
			location[upgrade].get("cost_scaling"),
			location[upgrade].get("level"),
			location[upgrade].get("max_level"),
			location[upgrade].get("sprite_position"),
			location[upgrade].get("name"),
			location[upgrade].get("id"),
			location[upgrade].get("first_description"),
			currentLocationCard,
			location[upgrade]["currency"]
			)
	
func generate_location_cards() -> void:
	
	var locations:Dictionary = LocationData.location_data
	for location in LocationData.location_data:
		var card = location_card_scene.instantiate()
		$Locations_panel/Locations_content/ScrollContainer/locations.add_child(card)
		#get_inital_data(t_description,t_pos,t_title, t_cost, t_pri, t_sec, t_unlocked, t_first_description)
		card.get_inital_data(
			locations[location].get("description"),
			locations[location].get("sprite_position"),
			locations[location].get("name"),
			locations[location].get("base_cost"),
			locations[location].get("unlocked"),
			locations[location].get("key_needed"),
		)
	

func generate_stats_cards() -> void:
	for types in GameStats.stats.keys():
		var type: Dictionary = GameStats.stats[types].duplicate # might need to change if alter dict values
		#card.get_inital_data(location[upgrade].get("description"),
		#location[upgrade].get("base_cost"),
		#location[upgrade].get("cost_scaling"),
		#location[upgrade].get("level"),
		#location[upgrade].get("max_level"),
		#location[upgrade].get("sprite_position"),
		#location[upgrade].get("name"),
		#location[upgrade].get("id"),
		#location[upgrade].get("first_description"),
		#currentLocationCard,
		#location[upgrade]["currency"]
		#)
	


func _on_locations_close_button_pressed() -> void:
	$MarginContainer/upgrade_nav_container/upgrades_Locations_nav/Location_Button.button_pressed = false
	$MarginContainer/upgrade_nav_container/upgrades_Locations_nav/Location_Button.emit_signal("toggled", false)


func _on_ocean_close_button_pressed() -> void:
	$MarginContainer/upgrade_nav_container/upgrades_Locations_nav/Ocean_Upgrades.button_pressed = false
	$MarginContainer/upgrade_nav_container/upgrades_Locations_nav/Ocean_Upgrades.emit_signal("toggled", false)
	

func _on_alien_close_button_pressed() -> void:
	$MarginContainer/upgrade_nav_container/upgrades_Locations_nav/Alien_Upgrades.button_pressed = false
	$MarginContainer/upgrade_nav_container/upgrades_Locations_nav/Alien_Upgrades.emit_signal("toggled", false)


func _on_scrapyard_close_button_pressed() -> void:
	# close the scrapyard upgarde panel
	$MarginContainer/upgrade_nav_container/upgrades_Locations_nav/Scrapyard_Upgrades.button_pressed = false
	$MarginContainer/upgrade_nav_container/upgrades_Locations_nav/Scrapyard_Upgrades.emit_signal("toggled", false)
	

func _on_underground_close_button_pressed() -> void:
	# close the Undergound upgarde panel
	$MarginContainer/upgrade_nav_container/upgrades_Locations_nav/Underground_Upgrades.button_pressed = false
	$MarginContainer/upgrade_nav_container/upgrades_Locations_nav/Underground_Upgrades.emit_signal("toggled", false)


var previousCard = null

func _handle_popup_screens(currentCard, open_panel, t_toggled):
	
	if (previousCard && currentCard != previousCard):
		get_node(previousCard).button_pressed = false
		get_node(previousCard).emit_signal("toggled", false)
	
	match open_panel:
		"achievements_panel":
			$achievements_panel.visible = t_toggled
		"Scrapyard_upgrade_panel":
			$Scrapyard_upgrade_panel.visible = t_toggled
		"Locations_panel":
			$Locations_panel.visible = t_toggled
		"Underground_upgrade_panel":
			$Underground_upgrade_panel.visible = t_toggled
		"Ocean_upgrade_panel":
			$Ocean_upgrade_panel.visible = t_toggled
		"Alien_upgrade_panel":
			$Alien_upgrade_panel.visible = t_toggled
		"Companion_upgrade_panel":
			$Companion_upgrade_panel.visible = t_toggled
		"Power_Crystal_upgrade_panel":
			$Power_Crystal_upgrade_panel.visible = t_toggled
		"Prestige_panel":
			$Prestige_panel.visible = t_toggled
		"stats_panel":
			$stats_panel.visible = t_toggled
		"profile_panel":
			$profile_panel.visible = t_toggled
		"settings_panel":
			$settings_panel.visible = t_toggled
		"none":
			0
	
	previousCard = currentCard

func _on_scrapyard_upgrades_toggled(toggled_on: bool) -> void:
	var currentCard = "MarginContainer/upgrade_nav_container/upgrades_Locations_nav/Scrapyard_Upgrades"
	var open_panel = "Scrapyard_upgrade_panel"
	_handle_popup_screens(currentCard, open_panel, toggled_on)

func _on_location_button_toggled(toggled_on: bool) -> void:
	var currentCard = "MarginContainer/upgrade_nav_container/upgrades_Locations_nav/Location_Button"
	var open_panel = "Locations_panel"
	_handle_popup_screens(currentCard, open_panel, toggled_on)

func _on_underground_upgrades_toggled(toggled_on: bool) -> void:
	var currentCard = "MarginContainer/upgrade_nav_container/upgrades_Locations_nav/Underground_Upgrades"
	var open_panel = "Underground_upgrade_panel"
	_handle_popup_screens(currentCard, open_panel, toggled_on)

func _on_ocean_upgrades_toggled(toggled_on: bool) -> void:
	var currentCard = "MarginContainer/upgrade_nav_container/upgrades_Locations_nav/Ocean_Upgrades"
	var open_panel = "Ocean_upgrade_panel"
	_handle_popup_screens(currentCard, open_panel, toggled_on)

func _on_alien_upgrades_toggled(toggled_on: bool) -> void:
	var currentCard = "MarginContainer/upgrade_nav_container/upgrades_Locations_nav/Alien_Upgrades"
	var open_panel = "Alien_upgrade_panel"
	_handle_popup_screens(currentCard, open_panel, toggled_on)

func _on_companion_upgrades_toggled(toggled_on: bool) -> void:
	var currentCard = "MarginContainer/upgrade_nav_container/upgrades_Locations_nav/Companion_Upgrades"
	var open_panel = "Companion_upgrade_panel"
	_handle_popup_screens(currentCard, open_panel, toggled_on)

func _on_power_c_upgrades_toggled(toggled_on: bool) -> void:
	var currentCard = "MarginContainer/upgrade_nav_container/upgrades_Locations_nav/PowerC_Upgrades"
	var open_panel = "Power_Crystal_upgrade_panel"
	_handle_popup_screens(currentCard, open_panel, toggled_on)

func _on_prestige_toggled(toggled_on: bool) -> void:
	var currentCard = "MarginContainer/upgrade_nav_container/upgrades_Locations_nav/Prestige"
	var open_panel = "Prestige_panel"
	_handle_popup_screens(currentCard, open_panel, toggled_on)

func _on_stats_toggled(toggled_on: bool) -> void:
	var currentCard = "MarginContainer/top_nav_container/top_nav/stats"
	var open_panel = "stats_panel"
	_handle_popup_screens(currentCard, open_panel, toggled_on)

func _on_achievements_toggled(toggled_on: bool) -> void:
	var currentCard = "MarginContainer/top_nav_container/top_nav/achievements"
	var open_panel = "achievements_panel"
	_handle_popup_screens(currentCard, open_panel, toggled_on)

func _on_profile_toggled(toggled_on: bool) -> void:
	var currentCard = "MarginContainer/top_nav_container/top_nav/profile"
	var open_panel = "profile_panel"
	_handle_popup_screens(currentCard, open_panel, toggled_on)

func _on_settings_toggled(toggled_on: bool) -> void:
	var currentCard = "MarginContainer/top_nav_container/top_nav/settings"
	var open_panel = "settings_panel"
	_handle_popup_screens(currentCard, open_panel, toggled_on)

func _on_prestige_pressed() -> void:
	emit_signal("prestiged")
