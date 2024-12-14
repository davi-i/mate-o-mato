extends ActionLeaf
class_name WaitTimerAction

@export var timer: Timer

func before_run(actor: Node, blackboard: Blackboard):
	timer.start()

func tick(actor: Node, blackboard: Blackboard):
	if timer.is_stopped():
		return SUCCESS
	else:
		return RUNNING

func interrupt(actor: Node, blackboard: Blackboard):
	timer.stop()
