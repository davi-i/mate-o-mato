extends ActionLeaf
class_name MoveToTargetAction

const DEFAULT_SPEED = 60

func tick(actor: Node, blackboard: Blackboard) -> int:
	var target = blackboard.get_value("target")
	if target == null or target is not Vector2:
		return FAILURE
	
	var speed = blackboard.get_value("speed", DEFAULT_SPEED)

	var direction: Vector2 = target - actor.global_position
	direction = direction.normalized()
	actor.velocity = direction * speed
	actor.move_and_slide()

	return RUNNING

func after_run(actor: Node, blackboard: Blackboard) -> void:
	actor.velocity = Vector2.ZERO

#func interrupt(actor: Node, blackboard: Blackboard) -> void:
	#actor.velocity = Vector2.ZERO
