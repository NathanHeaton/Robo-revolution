extends Panel

var FRAME_SIZE = 32

var cost =0
var level =0
var max_level = 0
var scaling =0
var pos # sprite position
var description = ""
var title = ""
var buyable_levels = 0
var affordable_price = cost
var id
var maxed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Money.connect("money_changed", Callable(self, "_on_money_changed"))
	UpgradeManager.connect("level_changed", Callable(self, "_update_level"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_inital_data(t_description,t_base_cost,t_scaling,t_level,t_max_level,t_pos,t_title, t_id):
	cost = t_base_cost
	scaling = t_scaling
	level = t_level
	max_level = t_max_level
	pos = t_pos
	description = t_description
	title = t_title
	id = t_id
	
	_change_title()
	_change_Description()
	_change_sprite()
	_change_cost()
	_cal_max_buy()
	_change_level()


func _update_level(t_id):
	if (id == t_id):
		cost = UpgradeManager.get_upgrade_id(id,"Scrapyard")["cost"]
		level = UpgradeManager.get_upgrade_id(id,"Scrapyard")["level"]
		if (level >= max_level):
			_set_has_maxed()
			return
		
		_change_cost()
		_update_button_state()
		_cal_max_buy()
		$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/Upgarde_Content/VBoxContainer/Title/level_panel/level.text = "("+str(level)+"/"+str(max_level)+")"
	


func _change_level():
	$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/Upgarde_Content/VBoxContainer/Title/level_panel/level.text = "("+str(level)+"/"+str(max_level)+")"

func _on_money_changed():
	if (level >= max_level):
		_set_has_maxed()
		return
	_cal_max_buy()
	_update_button_state()

func _change_title() -> void:
	$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/Upgarde_Content/VBoxContainer/Title.text = str(title)

func _change_Description() -> void:
	$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/Upgarde_Content/VBoxContainer/Description.text = str(description)

func _cal_max_buy():# add code to calculate the amount that can be bought
	var current_money = Money.MONEY
	var max_amount = 0
	var remainingLevels = max_level - level
	
	if(current_money > 0):
		var var1:float= current_money/cost
		
		buyable_levels = log(((scaling-1)*current_money)/cost) / log(scaling) + 1
		affordable_price = current_money/buyable_levels
		buyable_levels =clamp(int(buyable_levels),0,remainingLevels)
	
	affordable_price = cost * (scaling ** (buyable_levels -1))	

	affordable_price = snapped(affordable_price, 1)
	
	if(buyable_levels == 0):
		affordable_price = cost
		$"Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Max".disabled = true
	else:
		$"Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Max".disabled = false
	
	$"Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Max".text = Money.covert_Scientific_format(affordable_price) + "$ | MAX ("+str(buyable_levels)+")"
	

func _update_button_state():
	if (Money.MONEY < cost):
		$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Buy.disabled = true
		$"Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Max".disabled = true
	else:
		$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Buy.disabled = false
		$"Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Max".disabled = false



func _change_sprite():
	var icon_rect = Rect2(Vector2(pos.x *FRAME_SIZE,pos.y *FRAME_SIZE),Vector2(FRAME_SIZE,FRAME_SIZE))
	var atlas_texture = AtlasTexture.new() # makes new atlas texture
	atlas_texture.atlas = load("res://assets/Basic Items.png") # loads upgrades
	atlas_texture.set_region(icon_rect) # sets rext for icons
	$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/Upgarde_Content/Upgrade_Icons.texture = atlas_texture
	

func _change_cost():
	$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Buy.text = Money.covert_Scientific_format(cost) + "$ | 1X"

func _set_has_maxed():
	$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Buy.disabled = true
	$"Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Max".disabled = true
	$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Buy.text =  "MAXED"
	$"Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Max".text = "MAXED"


func _on_buy_pressed() -> void:
	
	UpgradeManager.apply_upgrade(id,level,1,cost)


func _on_max_pressed() -> void:
	UpgradeManager.apply_upgrade(id,level,buyable_levels,affordable_price,)
