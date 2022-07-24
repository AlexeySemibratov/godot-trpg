extends Node2D

export var base_hp = 10

onready var path: Path2D = $Path2D
onready var ground = $GroundLevel
onready var road = $RoadLevel
onready var decorations = $DecorationLevel
onready var base = $BaseArea

func _init():
	add_to_group(Groups.GAME_MAP)

func _ready():
	base.connect("body_entered", self, "on_body_enter_base")
	for i in range(10):
		var enemy = load("res://scenes/entity/enemy/Tank.tscn").instance()
		path.add_child(enemy)
		var delay = rand_range(0.5, 1)
		yield(get_tree().create_timer(delay), "timeout")
		
func on_body_enter_base(body):
	if (body.owner is EnemyBase):
		body.owner.queue_free()
		base.damage_base(1)
