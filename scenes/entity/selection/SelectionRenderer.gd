extends Node2D


@onready var selection_canvas = %SelectionCanvas

func _ready():
	selection_canvas.visible = true


func setup(_range: float, _area_color: Color):
	selection_canvas.setup(_range, _area_color)


func _on_selection_area_mouse_entered():
	selection_canvas.visible = true


func _on_selection_area_mouse_exited():
	selection_canvas.visible = false


