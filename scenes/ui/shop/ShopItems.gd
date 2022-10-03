extends PanelContainer

signal on_button_clicked(tower)

@onready var towers_container = $MarginContainer/VBoxContainer/ScrollContainer/ButtonsContainer

var button_scene = load("res://scenes/ui/shop/ShopButton.tscn")

func add_towers(towers: Dictionary):
	for tower in towers.values():
		var button = button_scene.instantiate()
		towers_container.add_child(button)
		button.connect("on_card_pressed",Callable(self,"_on_button_clicked").bind(tower))
		_set_tower_texture(button.tower_texture_button, tower)
		
func _set_tower_texture(button: TextureButton, tower):
	var image = Image.load_from_file(tower["icon"])
	var texture = ImageTexture.create_from_image(image)
	button.set_normal_texture(texture)
	
func _on_button_clicked(tower):
	emit_signal("on_button_clicked", tower)
