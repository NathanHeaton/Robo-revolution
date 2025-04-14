extends Control

var upgrade_card_scene = preload("res://UI/upgrade_card.tscn")
var location_card_scene = preload("res://UI/location_card.tscn")

signal start_game


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var card = location_card_scene.instantiate()
	$Scrapyard_upgrade_panel.hide()
	$Locations_panel.hide()
	$Underground_upgrade_panel.hide()
	$Ocean_upgrade_panel.hide()
	$Alien_upgrade_panel.hide()
	generate_upgrade_cards()
	generate_location_cards()
	LocationData.connect("change_location", Callable(self, "_on_change_location"))
	Money.connect("money_changed", Callable(self, "_on_money_changed"))
	GameStats.connect("health_changed", Callable(self, "_update_health"))
	_update_health()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_message(text):
	pass
	#$Message.text = text
	#$Message.show()
	#$Message_Timer.start()
	

func _on_money_changed():
	update_money()

func _update_health():
	$MarginContainer/right_hud/health.anchor_left = 0
	$MarginContainer/right_hud/health_text.text = "health (" + str(GameStats.health) + "/" + str(GameStats.max_health) + ")"
	if (GameStats.health == 0):
		$MarginContainer/right_hud/health.anchor_right = 0
	else:
		$MarginContainer/right_hud/health.anchor_right = (GameStats.health / GameStats.max_health)
		print((GameStats.health / GameStats.max_health))


func update_money():
	$MarginContainer/VBoxContainer/Money_Label.text = "Money: " + Money.covert_Scientific_format(Money.MONEY)

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
			location[upgrade].get("first_description")
			,currentLocationCard)
	
	


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
	
	


func _on_location_button_toggled(toggled_on: bool) -> void:
	var currentCard = "MarginContainer/upgrades_Locations_nav/Location_Button"
	_handle_popup_screens(currentCard)
	if(toggled_on):
		$Locations_panel.show()
		previousCard = currentCard
	else:
		$Locations_panel.hide()


func _on_locations_close_button_pressed() -> void:
	$MarginContainer/upgrades_Locations_nav/Location_Button.button_pressed = false
	$MarginContainer/upgrades_Locations_nav/Location_Button.emit_signal("toggled", false)


func _on_scrapyard_upgrades_toggled(toggled_on: bool) -> void:
	var currentCard = "MarginContainer/upgrades_Locations_nav/Scrapyard_Upgrades"
	_handle_popup_screens(currentCard)
	if(toggled_on):
		$Scrapyard_upgrade_panel.show()
		previousCard = currentCard
	else:
		$Scrapyard_upgrade_panel.hide()

func _on_underground_upgrades_toggled(toggled_on: bool) -> void:
	var currentCard = "MarginContainer/upgrades_Locations_nav/Underground_Upgrades"
	_handle_popup_screens(currentCard)
	if(toggled_on):
		$Underground_upgrade_panel.show()
		previousCard = currentCard
	else:
		$Underground_upgrade_panel.hide()
	

func _on_ocean_upgrades_toggled(toggled_on: bool) -> void:
	var currentCard = "MarginContainer/upgrades_Locations_nav/Ocean_Upgrades"
	_handle_popup_screens(currentCard)
	if(toggled_on):
		$Ocean_upgrade_panel.show()
		previousCard = currentCard
	else:
		$Ocean_upgrade_panel.hide()

func _on_ocean_close_button_pressed() -> void:
	$MarginContainer/upgrades_Locations_nav/Ocean_Upgrades.button_pressed = false
	$MarginContainer/upgrades_Locations_nav/Ocean_Upgrades.emit_signal("toggled", false)
	



func _on_alien_upgrades_toggled(toggled_on: bool) -> void:
	var currentCard = "MarginContainer/upgrades_Locations_nav/Alien_Upgrades"
	_handle_popup_screens(currentCard)
	if(toggled_on):
		$Alien_upgrade_panel.show()
		previousCard = currentCard
	else:
		$Alien_upgrade_panel.hide()

func _on_alien_close_button_pressed() -> void:
	$MarginContainer/upgrades_Locations_nav/Alien_Upgrades.button_pressed = false
	$MarginContainer/upgrades_Locations_nav/Alien_Upgrades.emit_signal("toggled", false)



func _on_scrapyard_close_button_pressed() -> void:
	# close the scrapyard upgarde panel
	$MarginContainer/upgrades_Locations_nav/Scrapyard_Upgrades.button_pressed = false
	$MarginContainer/upgrades_Locations_nav/Scrapyard_Upgrades.emit_signal("toggled", false)
	

func _on_underground_close_button_pressed() -> void:
	# close the Undergound upgarde panel
	$MarginContainer/upgrades_Locations_nav/Underground_Upgrades.button_pressed = false
	$MarginContainer/upgrades_Locations_nav/Underground_Upgrades.emit_signal("toggled", false)




var previousCard = null

func _handle_popup_screens(currentCard):
	
	if (previousCard && currentCard != previousCard):
		get_node(previousCard).button_pressed = false
		get_node(previousCard).emit_signal("toggled", false)
	
