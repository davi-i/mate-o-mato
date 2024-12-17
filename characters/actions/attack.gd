extends ActionLeaf
class_name AttackAction

func before_run(actor: Node, blackboard: Blackboard) -> void:
	print("before attack")
	actor.attack()

func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.is_attacking():
		return RUNNING
	else:
		return SUCCESS

func interrupt(actor: Node, blackboard: Blackboard) -> void:
	actor.cancel_attack()
