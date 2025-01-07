extends Node

const DAMAGE_TO_FALL_DOWN = 5
const ENEMY_DAMAGE_COLOR = Color.INDIAN_RED 


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
