extends Area2D

@export var sprite: AnimatedSprite2D

var combo = 0

func attack():
	if !is_attacking():
		$ComboTimer.start()
		
		if combo % 3 == 0:
			$PunchCollision.disabled = false
			sprite.play("left_punch")
		elif combo % 3 == 1:
			$PunchCollision.disabled = false
			sprite.play("right_punch")
		elif  combo % 3 == 2:
			$UpperCutCollision.disabled = false
			sprite.play("upper_cut")
		await get_tree().physics_frame
		await get_tree().physics_frame
		if has_overlapping_areas():
			combo += 1
		else:
			combo = 0
		return true
	return false

func is_attacking():
	return sprite.animation in ["left_punch", "right_punch", "upper_cut"]

func _on_combo_timer_timeout() -> void:
	combo = 0

func cancel_attack():
	if is_attacking():
		$UpperCutCollision.disabled = true
		$PunchCollision.disabled = true
		sprite.play("idle")

func _on_animated_sprite_2d_animation_finished() -> void:
	cancel_attack()

var base_attack = 1

func attack_damage():
	if combo % 3 < 2:
		return base_attack;
	else:
		return base_attack * 3; 
