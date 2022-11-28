extends EnemyBase

var explosion = preload("res://effects/explosion/Explosion.tscn")

@onready var body = %Body

func on_destroyed():
	super.on_destroyed()
	body.play_random_destruction_animation()
	_spawn_explosion_particles()
	
	
func _spawn_explosion_particles():
	var particles = explosion.instantiate()
	add_child(particles)
	particles.global_position = global_position
	particles.emit_once()
