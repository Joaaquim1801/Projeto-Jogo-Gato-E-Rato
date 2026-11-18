extends Personagem

@onready var som_aflito = $SomAflito
@onready var som_agua = $SomAgua
@onready var area_deteccao = $AreaDeteccao
@onready var indicador_e = $IndicadorE
var na_agua = false
var objetos_interagiveis_perto = []


func _init():
	pulo = -400.0
	sufixo_animacao = "Rat"

func _ready():
	som_aflito.finished.connect(_on_som_aflito_finished)
	indicador_e.visible = false

func _physics_process(delta: float) -> void:
	super(delta)
	if na_agua and (abs(velocity.x) > 1 or not is_on_floor()):
		if not som_agua.playing:
			som_agua.play()

func entrar_na_agua():
	na_agua = true
	if not som_agua.playing:
		som_agua.play()

func sair_da_agua():
	na_agua = false
	som_agua.stop()

func _on_som_aflito_finished():
	if assustado:
		som_aflito.play()

func atualizar_estado_escuro():
	var estava_assustado = assustado
	assustado = dentro_da_area_escura and not colado
	if assustado:
		if animacao.animation != "scaredRat":
			animacao.play("scaredRat")
		if not som_aflito.playing:
			som_aflito.play()
	elif estava_assustado:
		som_aflito.stop()
			
			
func atualizar_icone_medo():
	var estava_visivel = $IconeMedo.visible
	var mostrar = proximo_da_escuridao and not colado
	$IconeMedo.visible = mostrar
	if mostrar:
		if $IconeMedo.animation != "medo" or not $IconeMedo.is_playing():
			$IconeMedo.play("medo")
		if not estava_visivel:
			som_aflito.play()
	else:
		$IconeMedo.stop()
		if not assustado:
			som_aflito.stop()

func _on_area_entered(area):
	print(name, " detectou: ", area.name)
	if area.is_in_group("interagiveis"):
		if not objetos_interagiveis_perto.has(area):
			objetos_interagiveis_perto.append(area)
		atualizar_indicador_e()

func _on_area_exited(area):
	objetos_interagiveis_perto.erase(area)
	atualizar_indicador_e()

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
