extends Enemy

@onready var sprite = $Turnable/AnimatedSprite2D

func _ready() -> void:
	$Blackboard.set_value("player", player)
	$Blackboard.set_value("speed", 200)
	$Blackboard.set_value("distance_to_player", 800)

func turn(direction) -> void:
	$Turnable.scale = Vector2(direction, 1)

func _process(delta: float) -> void:
	if not is_attacking() :
		if velocity != Vector2.ZERO:
			sprite.play("walk")
		else:
			sprite.play("idle")
	
func attack() -> void:
	if not is_attacking():
		sprite.play("left_punch")

func is_attacking():
	return sprite.animation in ["left_punch", "right_punch", "upper_cut"]


func direction():
	return $Turnable.scale.x

func cancel_attack():
	sprite.play("idle")

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "left_punch":
		sprite.play("right_punch")
	elif sprite.animation == "right_punch":
		cancel_attack()
