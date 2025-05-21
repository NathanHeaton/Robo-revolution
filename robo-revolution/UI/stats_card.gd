extends PanelContainer

var title = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_title(t_title, value):
	title = t_title
	$HBoxContainer/title_value.text = title + ": " + str(value)

func update_value(type,stat):
	$HBoxContainer/title_value.text = title + ": " + str(GameStats.stats[type][stat])
