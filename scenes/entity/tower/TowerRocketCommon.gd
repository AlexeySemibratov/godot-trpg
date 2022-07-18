extends GunTurretTower

onready var muzzle_node = $TowerGun/Muzzle

var bullet_scene = preload("res://scenes/entity/ammo/Bullet.tscn")

func _ready():
	tower_turret = get_node("TowerGun")
	
func fire(pos):
	var bullet = bullet_scene.instance()
	var start_pos = muzzle_node.global_position
	bullet.global_position = start_pos
	bullet.direction = (pos - start_pos).normalized()
	bullet.look_at(pos)
	get_tree().root.add_child(bullet)
