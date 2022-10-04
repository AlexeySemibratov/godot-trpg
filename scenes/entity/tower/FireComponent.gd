extends Control

signal on_damage(amount)

@onready var damage_delay_timer = %DamageDelayTimer
@onready var reloading_timer = %ReloadingTimer
@onready var overheat_timer = %OverheatTimer
@onready var label = %Label

var particles

@export var reloading_time = 5
@export var overflow_time_limit = 6
@export var damage_delay_time = 0.4
@export var damage = 12

const RELOADING_TEXT = "%0.1f/%0.1f"
const OVERHEAT_TEXT = "%d%%"

enum State {
	RELOADING,
	FIRING,
	IDLE
}

var state = State.IDLE

var overheat_sec = 0

func setup(_particles):
	particles = _particles
	
func _process(delta):
	_render_state(state)
	_update_particles(state)
	if (state == State.FIRING):
		if (overheat_sec >= overflow_time_limit):
			_start_reloading()
			
		overheat_sec = clamp(overheat_sec + delta, 0, overflow_time_limit)
	elif (state == State.IDLE):
		overheat_sec = clamp(overheat_sec - delta, 0, overflow_time_limit)

func fire():
	if (state == State.RELOADING || !damage_delay_timer.is_stopped()):
		return
		
	state = State.FIRING
	damage_delay_timer.start(damage_delay_time)

func stop_fire():
	if (state == State.FIRING):
		state = State.IDLE
	
func _start_reloading():
	state = State.RELOADING
	reloading_timer.start(reloading_time)
	
func _render_state(state: State):
	var text 
	if (state == State.FIRING):
		text = OVERHEAT_TEXT % [_get_overheat_percent()]
	elif (state == State.RELOADING):
		text = RELOADING_TEXT % [reloading_timer.time_left, reloading_time]
	elif (state == State.IDLE):
		if (overheat_sec > 0):
			text = OVERHEAT_TEXT % [_get_overheat_percent()]
		else:
			text = ""
			
	label.text = text 
	
func _get_overheat_percent():
	return 100.0 * overheat_sec / overflow_time_limit
	
func _update_particles(state: State):
	if (particles == null):
		return 
		
	if (state == State.FIRING):
		particles.emit()
	else:
		particles.stop_emitting()

func _on_reloading_timer_timeout():
	state = State.IDLE
	overheat_sec = 0

func _on_damage_delay_timer_timeout():
	emit_signal("on_damage", damage)
