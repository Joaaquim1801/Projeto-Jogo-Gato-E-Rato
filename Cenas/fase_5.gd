extends FaseAgua

@onready var cerca = $CercaHorizontal
@onready var cerca2 = $CercaVertical

func _on_alavanca_alavanca_ativada() -> void:
	var destino = cerca.position + Vector2(200, 0)
	var tween = create_tween()
	tween.tween_property(cerca, "position", destino, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	$SomPortão.play()


func _on_botão_botao_ativado() -> void:
	var destino = cerca2.position + Vector2(0, -200)
	var tween = create_tween()
	tween.tween_property(cerca2, "position", destino, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	$SomPortão.play()


func _on_alavanca_2_alavanca_ativada() -> void:
	var plataforma = $Plataforma
	var posicao_inicial = plataforma.position
	var posicao_final = posicao_inicial + Vector2(0, -100)

	var tween = create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(plataforma, "position", posicao_final, 2.0)
	tween.tween_property(plataforma, "position", posicao_inicial, 2.0)
