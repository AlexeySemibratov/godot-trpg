class_name EnemyWaveSpawner
extends Node2D

signal on_enemy_spawned(enemy)
signal on_enemies_left_count_changed(value)

var waves: Array[EnemyWave] = [
	EnemyWave.Builder.new()
		.add_enemy(Entities.enemies.LIGHT_TANK, 4)
		.build(),
	EnemyWave.Builder.new()
		.add_enemy(Entities.enemies.LIGHT_TANK, 4)
		.add_enemy(Entities.enemies.HEAVY_TANK, 2)
		.build(),
	EnemyWave.Builder.new()
		.add_enemy(Entities.enemies.HEAVY_TANK, 6)
		.build()
]

var current_wave: int = -1
var enemies_left = 0


@onready var waves_delay_timer: Timer = %WavesDelayTimer

func start():
	_start_next_wave()
	print("Waves count is %d " % waves.size())


func _start_next_wave():
	var next_wave = current_wave + 1
	if (next_wave < waves.size()):
		waves_delay_timer.start()
		current_wave = next_wave
		
		var wave: EnemyWave = waves[current_wave] 
		var enemies_in_wave = wave.get_total_enemy_count() 
		enemies_left += enemies_in_wave
		_on_enemies_left_count_changed()
		print("Spawn wave: " + str(current_wave))
		_spawn_wave(wave)
			
			
func _spawn_wave(wave: EnemyWave):
	for enemy_id in wave.entities_and_count_dict.keys():
			var times = wave.entities_and_count_dict[enemy_id]
			print("Spawn enemy %s, times %d: " % [enemy_id, times])
			_spawn_enemy(enemy_id, times)
			
	
func _spawn_enemy(enemy_id: String, times: int):
	for i in range(times):
		_spawn_single_enemy(enemy_id)
		var delay = randf_range(1, 1.75)
		await get_tree().create_timer(delay).timeout	
		
		
func _spawn_single_enemy(enemy_id: String):
	var enemy_scene = load(Entities.enemies.get_scene_path_by_id(enemy_id))
	var enemy: EnemyBase = enemy_scene.instantiate()
	enemy.tree_exited.connect(self._on_enemy_exit_tree)
	emit_signal("on_enemy_spawned", enemy)
	
	
func _on_enemy_exit_tree():
	enemies_left -= 1
	_on_enemies_left_count_changed()
	
	
func _on_enemies_left_count_changed():
	## print("Enemies left: " + str(enemies_left))
	emit_signal("on_enemies_left_count_changed", enemies_left)


func _on_waves_delay_timer_timeout():
	_start_next_wave()
