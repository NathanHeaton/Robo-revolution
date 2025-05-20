extends RigidBody2D

@export var item_sprite : PackedScene

var value = 0
var item 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()# makes vbarients more random
	if (LocationData.CURRENT_LOCATION == 2):
		linear_damp = 0.5
	else:
		linear_damp = 2.0  # Higher = more resistance
	

func spawn_loot_type(t_item):
	item = t_item
	if (item == null):
		print("error: item is null")
		return

	$Item_sprites.play(item.name)
	var rnd_frame = randi_range(0,item.variants-1)
	$Item_sprites.frame = rnd_frame
	$Item_sprites.pause()
	value = item.value
	mass = item.weight

func get_value() -> int:
	return value

func get_item():
	return item

func get_currency():
	var type = "money"
	if (item.name == "power_crystals"):
		type = "powerC"
	return type

func get_type():
	return item["type"]

func _on_despawn_start_timeout() -> void:
	$fade_out_player.play("RESET")

func _on_fade_out_player_animation_finished(anim_name: StringName) -> void:
	queue_free()


func reset_velocity():
	mass = 50
	linear_velocity = Vector2(0,0)
	angular_velocity = 0
	linear_damp = 3


func collect():
	$fade_out_player.stop()
	$CollisionShape2D.set_deferred("disabled",true)
	$collect.play("RESET")

func _on_collect_animation_finished(anim_name: StringName) -> void:
	queue_free()
