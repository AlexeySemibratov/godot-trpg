extends GunTurretTower

@export var damage_amount := 50

var bullet_scene = preload("res://scenes/entity/projectile/Bullet.tscn")

@onready var muzzle_node = $TowerGun/GunMuzzle
@onready var reload_indicator = $ReloadIndicator
@onready var shooting_component = $TowerGUI/AutloaderBulletComponent

func _ready():
	super._ready()
	shooting_component.connect("on_reloading_finished",Callable(self,"_on_reloading_finished"))
	
	
func on_enemy_in_fire_range(enemy: EnemyBase):
	_spawn_bullet(enemy)
	shooting_component.on_shot()
	ready_to_fire = false
	
	
func _spawn_bullet(enemy: EnemyBase):
	var start_pos = muzzle_node.global_position
	
	var bullet = bullet_scene.instantiate()
	bullet.setup(enemy.position - start_pos)
	bullet.connect("on_hit_enemy",Callable(self,"_hit_enemy"))
	bullet.global_position = start_pos
	
	get_tree().root.add_child(bullet)


func _hit_enemy(enemy: EnemyBase):
	enemy.apply_damage_event(_create_damage_event())
	
	
func _create_damage_event() -> DamageEvent:
	var damage = Damage.new()
	damage.base_amount = damage_amount
	var event = DamageEvent.new()
	event.source = self
	event.damage = damage
	return event


func _on_reloading_finished():
	ready_to_fire = true
