extends CharacterBody2D

@export var target: Player

func _ready() -> void:
	$Blackboard.set_value("target", target)
	$Blackboard.set_value("speed", 200)

func _process(delta: float) -> void:
	
	if velocity.x < 0:
		$Turnable.scale = Vector2(-1, 1)
	if velocity.x > 0:
		$Turnable.scale = Vector2(1, 1)

func attack() -> void:
	if $Turnable/Attack/Timer.is_stopped():
		$Turnable/Attack/PunchCollision.disabled = false
		$Turnable/Attack/Timer.start()


func _on_attack_timer_timeout() -> void:
	$Turnable/Attack/PunchCollision.disabled = true


func _on_player_reach_body_entered(body: Node2D) -> void:
	print("entered")
	if body is Player:
		$Blackboard.set_value("reach_player", true)


func _on_player_reach_body_exited(body: Node2D) -> void:
	if body is Player:
		$Blackboard.set_value("reach_player", false)


func _on_attack_body_entered(body: Node2D) -> void:
	if body is Player:
		print("enemy attack")
