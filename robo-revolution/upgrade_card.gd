extends Panel

var FRAME_SIZE = 32

var cost =0
var level =0
var scaling =0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/1X".disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func change_title(text) -> void:
	$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/Upgarde_Content/VBoxContainer/Title.text = str(text)

func change_Description(text) -> void:
	$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/Upgarde_Content/VBoxContainer/Description.text = str(text)

func cal_max_buy(t_level,t_cost,t_scaling):
	level = t_level
	scaling = t_scaling
	Money.MONEY
	$"Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/Max".text = str(Money.MONEY) + "$ | BUY"
	


func change_sprite(t_pos):
	var icon_rect = Rect2(Vector2(t_pos.x *FRAME_SIZE,t_pos.y *FRAME_SIZE),Vector2(FRAME_SIZE,FRAME_SIZE))
	var atlas_texture = AtlasTexture.new() # makes new atlas texture
	atlas_texture.atlas = load("res://assets/Basic Items.png") # loads upgrades
	atlas_texture.set_region(icon_rect) # sets rext for icons
	$Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/Upgarde_Content/Upgrade_Icons.texture = atlas_texture

func change_cost(t_cost):
	cost =t_cost
	$"Panel/MarginContainer/Upgarde_Content_Panel/MarginContainer/buy_section/1X".text = str(cost) + "$ | BUY"
