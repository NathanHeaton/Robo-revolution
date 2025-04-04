extends Control

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Scrapyard_upgrade_panel.hide()
	

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
	print(toggled_on)
	if(toggled_on):
		$Scrapyard_upgrade_panel.show()
	else:
		$Scrapyard_upgrade_panel.hide()
