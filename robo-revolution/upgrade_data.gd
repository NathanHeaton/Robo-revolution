# UpgradeData.gd
extends Node


var upgrades: Dictionary = {
	"Scrapyard":{
		"Speed":{
			"name": "Speed",
			"level": 0,
			"max_level": 10,
			"base_cost": 100,
			"cost_scaling": 1.5,
			"type": "stat",
			"first_upgarde": false, #if there is a buy bonus for first upgrade
			"first_description":"",  #if there is a buy bonus for first upgrade
			"description": "Increases player speed",
			"sprite_description": Vector2(0,0),
		},
		"Strength": {
			"name": "Strength",
			"level": 0,
			"max_level": 10,
			"base_cost": 120,
			"cost_scaling": 1.5,
			"type": "stat",
			"first_upgrade": false,
			"first_description": "",
			"description": "Push items faster, and move heavier items",
			"sprite_position": Vector2(1, 0),
		},
		"SpawnRate": {
			"name": "Spawn Rate",
			"level": 0,
			"max_level": 20,
			"base_cost": 150,
			"cost_scaling": 1.6,
			"type": "stat",
			"first_upgrade": false,
			"first_description": "",
			"description": "Items spawn more frequently",
			"sprite_position": Vector2(2, 0),
		},
		"Rarity": {
			"name": "Rarity",
			"level": 0,
			"max_level": 8,
			"base_cost": 200,
			"cost_scaling": 2.0,
			"type": "stat",
			"first_upgrade": true,
			"first_description": "Allow items of higher rarity to spawn",
			"description": "Increases the chance to spawn treasure",
			"sprite_position": Vector2(3, 0),
		},
		"ItemFocuser": {
			"name": "Item Focuser",
			"level": 0,
			"max_level": 6,
			"base_cost": 450,
			"cost_scaling": 5.0,
			"type": "custom",
			"first_upgrade": false,
			"first_description": "",
			"description": "Items are more likely to spawn closer to the collection point",
			"sprite_position": Vector2(0, 1),
		},
		"Combo": {
			"name": "Combo",
			"level": 0,
			"max_level": 5,
			"base_cost": 1000,
			"cost_scaling": 1.8,
			"type": "custom",
			"first_upgrade": true,
			"first_description": "Robot can now combo giving multiplier on sales",
			"description": "increase chance for combo to start",
			"sprite_position": Vector2(1, 1),
		},
		"ComboIncrease": {
			"name": "Combo Increase",
			"level": 0,
			"max_level": 100,
			"base_cost": 1500,
			"cost_scaling": 1.7,
			"type": "stat",
			"first_upgrade": false,
			"first_description": "",
			"description": "Increases the value of your combos",
			"sprite_position": Vector2(2, 1),
		},
		"SurgeProtection": {
			"name": "Surge Protection",
			"level": 0,
			"max_level": 5,
			"base_cost": 4000,
			"cost_scaling": 1.6,
			"type": "custom",
			"first_upgrade": false,
			"first_description": "",
			"description": "Lessens the effect of power surge in underground",
			"sprite_position": Vector2(3, 1),
		},
	}
}
