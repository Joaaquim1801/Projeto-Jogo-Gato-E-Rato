extends Personagem

@onready var som_aflito = $SomAflito
var proximo_da_agua = false

func _init():
	pulo = -500.0
	sufixo_animacao = "Cat"

func atualizar_icone_medo():
	var estava_visivel = $IconeMedo.visible
	$IconeMedo.visible = proximo_da_agua
	if proximo_da_agua:
		if $IconeMedo.animation != "medo" or not $IconeMedo.is_playing():
			$IconeMedo.play("medo")
		if not estava_visivel:
			som_aflito.play()
	else:
		$IconeMedo.stop()
		som_aflito.stop()

func morrer_na_agua():
	if esta_morrendo:
		return
	esta_morrendo = true
	is_active = false
	velocity = Vector2.ZERO
	animacao.play("dyingCat")
	await animacao.animation_finished
	get_tree().current_scene.reiniciar_fase()
