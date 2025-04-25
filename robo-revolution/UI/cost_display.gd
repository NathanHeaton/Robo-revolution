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

func setup_animation(t_value,t_currency,t_type):
	print(t_type)
	if( t_type == "treasure"):
		print("treasure collected")
		$Label.add_theme_color_override("font_color",Color("#FAE884"))
	
	if(t_currency == "powerC"): # sets texture for power crystals
		var currencey_icon = AtlasTexture.new()
		currencey_icon.atlas = load("res://assets/Mini_Icons.png")
		currencey_icon.set_region(Rect2(Vector2(16,0),Vector2(16,16)))
		$Label/TextureRect.texture = currencey_icon
	
	$Label.text = "+" + str(Money.covert_Scientific_format(t_value))
	$AnimationPlayer.play("fade out")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
