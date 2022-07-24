extends GunTurretTower

export var damage = 50

onready var muzzle_node = $TowerGun/GunMuzzle
onready var reload_indicator = $ReloadIndicator

var bullet_scene = preload("res://scenes/entity/projectile/Bullet.tscn")
			
func fire(enemy: EnemyBase):
	var start_pos = muzzle_node.global_position
	
	var bullet = bullet_scene.instance()
	bullet.setup(enemy.position - start_pos)
	bullet.connect("on_bullet_hit_enemy", self, "damage_enemy")
	bullet.global_position = start_pos
	
	get_tree().root.add_child(bullet)

func damage_enemy(enemy: EnemyBase):
	enemy.take_damage(damage)
		
