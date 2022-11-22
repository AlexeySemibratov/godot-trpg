extends Node2D

@onready var smoke = $Smoke
@onready var timer = $Timer

@onready var lifetime = smoke.lifetime + 1
	
func emit_once():
	timer.wait_time = lifetime
	timer.connect("timeout",Callable(self,"queue_free"))
	timer.start()
	smoke.one_shot = true
	smoke.emitting = true
