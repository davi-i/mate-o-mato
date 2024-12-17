extends ActionLeaf
class_name WaitTimerAction

@export var timer: Timer
@export var blackboard_value = "timer_time"

func before_run(actor: Node, blackboard: Blackboard):
	if timer.paused:
		timer.paused = false
		return
	var time = blackboard.get_value(blackboard_value)
	if time != null:
		if time != timer.wait_time:
			blackboard.set_value("original_%s" % blackboard_value, timer.wait_time)
		timer.start(time)
	else:
		timer.start()

func tick(actor: Node, blackboard: Blackboard):
	if timer.is_stopped():
		return SUCCESS
	else:
		return RUNNING

func interrupt(actor: Node, blackboard: Blackboard):
	timer.paused = true
