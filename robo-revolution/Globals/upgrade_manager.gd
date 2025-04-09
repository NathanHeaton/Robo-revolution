extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func apply_upgrade(type, lvl, amount, cost):
	print("applying upgrade")
	detuct_money(cost)

func update_level():
	UpgradeData.upgrades # add code to update level
	

func detuct_money(cost):
	Money.MONEY -= cost
