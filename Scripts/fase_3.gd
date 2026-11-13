extends FaseAgua

@onready var cerca = $CercaVertical

func _on_botão_2_botao_ativado():
	acender_lampada()

func _on_botão_botao_ativado() -> void:
	var destino = cerca.position + Vector2(0, -200)
	var tween = create_tween()
	tween.tween_property(cerca, "position", destino, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
