class_name GameMap
extends Node2D

@export var base_hp = 10
@export var enemy_path_node: NodePath

@onready var enemy_path: Path2D = get_node(enemy_path_node)
@onready var ground = $GroundLevel
@onready var constructions = $ConstructionsLayer
@onready var building_grid = $BuildingGrid
@onready var base = $BaseArea
@onready var enemy_waves_spawner: EnemyWaveSpawner = %EnemyWavesSpawner


func _ready():
	_setup_base_area()
	_setup_enemy_waves_spawner()
	

func _setup_base_area():
	base.body_entered.connect(self._on_body_enter_base)
	
	
func _setup_enemy_waves_spawner():
	enemy_waves_spawner.on_enemy_spawned.connect(enemy_path.add_child)
	enemy_waves_spawner.start()
	
		
func _on_body_enter_base(body):
	if (body.owner is EnemyBase):
		body.owner.queue_free()
		base.damage_base(1)
