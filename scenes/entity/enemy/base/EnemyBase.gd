extends Node2D
class_name Enemy

export var max_hp = 100
export var armor = 0

signal on_dead
signal on_damage_taken(amount, max_hp)

var current_hp = max_hp

func _process(delta):
	process_living(delta)

func process_living(delata):
	if (current_hp < 0):
		queue_free()

func take_damage(amount):
	emit_signal("on_damage_taken", amount, max_hp)
	current_hp = max(0, current_hp - amount)
	
