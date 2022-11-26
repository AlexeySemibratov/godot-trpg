extends Node2D

var map: GameMap

@onready var shop: TowersShop = $Camera2d/UILayer/IngameUi/ShopList
@onready var ui = %UILayer
@onready var base_ui = $Camera2d/UILayer/IngameUi/Base


const BASE_HP = 10

var tower_builder: TowerBuilder

func _ready():
	_setup_map_level()
	_setup_base_ui()
	_setup_tower_bulder()
	_setup_shop()
	
	
func _setup_map_level():
	var level_type: Levels.LevelType = SceneNavigator.arguments[SceneNavigator.ARG_LEVEL_TYPE]
	var level_scene = load(Levels.get_level_scene(level_type))
	var level_map_instance = level_scene.instantiate()
	map = level_map_instance
	add_child(map)
	
	
func _setup_tower_bulder():
	tower_builder = TowerBuilder.new()
	tower_builder.setup(map.constructions, map.building_grid, ui)
	tower_builder.on_tower_builded.connect(self._on_tower_builded)
	tower_builder.on_tower_sold.connect(self._on_tower_sold)
	add_child(tower_builder)
	
	
func _setup_base_ui():
	map.base.on_base_hp_changed.connect(self._update_base_ui)
	map.base.setup(BASE_HP)
	
	
func _setup_shop():
	shop.add_towers(Entities.towers.get_all())
	shop.on_button_clicked.connect(tower_builder.setup_build_mode)
	Events.on_enemy_destroyed_by.connect(self._on_enemy_destroyed)
	
	
func _on_tower_builded(tower: Tower):
	shop.decrease_fuel(tower.build_cost)
	
	
func _on_tower_sold(tower: Tower):
	shop.add_fuel(tower.sold_cost)


func _on_enemy_destroyed(tower: Tower, enemy: EnemyBase):
	shop.add_fuel(enemy.reward_fuel)
	
	
func _update_base_ui(value):
	base_ui.update_value(value)

