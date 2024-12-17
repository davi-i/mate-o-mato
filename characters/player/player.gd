extends CharacterBody2D
class_name Player


const SPEED = 60.0
const JUMP_VELOCITY = -80.0

@onready var sprite = $Turnable/AnimatedSprite2D
@onready var attack = $Turnable/Attack
@onready var damage = $Turnable/Damage

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if can_walk():
		var direction_x := Input.get_axis("move_left", "move_right")
		var direction_y := Input.get_axis("move_up", "move_down")
		if direction_x:
			velocity.x = direction_x * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if direction_y:
			velocity.y = direction_y * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
	elif sprite.animation == "fall_down":
		velocity.x += -sign(velocity.x) * 0.3
	
	move_and_slide()

func _process(delta: float) -> void:
	if can_walk():
		if velocity.x < 0:
			$Turnable.scale = Vector2(-1, 1)
		elif velocity.x > 0:
			$Turnable.scale = Vector2(1, 1)

		if velocity != Vector2.ZERO:
			sprite.play("walk")
		else:
			sprite.play("idle")

func can_walk() -> bool:
	return not attack.is_attacking() and not damage.on_cooldown()

func can_attack() -> bool:
	return not attack.is_attacking() and not damage.on_cooldown()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack") and can_attack() and await attack.attack():
		velocity.x = 0

func direction():
	return $Turnable.scale.x

var base_attack = 1

func attack_damage():
	return attack.attack_damage()

func _on_damage_damage_taken(damage: float, area) -> void:
	print("damage player")
	attack.cancel_attack()
	var direction = sign(area.find_parent("Turnable").scale.x)
	velocity.y = 0
	velocity.x = direction * 50
	sprite.play("knockback")

func _on_damage_cooldown_end() -> void:
	print("damage cooldown end")
	velocity.x = 0
	sprite.play("idle")

func _on_damage_fall_down() -> void:
	print("fall down")
	sprite.play("fall_down")
	
func _on_damage_start_get_up() -> void:
	print("start get up")
	velocity.x = 0
	sprite.play("get_up")

func _on_damage_get_up() -> void:
	print("get up")
	sprite.play("idle")
