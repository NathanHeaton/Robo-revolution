extends Control

var combo_task_scene : PackedScene = preload("res://UI/combo_task.tscn")

enum difficulty { none,
 easy,
 medium,
 hard,
 very_hard,
 ultra_hard,
 impossible
}

var current_step = 1
var current_item_in_step

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_decide_combo_diffculty()
	ItemData.connect("collected_item",Callable(self,"_update_combo"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func generate_tasks(task_difficulty, rarity_lvl):
	var amount_of_tasks = _decide_num_of_tasks(task_difficulty)
	
	for tasks in amount_of_tasks:
		var task_panel = combo_task_scene.instantiate()
		task_panel.name = "task" + str(tasks+ 1)
		task_panel.get_intial_data(amount_of_tasks, 0, tasks + 1)
		$background_panel/Panel/combo_content.add_child(task_panel)

func _update_combo(body,collected_item):

	var path = "background_panel/Panel/combo_content/task"+str(current_step)
	var current_task = get_node(path)
	current_item_in_step = current_task.get_item()
	print(current_task.get_item())
	if (current_item_in_step == collected_item):
		print("good jopb")
	

func _decide_combo_diffculty():
	var combos_completed : float = 20# GameStats.stats["combo"]["combos_completed"]
	var task_difficulty = difficulty.none
	combos_completed = combos_completed / 10
	print(combos_completed)
	if (combos_completed < difficulty.easy):
		task_difficulty =difficulty.easy
	elif (combos_completed <= difficulty.medium):
		task_difficulty =difficulty.medium
	elif (combos_completed <= difficulty.hard):
		task_difficulty =difficulty.hard
	elif (combos_completed <= difficulty.very_hard):
		task_difficulty =difficulty.very_hard
	elif (combos_completed <= difficulty.ultra_hard):
		task_difficulty =difficulty.ultra_hard
	else :
		task_difficulty =difficulty.impossible
		
		
	
	generate_tasks(task_difficulty,GameStats.stats["luck"]["rarity_lvl"])

func _decide_num_of_tasks(t_difficulty):
	var total_task = 1
	if (t_difficulty == difficulty.easy):
		total_task = randi_range(1,2)
	elif (t_difficulty <= difficulty.medium):
		total_task = randi_range(1,3)
	elif (t_difficulty <= difficulty.hard):
		total_task = randi_range(2,3)
	elif (t_difficulty <= difficulty.very_hard):
		total_task = randi_range(2,4)
	elif (t_difficulty <= difficulty.ultra_hard):
		total_task = randi_range(3,4)
	else :
		total_task = 4
	
	return total_task



func _decide_amount_per_task(t_difficulty):
	randomize()
	var total_task = 1
	if (t_difficulty == difficulty.easy):
		total_task = randi_range(1,2)
	elif (t_difficulty <= difficulty.medium):
		total_task = randi_range(1,3)
	elif (t_difficulty <= difficulty.hard):
		total_task = randi_range(2,3)
	elif (t_difficulty <= difficulty.very_hard):
		total_task = randi_range(2,4)
	elif (t_difficulty <= difficulty.ultra_hard):
		total_task = randi_range(3,4)
	else :
		total_task = 4
	
	return total_task
