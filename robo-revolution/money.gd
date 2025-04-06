extends Node

signal money_changed

var money_back_up: int = 0
var MONEY: int = 0: # allows signals to be sent when money is updated
	get:
		return money_back_up
	set(value):
		emit_signal("money_changed")
		money_back_up = value


var POWER_CRYSTALS = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
