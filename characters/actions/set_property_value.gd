@tool
class_name SetPropertyAction extends ActionLeaf

@export var node: Node
@export_placeholder(EXPRESSION_PLACEHOLDER) var property: String = ""
@export_placeholder(EXPRESSION_PLACEHOLDER) var new_value: String = ""

@onready var _propery_expression: Expression = parse_expression(property)
@onready var _value_expression: Expression = parse_expression(new_value)


func parse_expression(source: String) -> Expression:
	var result: Expression = Expression.new()
	var error: int = result.parse(source, ["blackboard"])

	if not Engine.is_editor_hint() and error != OK:
		push_error(
			(
				"[Leaf] Couldn't parse expression with source: `%s` Error text: `%s`"
				% [source, result.get_error_text()]
			)
		)

	return result

func tick(actor: Node, blackboard: Blackboard) -> int:
	var property_value: Variant = _propery_expression.execute([blackboard], node)

	if _propery_expression.has_execute_failed():
		return FAILURE

	var value_value: Variant = _value_expression.execute([blackboard], node)

	if _value_expression.has_execute_failed():
		return FAILURE
	
	if property not in node:
		return FAILURE
	
	node[property] = value_value

	return SUCCESS


func _get_expression_sources() -> Array[String]:
	return [property, new_value]
