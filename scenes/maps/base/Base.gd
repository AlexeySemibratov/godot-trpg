class_name BaseArea
extends Area2D

signal on_base_hp_changed(new_value)
signal on_base_destroyed

var max_hp
var current_hp

func setup(_max_hp):
	max_hp = _max_hp
	current_hp = _max_hp
	on_base_hp_changed.emit(current_hp)
	
	
func damage_base(value):
	if (is_destroyed()):
		return
		
	current_hp = max(0, current_hp - value)
	if (current_hp <= 0):
		on_base_hp_changed.emit(current_hp)
		on_base_destroyed.emit()
	else:
		on_base_hp_changed.emit(current_hp)
		

func is_destroyed() -> bool:
	return current_hp <= 0
