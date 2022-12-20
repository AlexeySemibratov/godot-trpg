class_name TowersShop
extends PanelContainer

signal on_button_clicked(tower_scene)

var button_scene = load("res://scenes/ui/shop/ShopButton.tscn")

var current_fuel: int = 30		

const FUEL_TEXT = "Fuel: %d"

@onready var towers_container = %ButtonsContainer
@onready var fuel_label = %FuelLabel

func _ready():
	_update_fuel_text()


func has_enough_fuel(cost) -> bool:
	return cost <= current_fuel


func add_fuel(value):
	current_fuel += value
	_update_fuel_text()
	_update_buttons()


func decrease_fuel(value):
	current_fuel -= value
	_update_fuel_text()
	_update_buttons()


func _update_fuel_text():
	fuel_label.text = FUEL_TEXT % current_fuel
	
	
func _update_buttons():
	for child in towers_container.get_children():
		var button = child as ShopButton 
		if (button):
			button.enabled = button.cost <= current_fuel


func add_towers(towers: Dictionary):
	for tower_scene in towers.values():
		var button: ShopButton = button_scene.instantiate()
		var tower_obj = load(tower_scene).instantiate()
		towers_container.add_child(button)
		button.cost = tower_obj.build_cost
		button.connect("on_card_pressed",Callable(self,"_on_button_clicked").bind(tower_scene))
		_set_tower_texture(button.tower_texture_button, tower_obj.icon_image_path)
		tower_obj.queue_free()
	
	_update_buttons()

		
func _set_tower_texture(button: TextureButton, image_path):
	var image = Image.load_from_file(image_path)
	var texture = ImageTexture.create_from_image(image)
	button.texture_normal = texture
	
	
func _on_button_clicked(tower_data):
	emit_signal("on_button_clicked", tower_data)
