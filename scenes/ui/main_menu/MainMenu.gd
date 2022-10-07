extends Control

const GAME_SCENE = preload("res://scenes/MainScene.tscn")

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/MainScene.tscn")
