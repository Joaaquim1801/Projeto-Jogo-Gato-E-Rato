extends Personagem

@onready var som_aflito = $SomAflito
var proximo_da_agua = false
@onready var area_deteccao = $AreaDeteccao
@onready var indicador_e = $IndicadorE
var objetos_interagiveis_perto = []



func _ready():
	indicador_e.visible = false

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


func atualizar_indicador_e():
	indicador_e.visible = not objetos_interagiveis_perto.is_empty()


func _on_area_deteccao_area_entered(area: Area2D) -> void:
	print(name, " detectou: ", area.name)
	if area.is_in_group("interagiveis"):
		if not objetos_interagiveis_perto.has(area):
			objetos_interagiveis_perto.append(area)
		atualizar_indicador_e()


func _on_area_deteccao_area_exited(area: Area2D) -> void:
	objetos_interagiveis_perto.erase(area)
	atualizar_indicador_e()
