extends ConditionLeaf
class_name ReachPlayer

func tick(actor: Node, blackboard: Blackboard) -> int:
	if blackboard.get_value("reach_player"):
		return SUCCESS
	else:
		return FAILURE
