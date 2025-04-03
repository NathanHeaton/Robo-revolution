extends Control

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_message(text):
	pass
	#$Message.text = text
	#$Message.show()
	#$Message_Timer.start()

	
func update_money(money):
	pass
	#$Money_Label.text = str(money)



func _on_message_timer_timeout():
	$Message.hide()
