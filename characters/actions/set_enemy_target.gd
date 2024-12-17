extends ActionLeaf
class_name SetEnemyTargetAction

const DEFAULT_DISTANCE_TO_PLAYER = 24

func tick(actor: Node, blackboard: Blackboard) -> int:
	var enemy: Enemy = actor
	var player: Player = blackboard.get_value("player")
	if player == null or player is not Player or actor is not Enemy:
		return FAILURE
	var desired_distance = blackboard.get_value("distance_to_player", DEFAULT_DISTANCE_TO_PLAYER)
	
	var distance = player.global_position - enemy.global_position
	var direction_x = sign(distance.x)
	enemy.turn(direction_x)
	var target = player.global_position
	target.x += -direction_x * desired_distance
	blackboard.set_value("target", target)
	
	return SUCCESS
	
