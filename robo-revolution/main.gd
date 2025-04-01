extends Node

@export var scrap_treasure: PackedScene
# Called when the node enters the scene tree for the first time.

var money = 0

func _ready() -> void:
	newGame()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_push() -> void:
	pass # Replace with function body.
	
	


func _on_item_collector_collect() -> void:
	money += 40
	
	

func newGame():
	money = 0
	$HUD.show_message("Collect Items")
	$HUD.update_money(money)
	#$Player.position($Start_Position.position)
	


func respawn():
	money = money * 0.1
	#$Player.start($Start_Position.position)


func _spawn_loot() -> void:
	var loot = scrap_treasure.instantiate()
	
	var loot_spawn_location = $Temp_Item_spawn/spawn_location
	loot_spawn_location.progress_ratio = randf()
	
	loot.position = loot_spawn_location.position
	
	var rotation_dir = 0
	
	rotation_dir = randf_range(-PI / 4, PI/4)
	
	loot.rotation = rotation_dir
	
	add_child(loot) #adds loot to main scene


func _on_hud_start_game() -> void:
	newGame()
