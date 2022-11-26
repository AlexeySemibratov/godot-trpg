extends Node

const MAIN_MENU = "res://scenes/ui/main_menu/MainMenu.tscn"
const MAIN_GAME = "res://scenes/MainScene.tscn"

const ARG_LEVEL_TYPE = "arg.level_type"

var arguments: Dictionary = {}


func open_main_menu():
	get_tree().change_scene_to_file(MAIN_MENU)
	
	
func open_game_scene(level_type: Levels.LevelType):
	arguments = { ARG_LEVEL_TYPE: level_type }
	get_tree().change_scene_to_file(MAIN_GAME) 
	
