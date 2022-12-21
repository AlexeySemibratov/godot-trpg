extends Node2D
class_name TowerBuilder

signal on_build_mode_enabled(tower_to_build)
signal on_build_mode_disabled
signal on_build_mode_active(tower_position, can_build_at_position)
signal on_tower_builded(tower)
signal on_tower_sold(tower)

var map: ConstructionsLayer
var grid: TileMap

var build_mode_enabled := false
var selected_tower_scene: String
var can_build_here := false
var build_location: Vector2 = Vector2.ZERO

const TILE_EMPTY_ID = -1
const TILE_TOWER_ID = 0

const TILE_ID_AVAILABLE = 0
const TILE_ID_BLOCK = 1

const TILES_ID = 0
const ATLAS_COORDS_BLOCK = Vector2i(1, 0)
const ATLAS_COORDS_AVAILABLE = Vector2i(0, 0)

const GRID_CELL_SIZE = 64

func setup(_map: ConstructionsLayer, _grid: TileMap):
	map = _map
	grid = _grid


func _process(delta):
	if (build_mode_enabled):
		_update_build_preview()
	
		
func _input(event):
	if(event.is_action_pressed("ui_accept")):
		build_if_can()
	if(event.is_action_pressed("ui_cancel")):
		cancel_build_mode()
	
	
func setup_build_mode(tower_scene):
	if (build_mode_enabled):
		cancel_build_mode()
		
	grid.visible = true
		
	build_mode_enabled = true
	selected_tower_scene = tower_scene
	on_build_mode_enabled.emit(load(tower_scene).instantiate())

	
func _update_build_preview():
	var mouse_pos = grid.get_global_mouse_position()
	
	var tile = grid.local_to_map(mouse_pos)
	var tile_pos = grid.map_to_local(tile)
	var tile_atlas = grid.get_cell_atlas_coords(0, tile)
	
	can_build_here = tile_atlas == ATLAS_COORDS_AVAILABLE
	build_location = tile_pos if (can_build_here) else Vector2.ZERO
	
	var preview_pos = shift_to_half_cell_size(get_viewport().get_mouse_position())
	on_build_mode_active.emit(preview_pos, can_build_here)
	
	
func shift_to_half_cell_size(value: Vector2): 
	return value - Vector2(GRID_CELL_SIZE / 2, GRID_CELL_SIZE / 2)


func cancel_build_mode():
	if (build_mode_enabled):
		grid.visible = false
		build_mode_enabled = false
		can_build_here = false
		on_build_mode_disabled.emit()


func build_if_can():
	if (build_mode_enabled and can_build_here):
		_place_tower(load(selected_tower_scene).instantiate())
		cancel_build_mode()
	
		
func _place_tower(tower: Tower):
	var coords = shift_to_half_cell_size(build_location)
	tower.on_sold.connect(self._remove_tower)
	map.place_tower(tower, coords)
	on_tower_builded.emit(tower)
	var tile_coord = grid.local_to_map(build_location)
	grid.set_cell(0, tile_coord, TILES_ID, ATLAS_COORDS_BLOCK)
	
	
func _remove_tower(tower: Tower):
	map.remove_tower(tower)
	var tile_coord = grid.local_to_map(tower.position)
	grid.set_cell(0, tile_coord, TILES_ID, ATLAS_COORDS_AVAILABLE)
	on_tower_sold.emit(tower)
	tower.queue_free()
