extends Node2D
class_name GunTurretTower

#Tower rotation speed in degress per second
export var rotation_speed_deg = 0

#Reloading time in second
export var reload_time = 1

export var active_range = 500

export(NodePath) var range_area_node
export(NodePath) var turret_node

onready var range_area: Area2D = get_node(range_area_node)
onready var tower_turret: Node2D = get_node(turret_node)
onready var detector_ray: RayCast2D

signal on_shot
signal on_reloading_time_changed(value, max_value)
signal on_reloading_finished

var is_active = true

onready var rotation_speed = deg2rad(rotation_speed_deg)

var ready_to_fire = true
var current_reload_time = 0

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
	detector_ray.cast_to = Vector2.RIGHT * active_range
	detector_ray.set_collision_mask_bit(Collision.MASK_BIT_ENEMIES, true)
	tower_turret.add_child(detector_ray)
	detector_ray.enabled = true
	
func _setup_range_area():
	range_area.connect("body_exited", self, "_on_body_leave_area")
	
func _on_body_leave_area(body):
	var enemy = body.owner
	if (enemy is EnemyBase && enemy == current_target_ref.get_ref()):
		_clear_target()
	
func _physics_process(delta):
	if (!is_active): return
	
	_process_ai(delta)
	_process_enemy_targeting(delta)
	_process_shooting(delta)
	_process_reloading(delta)
	
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
		
func fire(enemy: EnemyBase):
	pass
	
func activate():
	is_active = true
	
func deactivate():
	is_active = false
	
func find_enemy() -> EnemyBase:
	var enemies_in_range = range_area.get_overlapping_bodies()
	for enemy in enemies_in_range:
		if (enemy && enemy.owner is EnemyBase):
			var target: EnemyBase = enemy.owner
			return target
	
	return null
		
func _shoot(enemy: EnemyBase):
	if (ready_to_fire):
		ready_to_fire = false
		fire(enemy)
		emit_signal("on_shot")
		current_reload_time = reload_time
		
func _process_reloading(delta):
	if (current_reload_time > 0):
		current_reload_time = max(0, current_reload_time - delta)
		emit_signal("on_reloading_time_changed", current_reload_time, reload_time)
	elif (ready_to_fire == false):
		ready_to_fire = true
		emit_signal("on_reloading_finished")
		
func _process_enemy_targeting(delta):
	if (!current_target_ref.get_ref()):
		return
		
	rotate_tower_to(delta, current_target_ref.get_ref().get_global_position())
		
func _process_shooting(delta):
	if (!current_target_ref.get_ref()):
		return
		
	if (detector_ray.is_colliding()):
		var collider = detector_ray.get_collider()
		if(collider.owner is EnemyBase):
			_shoot(current_target_ref.get_ref())

func _process_ai(delta):
	if (current_target_ref.get_ref()):
		 return
		
	var enemy: EnemyBase = find_enemy()
	if (enemy):
		current_target_ref = weakref(enemy)
		
func _clear_target():
	current_target_ref = weakref(null)
	
