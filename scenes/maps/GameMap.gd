extends Node2D

@export var base_hp = 10

@onready var path: Path2D = $Path2D
@onready var ground = $GroundLevel
@onready var road = $RoadLevel
@onready var constructions = $ConstructionsLayer
@onready var building_grid = $BuildingGrid
@onready var base = $BaseArea

@onready var wave_delay = $WaveDelayTimer
const WAVE_DELAY = 10

var current_wave = -1
var waves_count = [5, 6, 8]

var enemy_scene = preload("res://scenes/entity/enemy/specials/light/LightTank.tscn")

func _init():
	add_to_group(Groups.GAME_MAP)

func _ready():
	base.connect("body_entered",Callable(self,"on_body_enter_base"))
	wave_delay.start()
		
func on_body_enter_base(body):
	if (body.owner is EnemyBase):
		body.owner.queue_free()
		base.damage_base(1)

func _on_WaveDelayTimer_timeout():
	_start_next_wave()
	wave_delay.wait_time = WAVE_DELAY
	wave_delay.start()
	
func _start_next_wave():
	var next_wave = current_wave + 1
	if (next_wave < waves_count.size()):
		current_wave = next_wave
		var enemies_in_wave = waves_count[next_wave]
		for i in range(enemies_in_wave):
			var enemy = enemy_scene.instantiate()
			path.add_child(enemy)
			var delay = randf_range(0.5, 1.0)
			await get_tree().create_timer(delay).timeout
