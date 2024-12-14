extends ConditionLeaf
class_name Area2DCollidingCondition

@export var area: Area2D
@export var group: StringName

var colliding = false

func _ready() -> void:
	area.connect("body_entered", _on_area_entered)
	area.connect("body_exited", _on_area_exited)
	area.connect("area_entered", _on_area_entered)
	area.connect("area_exited", _on_area_exited)

func tick(actor: Node, blackboard: Blackboard) -> int:
	if colliding:
		return SUCCESS
	else:
		return FAILURE

func _on_area_entered(body: Node2D):
	if body.is_in_group(group):
		colliding = true
		
func _on_area_exited(body: Node2D):
	if body.is_in_group(group):
		colliding = false
