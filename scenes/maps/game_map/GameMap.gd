class_name GameMap
extends Node2D

signal level_completed(level_data: LevelData)
signal level_failed(level_data: LevelData)

@export var enemy_path_node: NodePath
@export var level_data_node: NodePath

@onready var enemy_path: Path2D = get_node(enemy_path_node)
@onready var ground = $GroundLevel
@onready var constructions = $ConstructionsLayer
@onready var building_grid = $BuildingGrid
@onready var base: BaseArea = $BaseArea
@onready var enemy_waves_spawner: EnemyWaveSpawner = %EnemyWavesSpawner

@onready var level_data: LevelData = get_node(level_data_node)


func _ready():
	_setup_base_area()
	_setup_enemy_waves_spawner()
	

func _setup_base_area():
	base.body_entered.connect(self._on_body_enter_base)
	base.on_base_destroyed.connect(self._on_base_destroyed)
	
	
func _setup_enemy_waves_spawner():
	enemy_waves_spawner.on_enemy_spawned.connect(enemy_path.add_child)
	enemy_waves_spawner.on_enemies_left_count_changed.connect(self._on_enemies_left_count_changed)
	enemy_waves_spawner.start(level_data.get_enemy_waves())
	
		
func _on_body_enter_base(body):
	if (body.owner is EnemyBase):
		body.owner.queue_free()
		base.damage_base(1)
		
		
func _on_enemies_left_count_changed(count: int):
	if (count == 0 && not base.is_destroyed()): 
		level_completed.emit(level_data)
		
		
func _on_base_destroyed():
	level_failed.emit(level_data)
