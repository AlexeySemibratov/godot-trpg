extends Node2D

var color: Color
var range: float

func setup(_range: float, _color: Color):
	range = _range
	color = _color

func _draw():
	if (range <= 0):
		return
		
	var center = Vector2(0, 0)
	draw_circle(center, range, color)
