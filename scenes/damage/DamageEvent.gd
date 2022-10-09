class_name DamageEvent
extends Node

var source
var damage: Damage
	
func _on_damage(target: EnemyBase):
	target.take_damage(damage.amount)
	if (source && source is Tower):
		Events.emit_signal("on_tower_hit_enemy", [source, target])
