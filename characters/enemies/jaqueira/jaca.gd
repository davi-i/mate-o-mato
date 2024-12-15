extends Node2D

var y
var velocity
var hit = false :
	set(new_value):
		hit = new_value
		if hit:
			$Turnable/Sprite2D.region_rect.position.x = 20
			$KillTimer.start()
			$Turnable/Area2D/CollisionShape2D.disabled = true

func _physics_process(delta: float) -> void:
	if not hit:
		velocity += $Turnable/Area2D.gravity * $Turnable/Area2D.gravity_direction * delta
		position += velocity * delta
	if global_position.y >= y:
		hit = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("players"):
		hit = true
		var old_pos = global_position
		get_parent().remove_child(self)
		area.find_parent("Player").add_child(self)
		global_position = old_pos


func _on_kill_timer_timeout() -> void:
	queue_free()
