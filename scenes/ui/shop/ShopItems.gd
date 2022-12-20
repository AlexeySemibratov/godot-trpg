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
	
	
func add_towers(towers: Dictionary):
	for tower in towers.values():
		var tower_scene = tower[Entities.towers.KEY_SCENE]
		var tower_data = load(tower[Entities.towers.KEY_TOWER_DATA])
		_add_tower_button(tower_scene, tower_data)
	
	_update_buttons()
	
func _add_tower_button(tower_scene: String, tower_data: TowerData):
	var button: ShopButton = button_scene.instantiate()
	towers_container.add_child(button)
		
	button.cost = tower_data.build_cost
	button.tower_texture_button.texture_normal = tower_data.icon_image
	button.on_card_pressed.connect(self._on_button_clicked.bind(tower_scene))


func _update_fuel_text():
	fuel_label.text = FUEL_TEXT % current_fuel
	
	
func _update_buttons():
	for child in towers_container.get_children():
		var button = child as ShopButton 
		if (button):
			button.enabled = button.cost <= current_fuel
	
	
func _on_button_clicked(tower_data):
	emit_signal("on_button_clicked", tower_data)
