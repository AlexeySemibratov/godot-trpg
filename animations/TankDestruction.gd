extends Node2D

onready var animation = $AnimationPlayer
onready var timer = $Timer

func start_animation():
	timer.connect("timeout", self, "queue_free")
	timer.start()
	animation.play("tank explosion")
