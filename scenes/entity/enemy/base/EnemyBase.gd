extends PathFollow2D
class_name EnemyBase

export var max_hp = 100
export var armor = 0
export var speed = 200

export(NodePath) var body_node

signal on_dead
signal on_damage_taken(amount, max_hp)

onready var body: KinematicBody2D = get_node(body_node)

onready var current_hp = max_hp

func _process(delta):
	_process_movement(delta)
	_process_living(delta)
	
func _process_movement(delta):
	offset += speed * delta

func _process_living(delata):
	if (current_hp <= 0):
		emit_signal("on_dead")
		on_destroyed()
		queue_free()
		
func on_destroyed():
	pass
	
func get_map():
	return get_tree().get_nodes_in_group(Groups.GAME_MAP).front()

func take_damage(amount):
	emit_signal("on_damage_taken", amount, max_hp)
	current_hp = max(0, current_hp - amount)
	
