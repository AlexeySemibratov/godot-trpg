extends GunTurretTower

onready var muzzle_node = $TowerGun/GunMuzzle
onready var reload_indicator = $ReloadIndicator

var bullet_scene = preload("res://scenes/entity/ammo/Bullet.tscn")
		
func _ready():
	tower_turret = get_node("TowerGun")
			
func fire(pos):
	var bullet = bullet_scene.instance()
	var start_pos = muzzle_node.global_position
	
	var enemy = get_tree().get_nodes_in_group("EnemiesGroup")[0]
	if (enemy == null) :
		return
		
	var bullet_dir = (pos - start_pos).normalized()
	
	
	bullet.global_position = start_pos
	bullet.setup(bullet_dir, enemy)
	bullet.look_at(pos)
	get_tree().root.add_child(bullet)
		
