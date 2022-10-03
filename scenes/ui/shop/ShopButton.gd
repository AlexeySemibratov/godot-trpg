extends MarginContainer

signal on_card_pressed

@onready var button = $MarginContainer/VBoxContainer/BuildTowerButton
@onready var tower_texture_button = $MarginContainer/VBoxContainer/BuildTowerButton/BuildButton

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			emit_signal("on_card_pressed")
