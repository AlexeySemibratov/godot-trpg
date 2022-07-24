extends Node2D

onready var path: Path2D = $"Path2D"

func _ready():
	var enemy1 = load("res://scenes/entity/enemy/Tank.tscn").instance()
	var enemy2 = load("res://scenes/entity/enemy/Tank.tscn").instance()
	path.add_child(enemy1)
	yield(get_tree().create_timer(1.0), "timeout")
	path.add_child(enemy2)
