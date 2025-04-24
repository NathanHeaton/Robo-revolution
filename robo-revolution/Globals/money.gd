extends Node

signal money_changed
signal powerC_changed

var powerC_back_up: float = 0
var POWER_C : float = 0: # allows signals to be sent when money is updated
	get:
		return powerC_back_up
	set(value):
		powerC_back_up = value
		emit_signal("powerC_changed")

var money_back_up: float = 0
var MONEY: float = 0: # allows signals to be sent when money is updated
	get:
		return money_back_up
	set(value):
		money_back_up = value
		emit_signal("money_changed")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func covert_Scientific_format(num: float):
	var num_string = str(snapped(num,1))# gets rid of decimals if there are any
	var digits = num_string.length()
	var sci_format = ""
	
	if(digits < 4):
		return str(num_string)
		
	sci_format = num_string[0]
	if (num_string[1] != "0" || num_string[2] != "0"):# if both digits are 0 this is skipped
		sci_format += num_string[1] 
		if(num_string[2] != "0"):
			sci_format +=  num_string[2]
	
	if (sci_format.length() > 1):
		sci_format = sci_format.insert(1,".")
	
	sci_format = sci_format + "e" + str(digits - 1)
	return sci_format
	
