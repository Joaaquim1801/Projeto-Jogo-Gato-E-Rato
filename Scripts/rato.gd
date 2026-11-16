extends Personagem

func _init():
	pulo = -400.0
	sufixo_animacao = "Rat"

func atualizar_estado_escuro():
	assustado = dentro_da_area_escura and not colado
	if assustado:
		if animacao.animation != "scaredRat":
			animacao.play("scaredRat")
			
			
func atualizar_icone_medo():
	$IconeMedo.visible = proximo_da_escuridao and not colado
	if proximo_da_escuridao:
		if $IconeMedo.animation != "medo" or not $IconeMedo.is_playing():
			$IconeMedo.play("medo")
	else:
		$IconeMedo.stop()
