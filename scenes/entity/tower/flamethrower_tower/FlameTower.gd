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
	_stop_fire()
	
	
func on_target_cleared(enemy: EnemyBase):
	super.on_target_cleared(enemy)
	_stop_fire()
	
	
func _stop_fire():
	fire_component.stop_fire()
	
	
func _hit_enemies_in_range(damage_amount):
	var bodies = fire_area.get_overlapping_bodies()
	var event = _create_damage_event(damage_amount)
	for target in bodies:
		var enemy = target.owner
		if (enemy is EnemyBase):
			enemy.apply_damage_event(event)
			
			
func _create_damage_event(damage_amount: int) -> DamageEvent:
	var damage = Damage.new()
	damage.base_amount = damage_amount
	var event = DamageEvent.new()
	event.source = self
	event.damage = damage
	return event
