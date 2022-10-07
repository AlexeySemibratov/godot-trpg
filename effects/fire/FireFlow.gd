extends Node2D

@onready var fire = %Fire
@onready var smoke = %Smoke

func emit():
	fire.emitting = true
	smoke.emitting = true
	
func stop_emitting():
	fire.emitting = false
	smoke.emitting = false
