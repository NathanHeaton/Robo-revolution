extends Sprite2D

var value = 0
var type = "scrap"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#z_index = 10
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setup_animation(t_value,t_type):
	$Label.text = "+" + str(Money.covert_Scientific_format(t_value))
	print("item collect text displaying")
	print(position)
	$AnimationPlayer.play("fade out")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("clear animation")
	queue_free()
