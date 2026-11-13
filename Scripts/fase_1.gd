extends FaseBase

@onready var cerca = $Cerca
@onready var cerca2 = $Cerca2

func _on_alavanca_alavanca_ativada():
	mover_cerca(cerca)

func _on_botão_botao_ativado():
	mover_cerca(cerca2)

func mover_cerca(alvo):
	var destino = alvo.position + Vector2(200, 0)
	var tween = create_tween()
	tween.tween_property(alvo, "position", destino, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
