extends Control


var pos # sprite position
var description = ""
var title = ""
var location_enum
var unlocked = false
var cost
var priColour =""
var secColour = ""
var key_needed = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Money.connect("money_changed", Callable(self, "_on_money_changed"))
	UpgradeManager.connect("unlock_location", Callable(self, "_unlock"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_inital_data(t_description,t_pos,t_title, t_cost, t_unlocked,t_key_needed):
	pos = t_pos
	description = t_description
	title = t_title
	location_enum = LocationData.location_to_enum.get(title)
	cost = t_cost

	unlocked = t_unlocked
	key_needed = t_key_needed
	_change_theme()
	_change_title()
	_change_unlocked()
	_change_Description()
	_change_sprite()
	_update_button_state()

func _unlock():
	unlocked = LocationData.location_data[location_enum]["unlocked"]
	_update_button_state()
	_change_unlocked()


func _change_unlocked():
	if (unlocked):
		$"location_panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/MarginContainer/location_button".text = "Travel"
	else:
		_change_cost()
	


func _on_money_changed():
	_update_button_state()

func _change_title() -> void:
	$location_panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/Upgarde_Content/VBoxContainer/Title.text = str(title)

func _change_Description() -> void:
	$location_panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/Upgarde_Content/VBoxContainer/Description.text = str(description)

func _change_theme():
	$location_panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/MarginContainer/location_button.theme = GlobalThemes.themes.get(title)

	

func _update_button_state():
	if (Money.MONEY < cost && unlocked == false):
		$location_panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/MarginContainer/location_button.disabled = true
	else:
		$location_panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/MarginContainer/location_button.disabled = false

func _change_sprite():
	pass
	#var icon_rect = Rect2(Vector2(pos.x *FRAME_SIZE,pos.y *FRAME_SIZE),Vector2(FRAME_SIZE,FRAME_SIZE))
	#var atlas_texture = AtlasTexture.new() # makes new atlas texture
	#atlas_texture.atlas = load("res://assets/Basic Items.png") # loads upgrades
	#atlas_texture.set_region(icon_rect) # sets rext for icons
	#$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/Upgarde_Content/Upgrade_Icons.texture = atlas_texture
	

func _change_cost():
	$"location_panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/MarginContainer/location_button".text = Money.covert_Scientific_format(cost) + "$"
	if (key_needed):
		$"location_panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/MarginContainer/location_button".text = Money.covert_Scientific_format(cost) + "$ + 1X KEY"


func _on_location_button_pressed() -> void:
	if (unlocked == false):
		UpgradeManager.buy_location(cost,location_enum)
	else:
		LocationData.CURRENT_LOCATION = location_enum
