extends ActionLeaf
class_name MoveToTarget

const DEFAULT_SPEED = 300

func tick(actor: Node, blackboard: Blackboard) -> int:
	var target_node = blackboard.get_value("target")
	if target_node == null or target_node is not Player:
		return FAILURE
	
	var speed = blackboard.get_value("speed", DEFAULT_SPEED)

	var direction: Vector2 = target_node.global_position - actor.global_position
	direction = direction.normalized()
	actor.velocity = direction * speed
	actor.move_and_slide()

	return RUNNING

func after_run(actor: Node, blackboard: Blackboard) -> void:
	actor.velocity = Vector2.ZERO

func interrupt(actor: Node, blackboard: Blackboard) -> void:
	actor.velocity = Vector2.ZERO
