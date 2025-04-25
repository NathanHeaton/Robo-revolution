extends Node

# player stats
var strength = 15
var surge_protection = 0
var speed = 400

signal health_changed
var _health:float = 100
var health:float = _health:
	get:
		return _health
	set(value):
		_health = clamp(value,0,max_health)
		emit_signal("health_changed")
var max_health:float = 100
var armour_mult = 1

#mult

var powerC_mult = 1
#combos
var combo = false
var super_combo = false
var combo_mult = 2
var super_combo_mult = 10
var super_combo_chance = 12 # 12% maybe
var powerC_combo_mult

var refinment = 1 # 1%
var refinement_cap = 1000 # 1000%
var surge_mult = 5
var alien_refinement = 10 # 10%
var alien_refinement_cap = 100000 # 1e6%
var synergy_mult = 777 # 777X

#spawn stats
var rarity_lvl = 5
var item_spawn_region
var luck_lvl = [0,0,0,0]

#other
var companions = 0
var water_proof = false
var basic_water_proof = 0
var powerC_conversion_rate = 10000

func sum_luck_lvl()-> int:
	var luck = 0
	for nums in luck_lvl:
		luck += nums
	return luck

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
