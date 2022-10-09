class_name Damage
extends Node

enum Type {
	PHYSICAL,
	OTHER
}

var base_amount := 0
var multiplier := 1.0
var type = Type.PHYSICAL
var total_amount: int = base_amount * multiplier
