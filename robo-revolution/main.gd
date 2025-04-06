extends Node

@export var scrap_treasure: PackedScene
# Called when the node enters the scene tree for the first time.

var rarity_lvl = 3


func _ready() -> void:
	newGame()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_item_collector_collect(body: Node) -> void:
	Money.MONEY += body.get_value()
	$HUD.update_money()
	
	
	body.collect()
	
	

func newGame():
	Money.MONEY = 0
	$HUD.show_message("Collect Scrap and treasure")
	$HUD.update_money()
	#$Player.position($Start_Position.position)
	


func respawn():
	Money.MONEY = Money.MONEY * 0.1
	#$Player.start($Start_Position.position)
	

func item_spawn_location() -> Vector2: # picks where to spawn the loot items and avoids the center of the screen
	var item_spawn_region = $Player.get_item_spawn_region()
	var rndLocation = Vector2(randi_range(item_spawn_region[0].x,item_spawn_region[1].x),randi_range(item_spawn_region[0].y,item_spawn_region[1].y))
	if (rndLocation.x > 820 && rndLocation.x < 1150):
		if(rndLocation.y > 325 && rndLocation.y < 725):
			rndLocation = Vector2(rndLocation.x + 400, rndLocation.y+ 400)
	
	return rndLocation



func _spawn_loot() -> void:
	var loot = $Item_creator.spawn_item(rarity_lvl,"Scrapyard", "scrap", scrap_treasure)
	
	var rotation_dir = 0
	rotation_dir = randf_range(-PI / 4, PI/4)
	
	loot.position = item_spawn_location()
	loot.rotation = rotation_dir
	
	add_child(loot) #adds loot to main scene


func _on_hud_start_game() -> void:
	newGame()
	
