extends PathFollow2D
class_name EnemyBase

@export var max_hp = 100
@export var armor = 0
@export var speed = 200

signal on_dead
signal on_damage_taken(amount, max_hp)

@onready var hp_indicator = $UI/Indicator
@onready var hp_indicator_timer = $IndicatorVisibilityTimer

@onready var despawn_timer: Timer = %DespawnTimer

@onready var current_hp = max_hp

enum State {
	LIVING,
	DESTROYED
}

var state = State.LIVING

func _ready():
	hp_indicator.show()
	hp_indicator.visible = true
	hp_indicator.max_value = max_hp
	hp_indicator.value = current_hp

func _process(delta):
	_process_movement(delta)
	_process_living(delta)
	
func _process_movement(delta):
	if (state == State.LIVING):
		progress += speed * delta

func _process_living(delata):
	pass
	# if (current_hp <= 0):
		# on_destroyed()
		
func on_destroyed():
	state = State.DESTROYED
	emit_signal("on_dead")
	despawn_timer.start()
	
func get_map():
	return get_tree().get_nodes_in_group(Groups.GAME_MAP).front()

func is_alive() -> bool:
	return state != State.DESTROYED

func take_damage(amount):
	if (state == State.LIVING):
		emit_signal("on_damage_taken", amount, max_hp)
		current_hp = max(0, current_hp - amount)
		_maybe_dead()
		_update_hp_indicator()	
	
func _maybe_dead():
	if (current_hp <= 0):
		on_destroyed()
		
func _update_hp_indicator():
	hp_indicator_timer.start()
	hp_indicator.visible = true
	hp_indicator.value = current_hp

func _on_IndicatorVisibilityTimer_timeout():
	hp_indicator.visible = false

func _on_despawn_timer_timeout():
	queue_free()
