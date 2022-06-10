extends GunTurretTower

onready var tower_gun = $TowerGun

var bullet_scene = preload("res://scenes/entity/ammo/Bullet.tscn")
		
		
func _ready():
	tower_turret = get_node("TowerGun")
			
func fire(pos):
	var bullet = bullet_scene.instance()
	bullet.global_position = position
	bullet.direction = (pos - global_position).normalized()
	bullet.look_at(pos)
	get_tree().root.add_child(bullet)
		
