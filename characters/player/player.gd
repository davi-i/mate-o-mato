extends CharacterBody2D
class_name Player


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


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
	if velocity.x < 0:
		$Turnable.scale = Vector2(-1, 1)
	elif velocity.x > 0:
		$Turnable.scale = Vector2(1, 1)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack") and $Turnable/Attack.attack():
		velocity.x = 0

func _on_attack_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		print("attack")
