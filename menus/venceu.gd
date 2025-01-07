extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var level_1 = preload("res://levels/level_1.tscn")

func _on_jogar_novamente_pressed() -> void:
	get_tree().change_scene_to_packed(level_1)

func _on_sair_pressed() -> void:
	get_tree().quit()
