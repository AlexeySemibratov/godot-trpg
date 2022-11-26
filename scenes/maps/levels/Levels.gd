extends Node

enum LevelType {
	LEVEL_1,
	LEVEL_2
}

var _levels_dict: Dictionary = {
	LevelType.LEVEL_1: "res://scenes/maps/levels/MapLevel1.tscn",
	LevelType.LEVEL_2: "res://scenes/maps/levels/MapLevel2.tscn",
}

func get_level_scene(level: LevelType) -> String:
	return _levels_dict[level]
