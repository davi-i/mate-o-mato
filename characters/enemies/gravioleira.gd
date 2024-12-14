extends Enemy

@onready var sprite = $Turnable/AnimatedSprite2D
@onready var attack_node = $Turnable/Attack
@onready var damage = $Turnable/Damage

func _ready() -> void:
	$Blackboard.set_value("player", player)
	$Blackboard.set_value("speed", 200)

func turn(direction) -> void:
	$Turnable.scale = Vector2(direction, 1)

func _process(delta: float) -> void:
	if not is_acting():
		if velocity != Vector2.ZERO:
			sprite.play("walk")
		else:
			sprite.play("idle")
	
func attack() -> void:
	if damage.get_node("Cooldown").is_stopped() and not is_attacking():
		print("enemy attack")
		$Turnable/Attack/PunchCollision.disabled = false
		sprite.play("left_punch")
		
func is_acting():
	return not attack_node.get_node("Delay").is_stopped() or sprite.animation not in ["idle", "walk"]

func is_attacking():
	return not attack_node.get_node("Delay").is_stopped() or sprite.animation in ["left_punch", "right_punch", "upper_cut"]

func direction():
	return $Turnable.scale.x

func cancel_attack():
	print("cancel attack")
	$Turnable/Attack/PunchCollision.set_deferred("disabled", true)
	sprite.play("idle")


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "left_punch":
		sprite.play("right_punch")
	elif sprite.animation == "right_punch":
		cancel_attack()

var total_damage = 0

func _on_damage_area_entered(area: Area2D) -> void:
	if area.is_in_group("players"):
		print("damage enemy")
		cancel_attack()
		damage.get_node("FallDown").start(0)
		var damage_taken = area.attack_damage()
		total_damage += damage_taken
		$Blackboard.set_value("damage", true)
		if total_damage >= Global.DAMAGE_TO_FALL_DOWN:
			$Blackboard.set_value("fall_down", true)
		var direction = area.find_parent("Turnable").scale.x


func _on_fall_down_timeout() -> void:
	total_damage = 0
