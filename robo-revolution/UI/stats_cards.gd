extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var FRAME_SIZE = 32

var cost =0
var level =0
var max_level = 0
var scaling =0
var pos # sprite position
var description = ""
var first_description = ""
var title = ""
var buyable_levels = 0
var affordable_price = cost
var id
var maxed = false
var location =""
var currency = ""


func get_inital_data(t_title,t_cards):
	title = t_title
	print(t_title)
	_change_title()
	
	for stats in t_cards.keys():
		var panel = Panel.new()
		$stat_box/stats_panel_content.add_child($stat_box/stats_panel_content/stat.duplicate())
	
	


func _change_title() -> void:
	$stat_box/stats_panel_content/title.text = str(title) + " stats"

func _change_Description() -> void:
	if (first_description != "" && level == 0):
		$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/Upgarde_Content/VBoxContainer/Description.text = str(first_description)
	else:
		$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/Upgarde_Content/VBoxContainer/Description.text = str(description)
		

func _cal_max_buy():# add code to calculate the amount that can be bought
	if (max_level != 1):
		var currency_amount
		if (currency == "money"):
			currency_amount = Money.MONEY
		elif (currency == "powerC"):
			currency_amount = Money.POWER_C
			

		var remainingLevels = max_level - level
		
		var info = Money.calculate_max_buy(remainingLevels,currency_amount,cost ,scaling)

		affordable_price = info["price"]
		buyable_levels = info["levels"]
		if(buyable_levels == 0):
			affordable_price = cost
			$"Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Max".disabled = true
		else:
			$"Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Max".disabled = false
		
		$"Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Max".text = Money.covert_Scientific_format(affordable_price) + " | MAX ("+str(buyable_levels)+")"
	else:
		$"Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Max".hide()

func _update_button_state():
	var current_cost
	if (currency == "money"):
		current_cost = Money.MONEY
	elif (currency == "powerC"):
		current_cost = Money.POWER_C
	if (current_cost < cost):
		$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Buy.disabled = true
		$"Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Max".disabled = true
	else:
		$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Buy.disabled = false
		$"Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Max".disabled = false



func _change_sprite():
	var icon_rect = Rect2(Vector2(pos.x *FRAME_SIZE,pos.y *FRAME_SIZE),Vector2(FRAME_SIZE,FRAME_SIZE))
	var atlas_texture = AtlasTexture.new() # makes new atlas texture
	atlas_texture.atlas = load("res://assets/Upgrades.png") # loads upgrades
	atlas_texture.set_region(icon_rect) # sets rext for icons
	$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/Upgarde_Content/Upgrade_Icons.texture = atlas_texture
	

func _set_icon():
	var icon_texture = ImageTexture.new()
	var texture = load("res://assets/"+str(currency)+".png") as Texture2D
	icon_texture.set_image(texture.get_image())

	icon_texture.set_size_override(Vector2i(24,24))
	
	$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Buy.icon = icon_texture
	$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Max.icon = icon_texture

func _change_cost():

	$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Buy.text = Money.covert_Scientific_format(cost) + " | 1X"

func _set_has_maxed():
	$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Buy.disabled = true
	$"Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Max".disabled = true
	$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Buy.text =  "MAXED"
	$"Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Max".text = "MAXED"


func _on_buy_pressed() -> void:
	
	UpgradeManager.apply_upgrade(id,level,1,cost,location,currency)


func _on_max_pressed() -> void:
	UpgradeManager.apply_upgrade(id,level,buyable_levels,affordable_price,location,currency)
