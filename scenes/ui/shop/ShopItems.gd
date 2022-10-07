extends PanelContainer

signal on_button_clicked(tower_data)

@onready var towers_container = $MarginContainer/VBoxContainer/ScrollContainer/ButtonsContainer

var button_scene = load("res://scenes/ui/shop/ShopButton.tscn")

func add_towers(towers: Dictionary):
	for tower_data in towers.values():
		var button = button_scene.instantiate()
		var tower_obj = load(tower_data[Towers.KEY_SCENE]).instantiate()
		towers_container.add_child(button)
		button.cost = tower_obj.build_cost
		button.connect("on_card_pressed",Callable(self,"_on_button_clicked").bind(tower_data))
		_set_tower_texture(button.tower_texture_button, tower_obj.icon_image_path)
		tower_obj.queue_free()
		
func _set_tower_texture(button: TextureButton, image_path):
	var image = Image.load_from_file(image_path)
	var texture = ImageTexture.create_from_image(image)
	button.set_normal_texture(texture)
	
func _on_button_clicked(tower_data):
	emit_signal("on_button_clicked", tower_data)
