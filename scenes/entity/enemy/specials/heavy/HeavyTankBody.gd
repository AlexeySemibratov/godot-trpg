extends Node2D

var _destruction_animations: Array[String] = ["destruction_1", "destruction_2"]

@onready var animation_player: AnimationPlayer = %AnimationPlayer

func play_random_destruction_animation():
	var index = randi_range(0, _destruction_animations.size() - 1)
	var random_animation = _destruction_animations[index]
	animation_player.play(random_animation)
	
