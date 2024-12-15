extends Enemy

@onready var sprite = $Turnable/AnimatedSprite2D

func _ready() -> void:
	$Blackboard.set_value("player", player)
	$Blackboard.set_value("speed", 40)
	$Blackboard.set_value("distance_to_player", 200)

func turn(direction) -> void:
	$Turnable.scale = Vector2(direction, 1)

func _process(delta: float) -> void:
	if not is_attacking() :
		if velocity != Vector2.ZERO:
			sprite.play("walk")
		else:
			sprite.play("idle")

var jaca_scene = preload("res://characters/enemies/jaqueira/jaca.tscn")
	
const JACA_RANGE = 100.0
const JACA_VELOCITY = 500
	
func attack() -> void:
	if not is_attacking():
		sprite.play("throw")
		await sprite.animation_finished
		var distance = player.global_position - $Turnable/JacaMarker.global_position
		print("player position: ", player.global_position)
		print("inital position: ",  $Turnable/JacaMarker.global_position)
		print("distance: ", distance)
		var movement = distance.x + randf_range(-JACA_RANGE, JACA_RANGE)
		print("movement: ", movement)
		
		var jaca = jaca_scene.instantiate()
		var gravity = get_gravity()
		
		print("gravity", gravity)
		
		print(movement * gravity.y / JACA_VELOCITY ** 2)
		var theta = asin(-abs(movement) * gravity.y / JACA_VELOCITY ** 2) / 2
		print("theta: ", rad_to_deg(theta))
		jaca.velocity = JACA_VELOCITY * Vector2(
			cos(theta) * sign(movement),
			sin(theta)
		)
		jaca.y = $CollisionShape2D.global_position.y
		jaca.get_node("Turnable").scale = $Turnable.scale
		get_parent().add_child(jaca)
		jaca.global_position = $Turnable/JacaMarker.global_position
		jaca.global_scale = Vector2.ONE

func is_attacking():
	return sprite.animation in ["throw", "reload"]

func direction():
	return $Turnable.scale.x

func cancel_attack():
	sprite.play("idle")

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "throw":
		sprite.play("reload")
	elif sprite.animation == "reload":
		cancel_attack()
