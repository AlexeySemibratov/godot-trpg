class_name HPIndicator
extends TextureProgressBar


@onready var visibility_timer: Timer = %VisibilityTimer

func setup(_max_value: float, _current_value: float = 0.0):
	max_value = _max_value
	value = _current_value
	
	
func update(new_value: float):
	if (new_value <= 0):
		queue_free()
		
	value = new_value
	visible = true
	visibility_timer.start()


func _on_visibility_timer_timeout():
	visible = false
