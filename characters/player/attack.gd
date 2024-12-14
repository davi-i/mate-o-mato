extends Node

var combo = 0

func attack():
	if $Timer.is_stopped():
		$ComboTimer.start()
		$Timer.start()
		combo += 1
		if combo == 1:
			$PunchCollision.disabled = false
		elif combo == 2:
			$PunchCollision.disabled = false
		elif  combo == 3:
			$UpperCutCollision.disabled = false
		return true
	return false
	


func _on_timer_timeout() -> void:
	$PunchCollision.disabled = true
	$UpperCutCollision.disabled = true


func _on_combo_timer_timeout() -> void:
	combo = 0
