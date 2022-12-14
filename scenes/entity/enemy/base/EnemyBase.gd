class_name EnemyBase
extends PathFollow2D

signal on_dead
signal on_damage_taken(amount, max_hp)

@export var max_hp = 100
@export var speed = 100

@export var reward_fuel: int = 0

@onready var hp_indicator: HPIndicator = $UI/Indicator

@onready var despawn_timer: Timer = %DespawnTimer

@onready var current_hp = max_hp

enum State {
	LIVING,
	DESTROYED
}

var state = State.LIVING

func _ready():
	hp_indicator.visible = false
	hp_indicator.setup(max_hp, current_hp)
	

func _process(delta):
	_process_movement(delta)
	
	
func _process_movement(delta):
	if (state == State.LIVING):
		progress += speed * delta

		
func on_destroyed():
	state = State.DESTROYED
	emit_signal("on_dead")
	Events.emit_signal("on_enemy_destroyed", self)
	despawn_timer.start()


func is_alive() -> bool:
	return state != State.DESTROYED
		
		
func apply_damage_event(event: DamageEvent):
	if (state == State.LIVING):
		var amount = event.damage.base_amount
		emit_signal("on_damage_taken", amount, max_hp)
		Events.emit_signal("on_damage_event", event)
		current_hp = max(0, current_hp - amount)
		
		if (current_hp <= 0):
			Events.emit_signal("on_enemy_destroyed_by", event.source, self)
			on_destroyed()
		
		_update_hp_indicator()	
	
		
func _update_hp_indicator():
	hp_indicator.update(current_hp)


func _on_IndicatorVisibilityTimer_timeout():
	hp_indicator.visible = false


func _on_despawn_timer_timeout():
	queue_free()
