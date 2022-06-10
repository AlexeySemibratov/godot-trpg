extends Node2D

onready var map = $GameMap

var build_mode_enabled = false
var tower_to_build
var can_build_here = false
var build_location
var tile_v_at_build_location
var build_type

const TILE_EMPTY_ID = 0

func _ready():
	for button in get_tree().get_nodes_in_group("BuildButtonsGroup"):
		var button_texture = button.get_node("BuildButton")
		button_texture.connect("pressed", self, "setup_build_mode", [button.get_tower_node_path()])
	
func _process(delta):
	if (build_mode_enabled):
		update_build_preview()
	
func _unhandled_input(event):
	if event.is_action_released("ui_cancel"):
		cancel_build_mode()
	if event.is_action_released("ui_accept"):
		build_if_can()
		cancel_build_mode()
	
func setup_build_mode(tower_node):
	if (build_mode_enabled):
		cancel_build_mode()
		
	print("button pressed")
	build_mode_enabled = true
	tower_to_build = tower_node
	get_node("UILayer").set_tower_preview(tower_node, get_global_mouse_position())
	
func update_build_preview():
	var mouse_pos = get_global_mouse_position()
	var tower_map = map.get_node("DecorationLevel")
	var current_tile = tower_map.world_to_map(mouse_pos)
	var tile_pos = tower_map.map_to_world(current_tile)
	
	var current_tile_at_map = tower_map.get_cellv(current_tile)
	if current_tile_at_map == -1:
		can_build_here = true
		build_location = tile_pos
	else:
		can_build_here = false
		build_location = null
	get_node("UILayer").update_tower_preview(tile_pos, can_build_here)

func cancel_build_mode():
	if (build_mode_enabled):
		build_mode_enabled = false
		can_build_here = false
		get_node("UILayer").remove_preview()

func build_if_can():
	if (build_mode_enabled and can_build_here):
		var tower_map = map.get_node("DecorationLevel")
		var tower = load(tower_to_build).instance()
		tower.position = build_location
		tower_map.add_child(tower, true)
		print("cellv loc " + str(build_location))
		var tile_coord = tower_map.world_to_map(build_location)
		print("cellv loc tile" + str(tile_coord))
		tower_map.set_cellv(tile_coord, TILE_EMPTY_ID)
	
