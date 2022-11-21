class_name Projectile
extends Area2D

signal on_hit_enemy(enemy)
signal on_destroyed

@export var lifetime = 4


func _ready():
	get_tree().create_timer(lifetime).connect("timeout",Callable(self,"_destroy"))
	
	
func _destroy():
	emit_signal("on_destroyed")	
	queue_free()
