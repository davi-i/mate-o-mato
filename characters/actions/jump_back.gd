extends ActionLeaf
class_name JumpBackAction

const DEFAULT_JUMP_BACK_IMPULSE = Vector2(200, -200)

var initial_position: Vector2

@export var animation_name = "jump_back"

func before_run(actor: Node, blackboard: Blackboard) -> void:
	var impulse = blackboard.get_value("jump_back_impulse", DEFAULT_JUMP_BACK_IMPULSE)
	initial_position = actor.position
	var direction = actor.direction()
	impulse.x *= -actor.direction()
	actor.velocity = impulse
	actor.sprite.animation = animation_name
	actor.sprite.frame = 1

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
	actor.sprite.play("idle")
