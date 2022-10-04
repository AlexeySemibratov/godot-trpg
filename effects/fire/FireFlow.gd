extends Node2D

@onready var fire = %Fire

func emit():
	fire.emitting = true
	
func stop_emitting():
	fire.emitting = false
