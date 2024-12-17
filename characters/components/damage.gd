@tool
extends Area2D
class_name Damage

var total_damage = 0

@export var cooldown_time = 0.2 :
	set(new_time):
		cooldown_time = new_time
		$Cooldown.wait_time = new_time
@export var falldown_time = 1 :
	set(new_time):
		falldown_time = new_time
		$FallDown.wait_time = new_time
@export var get_up_time = 1 :
	set(new_time):
		get_up_time = new_time
		$GetUp.wait_time = new_time
@export var falldown_cancel_time = 1 :
	set(new_time):
		falldown_cancel_time = new_time
		$FallDownCancel.wait_time = new_time
@export var damage_to_fall_down = Global.DAMAGE_TO_FALL_DOWN
@export var damage_group: StringName

signal damage_taken(damage: float, area: Area2D)
signal fall_down
signal start_get_up
signal get_up
signal cooldown_end

func on_cooldown() -> bool:
	return not $Cooldown.is_stopped() or not $FallDown.is_stopped() or not $GetUp.is_stopped()

func _on_fall_down_cancel_timeout() -> void:
	total_damage = 0

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group(damage_group) and not on_cooldown():
		if not area.has_method("attack_damage"):
			push_error("no attack damage on area")
			return
		$FallDownCancel.start()
		var damage = area.attack_damage()
		total_damage += damage
		damage_taken.emit(damage, area)
		if total_damage >= damage_to_fall_down:
			$FallDown.start()
			fall_down.emit()
		else:
			$Cooldown.start()

func _on_fall_down_timeout() -> void:
	start_get_up.emit()
	$GetUp.start()

func _on_get_up_timeout() -> void:
	get_up.emit()
	cooldown_end.emit()

func _on_cooldown_timeout() -> void:
	cooldown_end.emit()
