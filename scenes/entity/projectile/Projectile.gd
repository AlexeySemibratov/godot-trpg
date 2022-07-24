extends Area2D

class_name Projectile

signal on_hit_enemy(enemy)
signal on_destroyed

export var lifetime = 3

func _ready():
	get_tree().create_timer(lifetime).connect("timeout", self, "_destroy")
	
func _destroy():
	emit_signal("on_destroyed")	
	queue_free()
