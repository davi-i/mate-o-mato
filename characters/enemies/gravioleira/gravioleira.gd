extends Enemy

@onready var sprite = $Turnable/AnimatedSprite2D
@onready var attack_node = $Turnable/Attack
@onready var damage = $Turnable/Damage

var health = 7

func _ready() -> void:
	$Blackboard.set_value("player", player)
	$Blackboard.set_value("speed", 80)

func turn(direction) -> void:
	$Turnable.scale = Vector2(direction, 1)

func _process(delta: float) -> void:
	if(health <= 0):
		queue_free()
	
	if not is_acting():
		if velocity != Vector2.ZERO:
			sprite.play("walk")
		else:
			sprite.play("idle")
	
func attack() -> void:
	if not damage.on_cooldown() and not is_attacking():
		sprite.play("left_punch")
		
func is_acting():
	return sprite.animation not in ["idle", "walk"]
	#var delay = attack_node.get_node("Delay")
	#return not (delay.is_stopped() or delay.paused) or sprite.animation not in ["idle", "walk"]

func is_attacking():
	var delay = attack_node.get_node("Delay")
	return not (delay.is_stopped() or delay.pause) or sprite.animation in ["left_punch", "right_punch", "upper_cut"]

func direction():
	return $Turnable.scale.x

func cancel_attack():
	$Turnable/Attack/PunchCollision.set_deferred("disabled", true)
	sprite.play("idle")


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "left_punch":
		sprite.play("right_punch")
		$Turnable/Attack/PunchCollision.disabled = false
	elif sprite.animation == "right_punch":
		cancel_attack()

func _on_damage_damage_taken(damage: float, area: Area2D) -> void:
	cancel_attack()
	health -= 1
	$Blackboard.set_value("damage", true)
	sprite.modulate = Global.ENEMY_DAMAGE_COLOR

func _on_damage_fall_down() -> void:
	$Blackboard.set_value("fall_down", true)
	sprite.play("fall_down")

func _on_damage_cooldown_end() -> void:
	sprite.modulate = Color.WHITE

func _on_damage_start_get_up() -> void:
	sprite.play("get_up")

func _on_damage_get_up() -> void:
	sprite.play("idle")

func _on_player_reach_area_entered(area: Area2D) -> void:
	sprite.play("idle")
