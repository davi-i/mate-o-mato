extends ActionLeaf
class_name WaitSignalAction

@export var node: Node
@export var signal_to_wait: StringName

var finished = false

func _ready() -> void:
	if signal_to_wait not in node:
		push_error("no signal named %s in node" % signal_to_wait) 
	if node[signal_to_wait] is not Signal:
		push_error("property %s is not a signal in node" % signal_to_wait) 
	node[signal_to_wait].connect(_on_signal)

func _on_signal():
	finished = true

func before_run(actor: Node, blackboard: Blackboard):
	finished = false

func tick(actor: Node, blackboard: Blackboard):
	if finished:
		return SUCCESS
	else:
		return RUNNING

func interrupt(actor: Node, blackboard: Blackboard):
	finished = false

func after_run(actor: Node, blackboard: Blackboard):
	finished = false
