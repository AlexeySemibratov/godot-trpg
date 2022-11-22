class_name EnemyWaveSpawner
extends Node2D

signal on_enemy_spawned(enemy)
signal on_enemis_left_count_changed(value)

var waves_count = [5, 7, 10]

var current_wave: int = -1
var enemies_left = 0

var enemy_scene = preload("res://scenes/entity/enemy/specials/light/LightTank.tscn")

@onready var waves_delay_timer: Timer = %WavesDelayTimer

func start():
	_start_next_wave()
	waves_delay_timer.start()


func _start_next_wave():
	var next_wave = current_wave + 1
	if (next_wave < waves_count.size()):
		current_wave = next_wave
		
		var enemies_in_wave = waves_count[next_wave]
		enemies_left += enemies_in_wave
		_on_enemies_left_count_changed()
		_spawn_wave(enemies_in_wave)
			
			
func _spawn_wave(enemies_in_wave: int):
	for i in range(enemies_in_wave):
			_spawn_enemy()
			var delay = randf_range(0.75, 1.75)
			await get_tree().create_timer(delay).timeout
			
			
func _spawn_enemy():
	var enemy: EnemyBase = enemy_scene.instantiate()
	enemy.tree_exited.connect(self._on_enemy_exit_tree)
	emit_signal("on_enemy_spawned", enemy)

	
func _on_enemy_exit_tree():
	enemies_left -= 1
	_on_enemies_left_count_changed()
	
	
func _on_enemies_left_count_changed():
	print("Enemies left: " + str(enemies_left))
	emit_signal("on_enemis_left_count_changed", enemies_left)


func _on_waves_delay_timer_timeout():
	_start_next_wave()
