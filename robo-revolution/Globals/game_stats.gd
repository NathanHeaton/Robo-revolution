extends Node


signal stats_changed(type, stat)

# player sprites/skins
enum player_states {
	rusted,
	normal,
	waterproof,
	armoured
}

var player_skins = {
	player_states.rusted:{
		"name": "rusted",
		"unlocked": true,
		},
	player_states.normal:{
		"name": "normal",
		"unlocked": false,
		},
	player_states.waterproof: {
		"name": "waterproof",
		"unlocked": false,
		},
	player_states.armoured: {
		"name": "armoured",
		"unlocked": false,
		}
}

var current_state = player_states.rusted

#combos
var combo = false
var super_combo = false

var stats = {
	"physical":{
		"strength" : 15,
		"surge_protection" : 0,
		"speed" : 400,
		"health": 100,
		"max_health": 100,
		"armour_mult" : 1,
		"water_proof" : false,
		"basic_water_proof" : 0
	},
	"luck":{
		"rarity_lvl" : 5,
		"spawn_time": 4,
		"item_spawn_region" : Rect2(),
		"scrapyard" : 0,
		"underground": 0,
		"ocean": 0,
		"alien": 0
	},
	"mult":{
		"powerC_mult" : 1,
		"refinment" : 1, # 1%
		"refinement_cap" : 1000, # 1000%
		"surge_mult" : 5,
		"alien_refinement" : 10, # 10%
		"alien_refinement_cap" : 100000, # 1e6%
		"synergy_mult" : 777 # 777X
	},
	"combo":{
		"combo_duration": 30,
		"combo_mult" : 2,
		"super_combo_mult" : 10,
		"super_combo_chance" : 12,
		"powerC_combo_mult": 2,
		"combos_completed": 0,
		"bought": false,
	},
	"companion":{
		"amount": 0,
		"strength": 4,
		"speed": 50,
		"capacity": 1
	},
	"other":{
		"powerC_conversion_rate" : 10000,
		"alien_key" : false,
		"unlocked_prestiege": false,
		"unlocked_companion_upgrades": false
	},
	"location":{
		"scarpyard_unlocked": true,
		"underground_unlocked": false,
		"ocean_unlocked": false,
		"alien_unlocked": false,
	}
}

func set_stat(type : String,stat : String,value):
	if (value == null):
		emit_signal("stats_changed", type,stat)
		return
	stats[type][stat] = value
	emit_signal("stats_changed", type,stat)

func activate_combo():
	combo = true

func sum_luck_lvl()-> int: # fix later
	var luck = 0
	#for nums in stats["luck"]["luck_lvl"]:
		#luck += nums
	return luck
