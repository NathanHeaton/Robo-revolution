extends Node

signal level_changed(id)
signal upgrade(upgrade)
signal unlock_location

func apply_upgrade(id, lvl, amount, cost, location, currency):
	detuct_cost(cost, currency)
	update_level(amount,id,location)

func update_level(amount,id,location):
	
	var upgrade = get_upgrade_id(id, location)
	upgrade["level"]  += amount
	upgrade["cost"] = upgrade["base_cost"]*pow(upgrade["cost_scaling"],upgrade["level"])
	emit_signal("level_changed",id)
	emit_signal("upgrade",get_upgrade_id(id, location))
	
	

func detuct_cost(cost, currency):
	if (currency == "money"):
		Money.MONEY -= cost
	elif (currency == "powerC"):
		Money.POWER_C -= cost



func get_upgrade_id(id, location):
	var locations_upgrades = UpgradeData.upgrades[location]
	for upgrade in locations_upgrades:
		if (locations_upgrades[upgrade].get("id") == id):
			return locations_upgrades[upgrade]
	
	

func buy_location(cost,location):
	detuct_cost(cost, "money")
	LocationData.location_data[location]["unlocked"] = true
	var location_stat_text : String = (LocationData.location_data[location].name).to_lower()+ "_unlocked"
	GameStats.set_stat("location",location_stat_text, true)
	emit_signal("unlock_location")
