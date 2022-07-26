extends PanelContainer

signal on_button_clicked(tower)

onready var towers_container = $MarginContainer/VBoxContainer/ScrollContainer/ButtonsContainer

var button_scene = load("res://scenes/ui/shop/ShopButton.tscn")

func add_towers(towers: Dictionary):
	for tower in towers.values():
		var button = button_scene.instance()
		towers_container.add_child(button)
		button.connect("on_card_pressed", self, "_on_button_clicked", [tower])
		_set_tower_texture(button.tower_texture_button, tower)
		
func _set_tower_texture(button: TextureButton, tower):
	var texture = ImageTexture.new()
	var image = Image.new()
	image.load(tower["icon"])
	texture.create_from_image(image)
	var icon = load(tower["icon"])
	button.set_normal_texture(texture)
	
func _on_button_clicked(tower):
	emit_signal("on_button_clicked", tower)
