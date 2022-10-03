extends VBoxContainer

signal on_reloading_time_changed(value, max_value, type)
signal on_reloading_finished

@export var drum_size = 5
@export var drum_reloading_time = 10
@export var drum_shift_time = 0.5

@onready var reloading_label = $ReloadingIndicator
@onready var drum_label = $DrumIndicator
@onready var timer = $Timer

enum ReloadingState {
	DRUM,
	SINGLE,
	NO
}

var current_reloading_state = ReloadingState.NO
var current_drum_size: int

const DRUM_RELOADING_TEXT = "%0.1f"
const DRUM_STATUS_TEXT = "%d/%d"

func _ready():
	timer.connect("timeout",Callable(self,"_on_timeout"))
	current_drum_size = drum_size

func _process(delta):
	if (timer.is_stopped()):
		return
		
	var time_left = timer.time_left
	if (current_reloading_state == ReloadingState.DRUM):
		reloading_label.text = DRUM_RELOADING_TEXT % [time_left]
		emit_signal("on_reloading_time_changed", time_left, drum_reloading_time, ReloadingState.DRUM)
	elif (current_reloading_state == ReloadingState.SINGLE):
		reloading_label.text = DRUM_RELOADING_TEXT % [time_left]
		emit_signal("on_reloading_time_changed", time_left, drum_reloading_time, ReloadingState.DRUM)
		
func on_shot():
	reloading_label.visible = true
	
	if (current_drum_size == 1):
		_start_drum_reloading()
	elif (current_drum_size > 1):
		_start_drum_shifting()
		
func _start_drum_reloading():
	current_drum_size = current_drum_size - 1
	_update_drum_status(current_drum_size)
	current_reloading_state = ReloadingState.DRUM
	timer.wait_time = drum_reloading_time
	timer.start()
	
func _start_drum_shifting():
	current_drum_size = current_drum_size - 1
	_update_drum_status(current_drum_size)
	current_reloading_state = ReloadingState.SINGLE
	timer.wait_time = drum_shift_time
	timer.start()
		
func _update_drum_status(current_size):
	drum_label.text = DRUM_STATUS_TEXT % [current_drum_size, drum_size]
	
func _on_timeout():
	reloading_label.visible = false
	
	if (current_reloading_state == ReloadingState.DRUM):
		current_drum_size = drum_size
		_update_drum_status(current_drum_size)
		
	current_reloading_state = ReloadingState.NO
	emit_signal("on_reloading_finished")
