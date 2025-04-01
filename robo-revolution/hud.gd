extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_message(text):
	$Message.text = text
	$Message.show()
	$Message_Timer.start()
	
func update_money(money):
	$Money_Label.text = str(money)


func _on_start_button_pressed():
	$Start_Button.hide()
	start_game.emit()
	


func _on_message_timer_timeout():
	$Message.hide()
