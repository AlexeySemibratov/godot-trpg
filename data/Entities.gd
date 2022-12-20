extends Node

var towers: Towers = Towers.new()
var enemies: Enemies = Enemies.new()

class Towers:
	
	const COMMON_GUN_TOWER = "tower.common_tower"
	const ROCKET_TOWER = "tower.rocket_tower"
	const FLAMETHROWER_TOWER = "tower.flamethrower_tower"
	
	const KEY_SCENE = "key.scene"
	const KEY_TOWER_DATA = "key.tower_data"
	
	var _towers_dict = {
		COMMON_GUN_TOWER: {
			KEY_SCENE: "res://scenes/entity/tower/common_tower/TowerGunCommon.tscn",
			KEY_TOWER_DATA: "res://data/towers/CommonTowerData.tres"
			},
		ROCKET_TOWER: {
			KEY_SCENE: "res://scenes/entity/tower/rocket_tower/TowerRocketCommon.tscn",
			KEY_TOWER_DATA: "res://data/towers/RocketTowerData.tres"
			},
		FLAMETHROWER_TOWER: {
			KEY_SCENE: "res://scenes/entity/tower/flamethrower_tower/FlameTower.tscn",
			KEY_TOWER_DATA: "res://data/towers/FlamethrowerTowerData.tres"
			}
	}
	
	func get_all() -> Dictionary:
		return _towers_dict
	
	
	func get_scene_path_by_id(id: String) -> String:
		return _towers_dict[id]
		
	
	func load_tower_data(id: String) -> TowerData:
		return load(_towers_dict[id][KEY_TOWER_DATA])
	
	
class Enemies:
	
	const LIGHT_TANK = "enemy.light_tank"
	const HEAVY_TANK = "enemy.heavy_tank"

	var _enemies_dict = {
		LIGHT_TANK: "res://scenes/entity/enemy/specials/light/LightTank.tscn",
		HEAVY_TANK: "res://scenes/entity/enemy/specials/heavy/HeavyTank.tscn"
	}

	func get_scene_path_by_id(id: String) -> String:
		return _enemies_dict[id]
	
