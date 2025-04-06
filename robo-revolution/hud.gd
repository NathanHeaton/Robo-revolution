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

	
func update_money(money):
	$MarginContainer/VBoxContainer/Money_Label.text = "Money: " + str(money)



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
	for upgrade in UpgradeData.upgrades.get("Scrapyard"):
		print(upgrade)
		var card = upgrade_card_scene.instantiate()
		$Scrapyard_upgrade_panel/Scrapyard_container/Scrapyard_content/ScrollContainer/Upgrades.add_child(card)
		
	print($Scrapyard_upgrade_panel/Scrapyard_container/Scrapyard_content/ScrollContainer/Upgrades.get_children())
