extends Node

signal collected_item(body,item_name)

func item_collected(body,item):
	emit_signal("collected_item",body,item)

var items: Dictionary = {
	"scrap":{
		"name": "scrap",
		"value": 3,
		"rarity": 0,
		"type": "scrap",
		"weight": 3,
		"locations":[LocationData.locations.Scrapyard,LocationData.locations.Underground,LocationData.locations.Ocean,LocationData.locations.Alien], 
		"variants": 4,
		"mainLocation": LocationData.locations.Scrapyard
	},
	"plastic":{
		"name": "plastic",
		"value": 4,
		"rarity": 0,
		"type": "scrap",
		"weight": 2,
		"locations":[LocationData.locations.Scrapyard,LocationData.locations.Underground,LocationData.locations.Ocean], 
		"variants": 3,
		"mainLocation": LocationData.locations.Scrapyard
	},
	"rusty_nails":{
		"name": "rusty_nails",
		"value": 2,
		"rarity": 0,
		"type": "scrap",
		"weight": 1,
		"locations":[LocationData.locations.Scrapyard,LocationData.locations.Underground,LocationData.locations.Ocean], 
		"variants": 3,
		"mainLocation": LocationData.locations.Scrapyard
	},
	"gears":{
		"name": "gears",
		"value": 3,
		"rarity": 0,
		"type": "scrap",
		"weight": 1,
		"locations":[LocationData.locations.Scrapyard], 
		"variants": 4,
		"mainLocation": LocationData.locations.Scrapyard
	},
	"computer_chips": {
		"name": "computer_chips",
		"value": 6,
		"rarity": 1,
		"type": "scrap",
		"weight": 1,
		"locations": [LocationData.locations.Scrapyard, LocationData.locations.Underground],
		"variants": 3,
		"mainLocation": LocationData.locations.Scrapyard
	},
	"vehicle_components": {
		"name": "vehicle_components",
		"value": 10,
		"rarity": 1,
		"type": "scrap",
		"weight": 4,
		"locations": [LocationData.locations.Scrapyard, LocationData.locations.Underground],
		"variants": 2,
		"mainLocation": LocationData.locations.Scrapyard
	},
	"wires": {
		"name": "wires",
		"value": 4,
		"rarity": 1,
		"type": "scrap",
		"weight": 1,
		"locations": [LocationData.locations.Scrapyard, LocationData.locations.Underground],
		"variants": 3,
		"mainLocation": LocationData.locations.Scrapyard
	},
	"robot_parts": {
		"name": "robot_parts",
		"value": 50,
		"rarity": 2,
		"type": "scrap",
		"weight": 7,
		"locations": [LocationData.locations.Underground],
		"variants": 4,
		"mainLocation": LocationData.locations.Underground
	},
	"motherboard": {
		"name": "motherboard",
		"value": 35,
		"rarity": 2,
		"type": "scrap",
		"weight": 2,
		"locations": [LocationData.locations.Underground],
		"variants": 3,
		"mainLocation": LocationData.locations.Underground
	},
	"metal": {
		"name": "metal",
		"value": 40,
		"rarity": 2,
		"type": "scrap",
		"weight": 3,
		"locations": [LocationData.locations.Underground, LocationData.locations.Ocean],
		"variants": 4,
		"mainLocation": LocationData.locations.Underground
	},
	"seashells": {
		"name": "seashells",
		"value": 700,
		"rarity": 3,
		"type": "scrap",
		"weight": 3,
		"locations": [LocationData.locations.Ocean],
		"variants": 3,
		"mainLocation": LocationData.locations.Ocean
	},
	"ship_wreckage": {
		"name": "ship_wreckage",
		"value": 1500,
		"rarity": 3,
		"type": "scrap",
		"weight": 10,
		"locations": [LocationData.locations.Ocean],
		"variants": 4,
		"mainLocation": LocationData.locations.Ocean
	},
	"broken_jewels": {
		"name": "broken_jewels",
		"value": 2000,
		"rarity": 3,
		"type": "scrap",
		"weight": 4,
		"locations": [LocationData.locations.Ocean],
		"variants": 4,
		"mainLocation": LocationData.locations.Ocean
	},
	"alien_parts": {
		"name": "alien_parts",
		"value": 4000,
		"rarity": 4,
		"type": "scrap",
		"weight": 15,
		"locations": [LocationData.locations.Alien],
		"variants": 3,
		"mainLocation": LocationData.locations.Alien
	},
	"alien_scrap_metal": {
		"name": "alien_scrap_metal",
		"value": 3000,
		"rarity": 4,
		"type": "scrap",
		"weight": 12,
		"locations": [LocationData.locations.Alien],
		"variants": 4,
		"mainLocation": LocationData.locations.Alien
	},
	"gold_plates": {
		"name": "gold_plates",
		"value": 60,
		"rarity": 0,
		"type": "treasure",
		"weight": 2,
		"locations": [LocationData.locations.Scrapyard, LocationData.locations.Underground],
		"variants": 2,
		"mainLocation": LocationData.locations.Scrapyard
	},
	"rubies": {
		"name": "rubies",
		"value": 80,
		"rarity": 1,
		"type": "treasure",
		"weight": 1,
		"locations": [LocationData.locations.Scrapyard, LocationData.locations.Underground, LocationData.locations.Ocean],
		"variants": 1,
		"mainLocation": LocationData.locations.Scrapyard
	},
	"gold_bars": {
		"name": "gold_bars",
		"value": 600,
		"rarity": 2,
		"type": "treasure",
		"weight": 7,
		"locations": [LocationData.locations.Underground],
		"variants": 1,
		"mainLocation": LocationData.locations.Underground
	},
	"pearls": {
		"name": "pearls",
		"value": 9000,
		"rarity": 3,
		"type": "treasure",
		"weight": 1,
		"locations": [LocationData.locations.Ocean],
		"variants": 1,
		"mainLocation": LocationData.locations.Ocean
	},
	"alien_artifacts": {
		"name": "alien_artifacts",
		"value": 50000,
		"rarity": 4,
		"type": "treasure",
		"weight": 18,
		"locations": [LocationData.locations.Alien],
		"variants": 1,
		"mainLocation": LocationData.locations.Alien
	},
	"power_crystals": {
		"name": "power_crystals",
		"value": 1,
		"rarity": 4,
		"type": "treasure",
		"weight": 3,
		"locations": [LocationData.locations.Alien],
		"variants": 1,
		"mainLocation": LocationData.locations.Alien
	}
}
