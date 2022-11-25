class_name EnemyWave

var entities_and_count_dict: Dictionary = {
	Entities.enemies.LIGHT_TANK: 2,
	Entities.enemies.HEAVY_TANK: 1
}

func _init(_entities_and_count_dict: Dictionary):
	entities_and_count_dict = _entities_and_count_dict
	
	
func get_total_enemy_count() -> int:
	var counts = entities_and_count_dict.values()
	return counts.reduce(func(acc, next): return acc + next)
	
	
func get_iterator() -> EnemyWave.Iterator:
	return Iterator.new(self)
			
	
## TODO for easily wave iteration		
class Iterator:
	
	var wave: EnemyWave
	
	var current = 0
	
	func _init(_wave: EnemyWave):
		wave = _wave

class Builder:
	
	var entities_count_dict: Dictionary = {}
	
	func add_enemy(enemy_id: String, count: int = 1) -> EnemyWave.Builder:
		if (entities_count_dict.has(enemy_id)):
			var current_count = entities_count_dict[enemy_id]
			entities_count_dict[enemy_id] = current_count + count
		else:
			entities_count_dict[enemy_id] = count
			
		return self
		
	func build() -> EnemyWave:
		return EnemyWave.new(entities_count_dict)
