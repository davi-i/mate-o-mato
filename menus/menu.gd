extends Control


func _on_comecar_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_1.tscn")


func _on_sair_pressed() -> void:
	get_tree().quit()
