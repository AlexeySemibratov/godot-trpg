extends GunTurretTower

@export var damage = 20

@onready var muzzle_node = $TowerGun/Muzzle

var bullet_scene = preload("res://scenes/entity/projectile/AutoAimBullet.tscn")
	
@onready var shooting_component = $TowerGUI/SingleBulletComponent
	
func on_enemy_in_fire_range(enemy: EnemyBase):
	_spawn_bullet(enemy)
	shooting_component.on_shot()
	ready_to_fire = false

func _spawn_bullet(enemy: EnemyBase):
	var start_pos = muzzle_node.global_position
	
	var bullet = bullet_scene.instantiate()
	bullet.setup((enemy.position - start_pos).normalized(), enemy)
	bullet.connect("on_hit_enemy",Callable(self,"_on_bullet_hit_enemy"))
	bullet.global_position = start_pos
	
	get_tree().root.add_child(bullet)

func _on_bullet_hit_enemy(enemy: EnemyBase):
	enemy.take_damage(damage)


func _on_SingleBulletComponent_on_reloading_finished():
	ready_to_fire = true
