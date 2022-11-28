class_name AlertDialog
extends Control

signal button_pressed

var title: String
var text: String
var button_text: String

@onready var title_label: Label = %Title
@onready var text_label: Label = %Text
@onready var button: Button = %Button

func _ready():
	_setup_view()
	_show_dialog_animation()


func setup(_title: String, _text: String, _button_text: String):
	title = _title
	text = _text
	button_text = _button_text
	
	
func _setup_view():
	scale = Vector2(0, 0)
	pivot_offset = size / 2.0
	
	title_label.text = title
	text_label.text = text
	button.text = button_text
	
	
func _show_dialog_animation():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.2)


func hide_dialog():
	queue_free()	


func _on_button_pressed():
	button_pressed.emit()
	hide_dialog()
