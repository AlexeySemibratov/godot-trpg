extends Area2D

var direction = Vector2.RIGHT
var speed = 400

var target

func _physics_process(delta):
	translate(direction * speed * delta)
	if (target != null):
		direction = (target.get_global_position() - global_position).normalized()

func _on_Bullet_body_entered(body):
	if body.is_in_group("EnemiesGroup"):
		body.on_damage_recieved(25)
	queue_free()

func _on_AimingArea_body_entered(body):
	target = body
