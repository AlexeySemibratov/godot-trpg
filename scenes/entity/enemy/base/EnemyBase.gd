extends PathFollow2D
class_name EnemyBase

@export var max_hp = 100
@export var armor = 0
@export var speed = 200

signal on_dead
signal on_damage_taken(amount, max_hp)

@onready var hp_indicator = $UI/Indicator
@onready var hp_indicator_timer = $IndicatorVisibilityTimer

@onready var current_hp = max_hp

func _ready():
	hp_indicator.show()
	hp_indicator.visible = true
	hp_indicator.max_value = max_hp
	hp_indicator.value = current_hp

func _process(delta):
	_process_movement(delta)
	_process_living(delta)
	
func _process_movement(delta):
	progress += speed * delta

func _process_living(delata):
	if (current_hp <= 0):
		emit_signal("on_dead")
		on_destroyed()
		queue_free()
		
func on_destroyed():
	pass
	
func get_map():
	return get_tree().get_nodes_in_group(Groups.GAME_MAP).front()

func take_damage(amount):
	emit_signal("on_damage_taken", amount, max_hp)
	current_hp = max(0, current_hp - amount)
	_maybe_dead()
	_update_hp_indicator()	
	
func _maybe_dead():
	if (current_hp <= 0):
		emit_signal("on_dead")
		on_destroyed()
		queue_free()
		
func _update_hp_indicator():
	hp_indicator_timer.start()
	hp_indicator.visible = true
	hp_indicator.value = current_hp

func _on_IndicatorVisibilityTimer_timeout():
	hp_indicator.visible = false
