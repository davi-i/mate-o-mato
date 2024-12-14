extends CharacterBody2D
class_name Player


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

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
	if not attack.is_attacking() and damage.get_node("Cooldown").is_stopped():
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
	
	move_and_slide()
	
func _process(delta: float) -> void:
	if not damage.get_node("Cooldown").is_stopped():
		return
	if velocity.x < 0:
		$Turnable.scale = Vector2(-1, 1)
	elif velocity.x > 0:
		$Turnable.scale = Vector2(1, 1)
	
	if not attack.is_attacking():
		if velocity != Vector2.ZERO:
			sprite.play("walk")
		else:
			sprite.play("idle")

func _input(event: InputEvent) -> void:
	if not damage.get_node("Cooldown").is_stopped():
		return
	if Input.is_action_just_pressed("attack") and await attack.attack():
		velocity.x = 0

func direction():
	return $Turnable.scale.x

func _on_damage_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		print("damage player")
		attack.cancel_attack()
		damage.get_node("Cooldown").start()
		var direction = area.find_parent("Turnable").scale.x
		velocity.x += direction * 200

func _on_cooldown_timeout() -> void:
	velocity.x = 0

var base_attack = 1

func attack_damage():
	return attack.attack_damage()
