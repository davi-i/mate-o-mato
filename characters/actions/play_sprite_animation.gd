extends ActionLeaf
class_name SetSpriteAnimationAction

@export var sprite: AnimatedSprite2D
@export var animation: StringName

func tick(actor: Node, blackboard: Blackboard) -> int:
	sprite.play(animation)
	
	return SUCCESS
