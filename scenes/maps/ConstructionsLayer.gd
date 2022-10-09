extends TileMap
class_name ConstructionsLayer

var _constructions_dict: Dictionary = {}

func place_tower(tower: Tower, pos: Vector2):
	_constructions_dict[tower] = pos
	tower.position = pos
	add_child(tower)


func remove_tower_at(pos: Vector2):
	var tower = _constructions_dict[pos]
	if (tower):
		_constructions_dict.erase(pos)
		remove_child(tower)
		
		
func remove_tower(tower: Tower):
	remove_child(tower)
