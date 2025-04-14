extends Node

# player stats
var strength = 15
var surge_protection = 0
var speed = 400
var health = 100

#spawn stats
var rarity_lvl = 0
var item_spawn_region
var luck_lvl = [0,0,0,0]

#other
var companions = 0
var water_proof = false

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
