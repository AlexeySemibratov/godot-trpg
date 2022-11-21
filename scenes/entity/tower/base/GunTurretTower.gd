class_name GunTurretTower
extends Tower

#Tower rotation speed in degress per second
@export var rotation_speed_deg = 0

@export var active_range = 500

@export var range_area_node: NodePath
@export var turret_node: NodePath

@onready var rotation_speed = deg_to_rad(rotation_speed_deg)

@onready var range_area: Area2D = get_node(range_area_node)
@onready var tower_turret: Node2D = get_node(turret_node)
@onready var detector_ray: RayCast2D

var is_active = true


var ready_to_fire = true

var current_target_ref: WeakRef = weakref(null)

func _ready():
	_setup_collision()
	_setup_detector_ray()
	_setup_range_area()
	
	
func _setup_collision():
	var shape = CircleShape2D.new()
	shape.set_radius(active_range)
	var collision = CollisionShape2D.new()
	collision.set_shape(shape)
	range_area.add_child(collision)
	
	
func _setup_detector_ray():
	detector_ray = RayCast2D.new()
	detector_ray.target_position = Vector2.RIGHT * active_range
	tower_turret.add_child(detector_ray)
	detector_ray.set_collision_mask_value(Collision.MASK_BIT_ENEMIES, true)
	detector_ray.enabled = true
	
	
func _setup_range_area():
	range_area.connect("body_exited",Callable(self,"_on_body_leave_area"))
	
	
func _on_body_leave_area(body):
	var enemy = body.owner
	if (enemy is EnemyBase && enemy == current_target_ref.get_ref()):
		_clear_target()
		
		
func _process(delta):
	pass
	
	
func _physics_process(delta):
	if (!is_active): return
	
	_process_ai(delta)
	_process_enemy_targeting(delta)
	_process_shooting(delta)
	
	
func rotate_tower_to(delta, pos):
	var angle = tower_turret.get_angle_to(pos)
	var actual_speed = rotation_speed * delta
	if (abs(angle) < actual_speed):
		tower_turret.rotation += angle
	else:
		if (angle > 0):
			tower_turret.rotation += actual_speed
		if (angle < 0):	
			tower_turret.rotation -= actual_speed
	
	
func activate():
	is_active = true
	
	
func deactivate():
	is_active = false
	
	
func find_enemy() -> EnemyBase:
	var enemies_in_range = range_area.get_overlapping_bodies()
	for enemy in enemies_in_range:
		if (enemy && enemy.owner is EnemyBase):
			var target: EnemyBase = enemy.owner
			if (target.is_alive()):
				return target
	
	return null
	
	
func on_enemy_in_fire_range(enemy: EnemyBase):
	pass
	
	
func on_target_not_colliding(target):
	pass
	
	
func on_target_cleared(enemy: EnemyBase):
	pass


func _process_enemy_targeting(delta):
	if (!current_target_ref.get_ref()):
		return
		
	rotate_tower_to(delta, current_target_ref.get_ref().get_global_position())
		
		
func _process_shooting(delta):
	if (!current_target_ref.get_ref() or !ready_to_fire):
		return
		
	if (detector_ray.is_colliding()):
		var collider = detector_ray.get_collider()
		if(collider.owner is EnemyBase):
			var enemy: EnemyBase = collider.owner
			if (enemy == current_target_ref.get_ref()):
				on_enemy_in_fire_range(enemy)
	else:
		on_target_not_colliding(current_target_ref.get_ref())
			


func _process_ai(delta):
	if (current_target_ref.get_ref()):
		return
		
	var enemy: EnemyBase = find_enemy()
	if (enemy):
		enemy.on_dead.connect(self._clear_target)
		current_target_ref = weakref(enemy)
	
		
func _clear_target():
	on_target_cleared(current_target_ref.get_ref())
	current_target_ref = weakref(null)
	
