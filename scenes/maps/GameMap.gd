extends Node2D

onready var path: Path2D = $Path2D
onready var ground = $GroundLevel
onready var road = $RoadLevel
onready var decorations = $DecorationLevel

func _init():
	add_to_group(Groups.GAME_MAP)

func _ready():
	for i in range(4):
		var enemy = load("res://scenes/entity/enemy/Tank.tscn").instance()
		path.add_child(enemy)
		yield(get_tree().create_timer(1), "timeout")
