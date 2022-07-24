extends GunTurretTower

export var damage = 20

onready var muzzle_node = $TowerGun/Muzzle

var bullet_scene = preload("res://scenes/entity/projectile/AutoAimBullet.tscn")
	
func fire(enemy: EnemyBase):
	var start_pos = muzzle_node.global_position
	
	var bullet = bullet_scene.instance()
	bullet.setup((enemy.position - start_pos).normalized(), enemy)
	bullet.connect("on_bullet_hit_enemy", self, "_on_bullet_hit_enemy")
	bullet.global_position = start_pos
	
	get_tree().root.add_child(bullet)

func _on_bullet_hit_enemy(enemy: EnemyBase):
	enemy.take_damage(damage)
