class_name MainGame
extends Node2D

const BASE_HP = 5

var map: GameMap

var tower_builder: TowerBuilder

@onready var shop: TowersShop = $Camera2d/UILayer/IngameUi/ShopList
@onready var ui: CanvasLayer = %UILayer
@onready var main_ui: MainUI= %IngameUi
@onready var base_ui = $Camera2d/UILayer/IngameUi/Base

func _ready():
	_setup_map_level()
	_setup_main_ui()
	_setup_base_ui()
	_setup_tower_bulder()
	_setup_shop()
	
	
func _setup_map_level():
	var level_type: Levels.LevelType = SceneNavigator.arguments[SceneNavigator.ARG_LEVEL_TYPE]
	_setup_level(level_type)
	
	
func _setup_level(level_type: Levels.LevelType):
	if (map and map.get_parent()):
		remove_child(map)
		
	var level_scene = load(Levels.get_level_scene(level_type))
	var level_map_instance: GameMap = level_scene.instantiate()
	
	map = level_map_instance
	map.level_completed.connect(self._level_completed)
	map.level_failed.connect(self._level_failed)
	
	add_child(map)
	
	
func _level_completed(level_data: LevelData):
	main_ui.show_level_completed_dialog(level_data)
	
	
func _level_failed(level_data: LevelData):
	main_ui.show_level_failed_dialog(level_data)
	
	
func _setup_tower_bulder():
	tower_builder = TowerBuilder.new()
	tower_builder.setup(map.constructions, map.building_grid, ui)
	tower_builder.on_tower_builded.connect(self._on_tower_builded)
	tower_builder.on_tower_sold.connect(self._on_tower_sold)
	add_child(tower_builder)
	
	
func _setup_main_ui():
	main_ui.level_completed_dialog_ok_pressed.connect(self._open_next_level_or_back_to_menu)
	
	
func _open_next_level_or_back_to_menu():
	var next_level = map.level_data.next_level
	if (next_level != Levels.LevelType.NONE):
		SceneNavigator.open_game_scene(next_level)
	else:
		SceneNavigator.open_main_menu()
	
	
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

