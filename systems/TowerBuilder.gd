extends Node2D
class_name TowerBuilder

signal on_build_mode_enabled(tower_to_build)

var map: TileMap
var grid: TileMap
var ui: CanvasLayer

var build_mode_enabled = false
var tower_to_build
var can_build_here = false
var build_location
var tile_v_at_build_location
var build_type

const TILE_EMPTY_ID = -1
const TILE_TOWER_ID = 0

const TILE_ID_AVAILABLE = 0
const TILE_ID_BLOCK = 1

func setup(_map: TileMap, _grid: TileMap, _ui: CanvasLayer):
	map = _map
	grid = _grid
	ui = _ui

func _process(delta):
	if (build_mode_enabled):
		update_build_preview()
		
func _input(event):
	if(event.is_action_pressed("ui_accept")):
		build_if_can()
	if(event.is_action_pressed("ui_cancel")):
		cancel_build_mode()
	
func setup_build_mode(tower):
	print("setup build mode")
	if (build_mode_enabled):
		cancel_build_mode()
		
	grid.visible = true
		
	var tower_node = tower["node"]
	build_mode_enabled = true
	tower_to_build = tower_node
	ui.set_tower_preview(tower_node, get_global_mouse_position())
	
func update_build_preview():
	var mouse_pos = get_global_mouse_position()
	
	var tile = grid.world_to_map(mouse_pos)
	var tile_pos = grid.map_to_world(tile)
	var tile_id = grid.get_cellv(tile)
	
	if tile_id == TILE_ID_AVAILABLE:
		can_build_here = true
		build_location = tile_pos
	else:
		can_build_here = false
		build_location = null
	ui.update_tower_preview(tile_pos, can_build_here)

func cancel_build_mode():
	if (build_mode_enabled):
		grid.visible = false
		build_mode_enabled = false
		can_build_here = false
		ui.remove_preview()

func build_if_can():
	if (build_mode_enabled and can_build_here):
		var tower = load(tower_to_build).instance()
		map.add_child(tower, true)
		tower.position = build_location
		var tile_coord = map.world_to_map(build_location)
		
		grid.set_cellv(tile_coord, TILE_ID_BLOCK)
		
		cancel_build_mode()
