extends EnemyBase

var explosion = preload("res://effects/explosion/Explosion.tscn")
var destroy_animation = preload("res://animations/TankDestructionl.tscn")

func on_destroyed():
	_play_destroy_animation()
	_spawn_explosion_particles()
	
func _spawn_explosion_particles():
	var particles = explosion.instantiate()
	get_tree().root.add_child(particles)
	particles.global_position = global_position
	particles.emit()
	
func _play_destroy_animation():
	var animation = destroy_animation.instantiate()
	animation.global_position = global_position
	animation.rotation = rotation
	get_map().road.add_child(animation)
	animation.start_animation()
