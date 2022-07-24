extends Area2D

var max_hp
var current_hp

signal on_base_hp_changed(new_value)
signal on_base_destroyed

func setup(_max_hp):
	max_hp = _max_hp
	current_hp = _max_hp
	
func damage_base(value):
	current_hp = max(0, current_hp - value)
	if (current_hp <= 0):
		emit_signal("on_base_destroyed")
	else:
		emit_signal("on_base_hp_changed", current_hp)
