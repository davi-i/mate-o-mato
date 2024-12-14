extends ActionLeaf
class_name SetSpriteColorAction

@export var sprite: AnimatedSprite2D
@export var color: Color

func tick(actor: Node, blackboard: Blackboard) -> int:
	sprite.modulate = color
	return SUCCESS
