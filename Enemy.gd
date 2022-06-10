extends Node2D

var max_hp = 100
var current_hp = max_hp

func _process(delta):
	if (current_hp <= 0):
		queue_free()

func on_damage_recieved(amount):
	current_hp -= amount
