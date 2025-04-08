extends Node

signal money_changed

var money_back_up: float = 0
var MONEY: float = 0: # allows signals to be sent when money is updated
	get:
		return money_back_up
	set(value):
		money_back_up = value
		emit_signal("money_changed")


var POWER_CRYSTALS = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func covert_Scientific_format(num: float):
	var num_string = str(snapped(num,1))# gets rid of decimals if there are any
	var digits = num_string.length()
	
	if(digits < 4):
		return str(num)

	num_string = num_string.insert(1,".")
	num_string = num_string[0] + num_string[1] + num_string[2] + num_string[3] # dumb way of getting first 3 digits
	num_string = num_string + "e" + str(digits - 1)
	print(num_string)
	return num_string
	
