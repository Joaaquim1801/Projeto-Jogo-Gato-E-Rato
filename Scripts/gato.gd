extends Personagem

func _init():
	pulo = -500.0
	sufixo_animacao = "Cat"

func morrer_na_agua():
	if esta_morrendo:
		return
	esta_morrendo = true
	is_active = false
	velocity = Vector2.ZERO
	animacao.play("dyingCat")
	await animacao.animation_finished
	get_tree().current_scene.reiniciar_fase()
