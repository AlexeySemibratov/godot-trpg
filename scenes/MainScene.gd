extends Node2D

onready var map = $GameMap
onready var shop = $UILayer/IngameUi/ShopList
onready var ui = $UILayer

var build_mode_enabled = false
var tower_to_build
var can_build_here = false
var build_location
var tile_v_at_build_location
var build_type

const TILE_EMPTY_ID = 0

var tower_builder: TowerBuilder

func _ready():
	tower_builder = TowerBuilder.new()
	tower_builder.setup(map.get_node("DecorationLevel"), ui)
	add_child(tower_builder)
	shop.add_towers(TowerEntityManager.TOWERS_DICT)
	shop.connect("on_button_clicked", tower_builder, "setup_build_mode")

