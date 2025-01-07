extends Enemy

@onready var sprite = $Turnable/AnimatedSprite2D
@onready var damage = $Turnable/Damage

func _ready() -> void:
	$Blackboard.set_value("player", player)
	$Blackboard.set_value("speed", 40)
	$Blackboard.set_value("distance_to_player", 200)

func turn(direction) -> void:
	$Turnable.scale = Vector2(direction, 1)

func _process(delta: float) -> void:
	if not damage.on_cooldown() and not is_attacking() :
		if velocity != Vector2.ZERO:
			sprite.play("walk")
		else:
			sprite.play("idle")

var jaca_scene = preload("res://characters/enemies/jaqueira/jaca.tscn")
	
const JACA_RANGE = 200.0
const JACA_VELOCITY = 500
	
func attack() -> void:
	if not damage.on_cooldown() and not is_attacking():
		print("jaq attack")
		sprite.play("throw")
		await sprite.animation_finished
		var distance = player.global_position - $Turnable/JacaMarker.global_position
		var movement = distance.x + randf_range(- 2 * JACA_RANGE / 3, JACA_RANGE / 3)
		
		var jaca = jaca_scene.instantiate()
		var gravity = get_gravity()
		
		var angle = asin(-abs(movement) * gravity.y / JACA_VELOCITY ** 2) / 2
		jaca.velocity = JACA_VELOCITY * Vector2(
			cos(angle) * sign(movement),
			sin(angle)
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
	print("jaq cancel attack")
	sprite.play("idle")

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "throw":
		sprite.play("reload")
	elif sprite.animation == "reload":
		cancel_attack()
		
func _on_damage_damage_taken(damage: float, area: Area2D) -> void:
	cancel_attack()
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


func _on_damage_killed() -> void:
	queue_free()
