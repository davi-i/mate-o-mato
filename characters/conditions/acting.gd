extends ConditionLeaf
class_name ActingCondition

func tick(actor: Node, blacboard: Blackboard):
	if actor.is_acting():
		return SUCCESS
	else:
		return FAILURE
