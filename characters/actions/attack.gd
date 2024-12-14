extends ActionLeaf
class_name AttackAction

func tick(actor: Node, blackboard: Blackboard) -> int:
	actor.attack()
	
	return SUCCESS
