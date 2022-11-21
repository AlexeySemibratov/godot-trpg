extends Projectile

var direction = Vector2.ZERO
var speed = 1000

func setup(_direction: Vector2):
	direction = _direction.normalized()

	
func _ready():
	rotation = direction.angle()


func _physics_process(delta):
	position += direction.normalized() * speed * delta


func _on_Bullet_body_entered(body):
	if (body.owner is EnemyBase):
		emit_signal("on_hit_enemy", body.owner)
		queue_free()
