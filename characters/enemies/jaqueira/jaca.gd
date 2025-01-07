extends Node2D

var y
var velocity
var hit = false :
	set(new_value):
		hit = new_value
		if hit:
			$Turnable/Sprite2D.region_rect.position.x = 20
			print("start timer")
			$KillTimer.start()
			$Turnable/Area2D/CollisionShape2D.set_deferred("disabled", true)

func _physics_process(delta: float) -> void:
	var disabled = true
	if not hit:
		velocity += $Turnable/Area2D.gravity * $Turnable/Area2D.gravity_direction * delta
		position += velocity * delta
		if velocity.y > 0:
			disabled = false
		if global_position.y >= y:
			hit = true
	$Turnable/Area2D/CollisionShape2D.disabled = disabled


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("players"):
		queue_free()


func _on_kill_timer_timeout() -> void:
	print( "kill timer end")
	queue_free()
