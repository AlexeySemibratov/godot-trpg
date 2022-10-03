extends CanvasLayer


var Valid_Build_Color = Color.html("#2B985E9F")
var Invalid_Build_Color = Color.html("#DB3131CC")

var preview_control

func set_tower_preview(tower_name, position):
	var tower_prev = load(tower_name).instantiate()
	tower_prev.deactivate()
	tower_prev.set_name("TowerPreview")
	tower_prev.modulate = Valid_Build_Color
	var control = Control.new()
	control.add_child(tower_prev, true)
	control.position = position
	control.name = "TowerPreviewControl"
	add_child(control, true)
	
	preview_control = control
	
func update_tower_preview(position, can_build):
	var modualte_color = Valid_Build_Color if (can_build) else Invalid_Build_Color
	var tower_prev = preview_control.get_node("TowerPreview")
	if not (tower_prev.modulate == modualte_color):
		tower_prev.modulate = modualte_color
	preview_control.position = position
	
func remove_preview():
	preview_control.queue_free()
