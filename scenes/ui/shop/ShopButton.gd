extends MarginContainer

signal on_card_pressed

@onready var button = $MarginContainer/VBoxContainer/BuildTowerButton
@onready var tower_texture_button = $MarginContainer/VBoxContainer/BuildTowerButton/BuildButton
@onready var cost_label = %Cost

var cost = -1 :
	set(value):
		cost = value
		cost_label.text = str(value)	

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			emit_signal("on_card_pressed")
