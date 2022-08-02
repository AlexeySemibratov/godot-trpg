extends Container

class_name SingleBulletComponent

signal on_reloading_time_changed(value, max_value)
signal on_reloading_finished

export var reloading_time = 1.0

onready var label: Label = $ReloadingLabel
onready var timer: Timer = $ReloadingTimer

const TEXT_FORMAT = "%0.1f"

func _ready():
	timer.wait_time = reloading_time
	timer.connect("timeout", self, "_on_timeout")
	
func _process(delta):
	if (!timer.is_stopped()):
		var time_left = timer.time_left
		label.text = TEXT_FORMAT % [time_left]
		emit_signal("on_reloading_time_changed", time_left, reloading_time)
	
func on_shot():
	label.visible = true
	timer.start()
	
func _on_timeout():
	label.visible = false
	emit_signal("on_reloading_finished")
	
