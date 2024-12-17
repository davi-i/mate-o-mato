extends ActionLeaf
class_name JumpBackAction

const DEFAULT_JUMP_BACK_IMPULSE = Vector2(200, -200)

var initial_position: Vector2

@export var impulse = DEFAULT_JUMP_BACK_IMPULSE
@export var animation_name = "jump_back"

var prev_animation: String

func before_run(actor: Node, blackboard: Blackboard) -> void:
	var impulse = blackboard.get_value("jump_back_impulse", impulse)
	initial_position = actor.position
	var direction = actor.direction()
	impulse.x *= -actor.direction()
	actor.velocity = impulse
	prev_animation = actor.sprite.animation
	actor.sprite.play(animation_name)

func tick(actor: Node, blackboard: Blackboard) -> int:
	var turnable = actor.find_child("Turnable")
	if not turnable:
		return FAILURE

	var delta = get_physics_process_delta_time()

	actor.velocity += actor.get_gravity() * delta
	
	actor.move_and_slide()
	
	if actor.position.y >= initial_position.y:
		return SUCCESS
	
	return RUNNING

func after_run(actor: Node, blackboard: Blackboard) -> void:
	actor.velocity = Vector2.ZERO
	actor.sprite.play(prev_animation)
