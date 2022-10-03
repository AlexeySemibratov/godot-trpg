extends Projectile

var direction = Vector2.ZERO
var acceleration = Vector2.ZERO
var speed = 600
var steer_force = 150

var target_ref: WeakRef

func setup(_direction: Vector2, _target: EnemyBase):
	direction = _direction.normalized() * speed
	target_ref = weakref(_target)

func _physics_process(delta):
	acceleration += seek()
	direction += clamp(Vector2.ZERO, acceleration * delta, speed * Vector2(1, 0))
	rotation = direction.angle()
	position += direction * delta
		
func seek():
	var steer = Vector2.ZERO
	if (target_ref.get_ref()):
		var target = target_ref.get_ref()
		var desired = (target.global_position - position).normalized() * speed
		steer = (desired - direction).normalized() * steer_force
	return steer

func _on_Bullet_body_entered(body):
	if (body.owner is EnemyBase):
		emit_signal("on_hit_enemy", body.owner)
		queue_free()
