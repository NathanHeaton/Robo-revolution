extends Control


var pos # sprite position
var description = ""
var title = ""
var unlocked = false
var cost
var priColour =""
var secColour = ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Money.connect("money_changed", Callable(self, "_on_money_changed"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_inital_data(t_description,t_pos,t_title, t_cost, t_pri, t_sec, t_unlocked):
	pos = t_pos
	description = t_description
	title = t_title
	cost = t_cost
	priColour = t_pri
	secColour = t_sec
	unlocked = t_unlocked

	
	_change_title()
	_change_Description()
	_change_sprite()



func _on_money_changed():
	_update_button_state()

func _change_title() -> void:
	$location_panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/Upgarde_Content/VBoxContainer/Title.text = str(title)

func _change_Description() -> void:
	$location_panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/Upgarde_Content/VBoxContainer/Description.text = str(description)


	

func _update_button_state():
	pass
	#if (Money.MONEY < cost):
		#$"Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/1X".disabled = true
	#else:
		#$"Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/1X".disabled = false

func _change_sprite():
	pass
	#var icon_rect = Rect2(Vector2(pos.x *FRAME_SIZE,pos.y *FRAME_SIZE),Vector2(FRAME_SIZE,FRAME_SIZE))
	#var atlas_texture = AtlasTexture.new() # makes new atlas texture
	#atlas_texture.atlas = load("res://assets/Basic Items.png") # loads upgrades
	#atlas_texture.set_region(icon_rect) # sets rext for icons
	#$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/Upgarde_Content/Upgrade_Icons.texture = atlas_texture
	

func _change_cost():
	$"location_panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/MarginContainer/1X".text = Money.covert_Scientific_format(cost) + "$ | 1X"
