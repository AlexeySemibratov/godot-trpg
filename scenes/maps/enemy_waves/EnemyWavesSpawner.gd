class_name EnemyWaveSpawner
extends Node2D

signal on_enemy_spawned(enemy)
signal on_enemies_left_count_changed(value: int)

var current_wave: int = -1
var enemies_left: int = -1

var _waves: Array[EnemyWave] = []

@onready var waves_delay_timer: Timer = %WavesDelayTimer

func start(waves: Array[EnemyWave]):
	_waves = waves
	_setup_enemies_left_value()
	_start_next_wave()
	print("Waves count is %d " % waves.size())


func _setup_enemies_left_value():
	var total_enemies_count = 0
	for wave in _waves:
		total_enemies_count += wave.get_total_enemy_count()
		
	enemies_left = total_enemies_count


func _start_next_wave():
	var next_wave = current_wave + 1
	if (next_wave < _waves.size()):
		waves_delay_timer.start()
		current_wave = next_wave
		
		var wave: EnemyWave = _waves[current_wave] 
		var enemies_in_wave = wave.get_total_enemy_count() 
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
		var delay = randf_range(1.5, 2.5)
		print("Spawn enemy %s, and delay for %f: " % [enemy_id, delay])
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
	on_enemies_left_count_changed.emit(enemies_left)


func _on_waves_delay_timer_timeout():
	_start_next_wave()
