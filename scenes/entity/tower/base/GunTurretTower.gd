extends Node2D
class_name GunTurretTower

export var rotation_speed_deg = 0
export var reload_time = 1

signal on_shot
signal on_reloading_time_changed(value, max_value)
signal on_reloading_finished

var tower_turret

onready var rotation_speed = deg2rad(rotation_speed_deg)

var ready_to_fire = true
var current_reload_time = 0
	
func _input(event):
	if Input.is_action_just_pressed("fire"):
		_shoot(get_global_mouse_position())

func _physics_process(delta):
	rotate_tower_to(delta, get_global_mouse_position())
	process_reloading(delta)
	
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
		emit_signal("on_shot")
		current_reload_time = reload_time
		
func process_reloading(delta):
	if (current_reload_time > 0):
		current_reload_time = max(0, current_reload_time - delta)
		emit_signal("on_reloading_time_changed", current_reload_time, reload_time)
	elif (ready_to_fire == false):
		ready_to_fire = true
		emit_signal("on_reloading_finished")
