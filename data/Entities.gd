extends Node

var enemies: Enemies = Enemies.new()

class Enemies:
	
	const LIGHT_TANK = "enemy.light_tank"
	const HEAVY_TANK = "enemy.heavy_tank"

	var _enemies_dict = {
		LIGHT_TANK: "res://scenes/entity/enemy/specials/light/LightTank.tscn",
		HEAVY_TANK: "res://scenes/entity/enemy/specials/heavy/HeavyTank.tscn"
	}

	func get_scene_path_by_id(id: String) -> String:
		return _enemies_dict[id]
	
