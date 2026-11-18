extends AnimatableBody2D

@export var distancia = 100.0
@export var velocidade = 2.0

var movimento_ativado = false
var tween: Tween

func iniciar_movimento():
	if movimento_ativado:
		return

	movimento_ativado = true

	var posicao_inicial = position
	var posicao_final = position + Vector2(0, -distancia)

	tween = create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(self, "position", posicao_final, velocidade)
	tween.tween_property(self, "position", posicao_inicial, velocidade)
