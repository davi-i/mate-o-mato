@tool
extends ConditionLeaf
class_name RandomConditon

@export var seed: int = 0
@export var success_chance: float :
	set(new_chance):
		if new_chance < 0:
			success_chance = 0
		elif new_chance > 1:
			success_chance = 1
		else:
			success_chance = new_chance

func before_run(actor: Node, blackboard: Blackboard):
	if seed == 0:
		randomize()
	else:
		seed(seed)

func tick(actor: Node, blackboard: Blackboard):
	if randf_range(0, 1) <= success_chance:
		return SUCCESS
	else:
		return FAILURE
