extends Node



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var scrap_treasure : PackedScene = preload("res://Scenes/scrap_treasure.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func item_spawn_location() -> Vector2: # picks where to spawn the loot items and avoids the center of the screen
	var rndLocation = Vector2(
	randi_range(GameStats.stats["luck"]["item_spawn_region"].position.x,GameStats.stats["luck"]["item_spawn_region"].size.x),
	randi_range(GameStats.stats["luck"]["item_spawn_region"].position.y,GameStats.stats["luck"]["item_spawn_region"].size.y)
	)
	if (rndLocation.x > 820 && rndLocation.x < 1150):#spawned ontop of the collector
		if(rndLocation.y > 325 && rndLocation.y < 725):
			item_spawn_location()
	return rndLocation

func _spawn_loot() -> void:
	var loot = get_parent().get_node("Item_creator").spawn_item("Scrapyard", "scrap", scrap_treasure)
	var rotation_dir = 0
	rotation_dir = randf_range(-PI / 4, PI/4)
	add_child(loot) #adds loot to main scene
	loot.position = item_spawn_location()
	loot.rotation = rotation_dir


func _on_loot_spawn_timer_timeout() -> void:
	_spawn_loot()
