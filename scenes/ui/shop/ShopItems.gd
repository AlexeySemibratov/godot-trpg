extends Control

signal on_button_clicked(tower)

onready var towers_container = $ScrollContainer/ButtonsContainer

var button_scene = load("res://scenes/ui/shop/ShopButton.tscn")

func add_towers(towers: Dictionary):
	for tower in towers.values():
		var button = _create_button(tower)
		towers_container.add_child(button)

func _create_button(tower):
	var button = button_scene.instance()
	button.get_node("BuildTowerButton/BuildButton").connect("pressed", self, "_on_button_clicked", [tower])
	
	var texture = ImageTexture.new()
	var image = Image.new()
	image.load(tower["icon"])
	texture.create_from_image(image)
	var icon = load(tower["icon"])
	button.get_node("BuildTowerButton/BuildButton").set_normal_texture(texture)
	return button
	
func _on_button_clicked(tower):
	emit_signal("on_button_clicked", tower)
