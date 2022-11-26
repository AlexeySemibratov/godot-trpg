extends Node

var towers: Towers = Towers.new()
var enemies: Enemies = Enemies.new()

class Towers:
	const COMMON_GUN_TOWER = "tower.common_tower"
	const ROCKET_TOWER = "tower.rocket_tower"
	const FLAMETHROWER_TOWER = "tower.flamethrower_tower"
	
	var _towers_dict = {
		COMMON_GUN_TOWER: "res://scenes/entity/tower/common_tower/TowerGunCommon.tscn",
		ROCKET_TOWER: "res://scenes/entity/tower/rocket_tower/TowerRocketCommon.tscn",
		FLAMETHROWER_TOWER: "res://scenes/entity/tower/flamethrower_tower/FlameTower.tscn"
	}
	
	func get_all() -> Dictionary:
		return _towers_dict
	
	func get_scene_path_by_id(id: String) -> String:
		return _towers_dict[id]
	
	
class Enemies:
	
	const LIGHT_TANK = "enemy.light_tank"
	const HEAVY_TANK = "enemy.heavy_tank"

	var _enemies_dict = {
		LIGHT_TANK: "res://scenes/entity/enemy/specials/light/LightTank.tscn",
		HEAVY_TANK: "res://scenes/entity/enemy/specials/heavy/HeavyTank.tscn"
	}

	func get_scene_path_by_id(id: String) -> String:
		return _enemies_dict[id]
	
