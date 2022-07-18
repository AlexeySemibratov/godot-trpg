extends Area2D

var direction = Vector2.ZERO
var acceleration = Vector2.ZERO
var speed = 400
var steer_force = 50

var target = null

func setup(_direction, _target):
	direction = _direction.normalized() * speed
	target = _target

func _physics_process(delta):
	acceleration += seek()
	direction += (acceleration * delta).clamped(speed)
	rotation = direction.angle()
	position += direction * delta
		
func seek():
	var steer = Vector2.ZERO
	if (target):
		var desired = (target.global_position - position).normalized() * speed
		steer = (desired - direction).normalized() * steer_force
	return steer

func _on_Bullet_body_entered(body):
	if body.is_in_group("EnemiesGroup"):
		body.on_damage_recieved(25)
	queue_free()
