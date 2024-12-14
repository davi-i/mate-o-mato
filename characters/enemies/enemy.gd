extends CharacterBody2D
class_name Enemy

@export var player: Player

func attack() -> void:
	pass

func is_attacking() -> bool:
	return false

func direction() -> float:
	return 0

func turn(direction: float) -> void:
	pass
