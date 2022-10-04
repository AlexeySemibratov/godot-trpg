extends GunTurretTower

@onready var fireflow = %Fireflow
@onready var fire_component = %FireComponent
@onready var fire_area: Area2D = %FireArea

func _ready():
	super._ready()
	fire_component.on_damage.connect(self._hit_enemies_in_range)
	fire_component.setup(fireflow)

func on_enemy_in_fire_range(enemy: EnemyBase):
	fire_component.fire()
	
func on_target_not_colliding(target):
	fire_component.stop_fire()
	
func _hit_enemies_in_range(damage):
	var bodies = fire_area.get_overlapping_bodies()
	for target in bodies:
		var enemy = target.owner
		if (enemy is EnemyBase):
			enemy.take_damage(damage)
