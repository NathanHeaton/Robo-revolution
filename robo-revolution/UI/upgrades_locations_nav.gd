extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameStats.connect("stats_changed", Callable(self, "_manage_stat_change"))
	_check_unlocked_locations()
	$Underground_Upgrades.hide()
	$Ocean_Upgrades.hide()
	$Alien_Upgrades.hide()
	$Companion_Upgrades.hide()
	$PowerC_Upgrades.hide()
	$Prestige.hide()


func _manage_stat_change(type,stat):
	match stat:
		"unlocked_prestiege":
			$PowerC_Upgrades.show()
			$Prestige.show()
		"unlocked_companion_upgrades":
			$Companion_Upgrades.show()
		"underground_unlocked":
			$Underground_Upgrades.show()
		"ocean_unlocked":
			$Ocean_Upgrades.show()
		"alien_unlocked": 
			$Alien_Upgrades.show()
func _check_unlocked_locations():
	pass
