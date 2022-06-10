extends CanvasLayer

const Valid_Build_Color = Color("9f2b985e")
const Invalid_Build_Color = Color("ccdb3131")

var preview_control

func set_tower_preview(tower_name, position):
	var tower_prev = load(tower_name).instance()
	tower_prev.set_name("TowerPreview")
	tower_prev.modulate = Valid_Build_Color
	
	var control = Control.new()
	control.add_child(tower_prev, true)
	control.rect_position = position
	control.name = "TowerPreviewControl"
	add_child(control, true)
	
	preview_control = control
	
func update_tower_preview(position, can_build):
	var modualte_color = Valid_Build_Color if (can_build) else Invalid_Build_Color
	var tower_prev = preview_control.get_node("TowerPreview")
	if not (tower_prev.modulate == modualte_color):
		tower_prev.modulate = modualte_color
	preview_control.rect_position = position
	
func remove_preview():
	preview_control.queue_free()
