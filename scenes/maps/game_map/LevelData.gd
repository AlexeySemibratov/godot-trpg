class_name LevelData
extends Node

@export var level: Levels.LevelType
@export var next_level: Levels.LevelType

func get_enemy_waves() -> Array[EnemyWave]:
	return []
