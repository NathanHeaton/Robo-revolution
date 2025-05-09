extends PanelContainer

var stats_cards_scene = preload("res://UI/stats_card.tscn")

var title
var cards = {}


func get_inital_data(t_title,t_cards):
	title = t_title
	_change_title()
	GameStats.connect("stats_changed",Callable(self, "_update_values"))
	
	for stats in t_cards.keys():
		var card = stats_cards_scene.instantiate()
		var value = t_cards[stats]
		card.change_title(stats, value)
		$stat_box/stats_panel_content.add_child(card)
		cards[stats] = card
	
	
	

func _update_values(type, stat):
	if cards.get(stat):
		cards[stat].update_value(type,stat)
	

func _change_title() -> void:
	$stat_box/stats_panel_content/title.text = str(title) + " stats"
