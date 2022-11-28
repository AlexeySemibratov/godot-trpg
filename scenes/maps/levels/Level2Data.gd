extends LevelData

var _waves: Array[EnemyWave] = [
	EnemyWave.Builder.new()
		.add_enemy(Entities.enemies.HEAVY_TANK, 1)
		.build(),
	EnemyWave.Builder.new()
		.add_enemy(Entities.enemies.HEAVY_TANK, 3)
		.build(),
	EnemyWave.Builder.new()
		.add_enemy(Entities.enemies.LIGHT_TANK, 3)
		.add_enemy(Entities.enemies.HEAVY_TANK, 5)
		.build(),
	EnemyWave.Builder.new()
		.add_enemy(Entities.enemies.HEAVY_TANK, 8)
		.build(),
]

func get_enemy_waves() -> Array[EnemyWave]:
	return _waves
