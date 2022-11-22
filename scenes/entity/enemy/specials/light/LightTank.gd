extends EnemyBase

var explosion = preload("res://effects/explosion/Explosion.tscn")

@onready var destroy_animation: AnimationPlayer = $BodyArea/Body/AnimationPlayer

func on_destroyed():
	super.on_destroyed()
	_play_destroy_animation()
	_spawn_explosion_particles()
	
	
func _spawn_explosion_particles():
	var particles = explosion.instantiate()
	# get_tree().root.add_child(particles)
	add_child(particles)
	particles.global_position = global_position
	particles.emit_once()
	
	
func _play_destroy_animation():
	destroy_animation.play("destruction_1")
