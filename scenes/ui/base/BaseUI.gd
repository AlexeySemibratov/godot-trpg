extends Control

@export var max_value: int
@export var damaged_limit = 0.5 # (float, 0, 1)
@export var very_damaged_limit = 0.25 # (float, 0, 1)

@onready var texture = $TextureRect
@onready var label = %BaseHP
@onready var animation = $AnimationPlayer

const MIN = 0

var current_value
	
@onready var icons = [
	"res://resources/textures/ui/shield.png", 
	"res://resources/textures/ui/shield_damaged.png", 
	"res://resources/textures/ui/shield_very_damaged.png"
	]

func _ready():
	damaged_limit = clamp(damaged_limit, MIN, max_value)
	very_damaged_limit = clamp(very_damaged_limit, MIN, damaged_limit)
	update_value(max_value)

func update_value(value):
	current_value = value
	label.text = str(value)
	update_icon(value)
	animation.play("icon_scale")
	

func update_icon(value):
	var percent: float = float(value) / float(max_value)
	var icon_index: int
	if (percent < very_damaged_limit):
		icon_index = 2
	elif (percent < damaged_limit):
		icon_index = 1
	else:
		icon_index = 0
		
	var image = Image.load_from_file(icons[icon_index])
	var image_texture = ImageTexture.create_from_image(image)
	texture.texture = image_texture

