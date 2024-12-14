extends ActionLeaf
class_name JumpBackAction

const DEFAULT_SPEED = 300
const DEFAULT_HEIGHT = 20

func tick(actor: Node, blackboard: Blackboard) -> int:
	var speed = blackboard.get_value("jump_back_speed", DEFAULT_SPEED)
	var height = blackboard.get_value("jump_back_height", DEFAULT_HEIGHT)

	var direction: Vector2 = target_node.global_position - actor.global_position
	direction = direction.normalized()
	actor.velocity = direction * speed
	actor.move_and_slide()

	return RUNNING

func after_run(actor: Node, blackboard: Blackboard) -> void:
	actor.velocity = Vector2.ZERO

func interrupt(actor: Node, blackboard: Blackboard) -> void:
	actor.velocity = Vector2.ZERO
