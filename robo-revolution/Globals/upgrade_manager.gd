extends Node

signal level_changed(id)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func apply_upgrade(id, lvl, amount, cost):
	detuct_money(cost)
	update_level(amount,id)

func update_level(amount,id):
	var locations_upgrades = UpgradeData.upgrades["Scrapyard"].duplicate()
	var upgarde_lvl =2 # add code to update level
	
	get_upgrade_id(id, locations_upgrades)["level"] += amount
	emit_signal("level_changed",id)
	

func detuct_money(cost):
	Money.MONEY -= cost


func get_upgrade_id(id, locations_upgrades):
	for upgrade in locations_upgrades:
		if (locations_upgrades[upgrade].get("id") == id):
			return locations_upgrades[upgrade]
	
