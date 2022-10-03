extends Node2D

@onready var map = $GameMap
@onready var shop = $Camera2d/UILayer/IngameUi/ShopList
@onready var ui = %UILayer
@onready var base_ui = $Camera2d/UILayer/IngameUi/Base

var build_mode_enabled = false
var tower_to_build
var can_build_here = false
var build_location
var tile_v_at_build_location
var build_type

const BASE_HP = 10

var tower_builder: TowerBuilder

func _ready():
	_setup_base_ui()
	tower_builder = TowerBuilder.new()
	tower_builder.setup(map.constructions, map.building_grid, ui)
	add_child(tower_builder)
	shop.add_towers(TowerEntityManager.TOWERS_DICT)
	shop.connect("on_button_clicked",Callable(tower_builder,"setup_build_mode"))
	
func _setup_base_ui():
	map.base.connect("on_base_hp_changed",Callable(self,"_update_base_ui"))
	map.base.setup(BASE_HP)
	
func _update_base_ui(value):
	base_ui.update_value(value)

