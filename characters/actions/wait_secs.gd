extends ActionLeaf
class_name WaitSecsAction

@export_placeholder(EXPRESSION_PLACEHOLDER) var time: String = ""

@onready var _time_expression: Expression = _parse_expression(time)

var time_passed = 0
var total_time = 0

func before_run(actor: Node, blackboard: Blackboard):
	if total_time > 0:
		return
	var time: float = _time_expression.execute([], blackboard)
	if time != null:
		total_time = time

func tick(actor: Node, blackboard: Blackboard):
	time_passed += get_process_delta_time()
	if time_passed >= total_time:
		return SUCCESS
	else:
		return RUNNING

func after_run(actor: Node, blackboard: Blackboard):
	total_time = 0
	time_passed = 0
