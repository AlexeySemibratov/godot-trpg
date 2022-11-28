extends LevelData

var _waves: Array[EnemyWave] = [
	EnemyWave.Builder.new()
		.add_enemy(Entities.enemies.LIGHT_TANK, 2)
		.build(),
	EnemyWave.Builder.new()
		.add_enemy(Entities.enemies.LIGHT_TANK, 4)
		.build(),
	EnemyWave.Builder.new()
		.add_enemy(Entities.enemies.LIGHT_TANK, 3)
		.add_enemy(Entities.enemies.HEAVY_TANK, 1)
		.build(),
	EnemyWave.Builder.new()
		.add_enemy(Entities.enemies.LIGHT_TANK, 5)
		.add_enemy(Entities.enemies.HEAVY_TANK, 2)
		.build(),
]

func get_enemy_waves() -> Array[EnemyWave]:
	return _waves
