extends MarginContainer
class_name ShopButton

signal on_card_pressed

@onready var button = $MarginContainer/VBoxContainer/BuildTowerButton
@onready var tower_texture_button = $MarginContainer/VBoxContainer/BuildTowerButton/BuildButton
@onready var cost_label = %Cost
@onready var overlay_rect = %OverlayRect

var cost = -1 :
	set(value):
		cost = value
		cost_label.text = str(value)	
		
var enabled: bool = true:
	set(value):
		enabled = value
		_update_enabled_state(value)
		
func _update_enabled_state(enabled):
	overlay_rect.visible = not enabled
	set_process_input(enabled)

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			emit_signal("on_card_pressed")
