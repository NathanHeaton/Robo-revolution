extends Control

var upgrade_card_scene = preload("res://upgrade_card.tscn")
var location_card_scene = preload("res://location_card.tscn")

signal start_game


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Scrapyard_upgrade_panel.hide()
	$Locations_panel.hide()
	generate_scrapyard_upgrades()
	generate_location_cards()
	LocationData.connect("change_location", Callable(self, "_on_change_location"))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_message(text):
	pass
	#$Message.text = text
	#$Message.show()
	#$Message_Timer.start()

	
func update_money():
	$MarginContainer/VBoxContainer/Money_Label.text = "Money: " + Money.covert_Scientific_format(Money.MONEY)

func _on_change_location():
	$MarginContainer/right_hud/location.text = "Location: " + str(LocationData.location_data[LocationData.CURRENT_LOCATION].get("name"))

func _on_message_timer_timeout():
	$Message.hide()



func _on_scrapyard_upgrades_toggled(toggled_on: bool) -> void:

	if(toggled_on):
		$Scrapyard_upgrade_panel.show()
	else:
		$Scrapyard_upgrade_panel.hide()


func _on_scrapyard_close_button_pressed() -> void:
	# close the scrapyard upgarde panel
	$MarginContainer/upgrades_Locations_nav/Scrapyard_Upgrades.button_pressed = false
	$MarginContainer/upgrades_Locations_nav/Scrapyard_Upgrades.emit_signal("toggled", false)
	

func generate_scrapyard_upgrades() -> void:
	var Scrapyard_Upgrades: Dictionary = UpgradeData.upgrades["Scrapyard"].duplicate() # might need to change if alter dict values
	for upgrade in Scrapyard_Upgrades:
		var card = upgrade_card_scene.instantiate()
		$Scrapyard_upgrade_panel/Scrapyard_content/ScrollContainer/Upgrades.add_child(card)
		card.get_inital_data(Scrapyard_Upgrades[upgrade].get("description"),Scrapyard_Upgrades[upgrade].get("base_cost"),Scrapyard_Upgrades[upgrade].get("cost_scaling"),Scrapyard_Upgrades[upgrade].get("level"),Scrapyard_Upgrades[upgrade].get("max_level"),Scrapyard_Upgrades[upgrade].get("sprite_position"),Scrapyard_Upgrades[upgrade].get("name"))
	
	
	

func generate_location_cards() -> void:
	var locations:Dictionary = LocationData.location_data
	for location in LocationData.location_data:
		var card = location_card_scene.instantiate()
		$Locations_panel/Locations_content/ScrollContainer/locations.add_child(card)
		#get_inital_data(t_description,t_pos,t_title, t_cost, t_pri, t_sec, t_unlocked)
		card.get_inital_data(locations[location].get("description"),locations[location].get("sprite_position"),locations[location].get("name"),locations[location].get("base_cost"),locations[location].get("priColour"),locations[location].get("secColour"),locations[location].get("unlocked"),locations[location].get("key_needed"))
	
	


func _on_location_button_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		$Locations_panel.show()
	else:
		$Locations_panel.hide()


func _on_locations_close_button_pressed() -> void:
	$MarginContainer/upgrades_Locations_nav/Location_Button.button_pressed = false
	$MarginContainer/upgrades_Locations_nav/Location_Button.emit_signal("toggled", false)
