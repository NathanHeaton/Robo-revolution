extends Control

var upgrade_card_scene = preload("res://upgrade_card.tscn")

signal start_game


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Scrapyard_upgrade_panel.hide()
	generate_scrapyard_upgrades()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_message(text):
	pass
	#$Message.text = text
	#$Message.show()
	#$Message_Timer.start()

	
func update_money():
	$MarginContainer/VBoxContainer/Money_Label.text = "Money: " + str(Money.MONEY)



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
	print(Scrapyard_Upgrades)
	for upgrade in Scrapyard_Upgrades:
		print(upgrade)
		var card = upgrade_card_scene.instantiate()
		$Scrapyard_upgrade_panel/Scrapyard_content/ScrollContainer/Upgrades.add_child(card)
		card.change_title(Scrapyard_Upgrades[upgrade].get("name"))
		card.change_Description(Scrapyard_Upgrades[upgrade].get("description"))
		card.change_sprite(Scrapyard_Upgrades[upgrade].get("sprite_position"))
		card.change_cost(Scrapyard_Upgrades[upgrade].get("base_cost"))
		card.cal_max_buy(Scrapyard_Upgrades[upgrade].get("level"),Scrapyard_Upgrades[upgrade].get("base_cost"),Scrapyard_Upgrades[upgrade].get("cost_scaling"))
		
