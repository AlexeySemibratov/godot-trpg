extends TextureRect

var tower_node_path = "res://scenes/entity/TowerEntity.tscn"

func set_tower_node_path(path):
	self.tower_node_path = path
	
func get_tower_node_path():
	return self.tower_node_path
