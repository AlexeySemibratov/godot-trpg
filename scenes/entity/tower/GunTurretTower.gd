extends Node2D
class_name GunTurretTower

export var rotation_speed_deg = 0
export var reload_time = 1

onready var rotation_speed = deg2rad(rotation_speed_deg)

var tower_turret

var ready_to_fire = true
	
func _input(event):
	if Input.is_action_just_pressed("fire"):
		_shoot(get_global_mouse_position())

func _physics_process(delta):
	rotate_tower_to(delta, get_global_mouse_position())
	
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
		
func fire(pos: Vector2):
	pass
		
func _shoot(pos):
	if (ready_to_fire):
		ready_to_fire = false
		fire(pos)
		ready_to_fire = true
