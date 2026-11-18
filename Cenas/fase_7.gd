extends Node2D


func _on_btn_jogar_pressed() -> void:
	get_tree().current_scene.reiniciar_jogo()
