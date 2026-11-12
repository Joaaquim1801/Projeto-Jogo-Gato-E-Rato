extends Node2D

# Certifique-se de que os caminhos coincidem com a sua árvore de nós
@onready var gato = $Gato
@onready var rato = $Rato
@onready var agua = $TileAgua
@onready var barreira_gato = $BarreiraGato
var celulas_originais = {}
var linhas_agua = []
var agua_deve_ficar_vazia = false
var processando_agua = false
# Define o Gato como o personagem inicial
var gato_esta_ativo = true

func _ready():
	# Configura o estado logo ao iniciar o jogo
	atualizar_personagem_ativo()
	for celula in agua.get_used_cells():
		celulas_originais[celula] = {"source_id": agua.get_cell_source_id(celula),"atlas_coords": agua.get_cell_atlas_coords(celula),"alternative_tile": agua.get_cell_alternative_tile(celula)}
		
		if not linhas_agua.has(celula.y):
			linhas_agua.append(celula.y)
	
	# Ordena as linhas de baixo para cima
	linhas_agua.sort()
	linhas_agua.reverse()


func _process(delta):
	# Lê o input para realizar a troca
	if Input.is_action_just_pressed("trocarPersonagem"):
		gato_esta_ativo = !gato_esta_ativo
		atualizar_personagem_ativo()

func atualizar_personagem_ativo():
	# O personagem ativo recebe true, o inativo recebe false
	gato.is_active = gato_esta_ativo
	rato.is_active = !gato_esta_ativo

func _on_placa_pressionada():
	agua_deve_ficar_vazia = true
	processar_agua()

func _on_placa_liberada():
	agua_deve_ficar_vazia = false
	processar_agua()

func processar_agua():
	if processando_agua:
		return
	processando_agua = true
	while true:
		var linha_encontrada = false
		var ordem_linhas = linhas_agua.duplicate()
		if agua_deve_ficar_vazia:
			ordem_linhas.reverse()
		for linha in ordem_linhas:
			var precisa_mudar = false
			for celula in celulas_originais:
				if celula.y == linha:
					var existe_tile = agua.get_cell_source_id(celula) != -1
					if agua_deve_ficar_vazia and existe_tile:
						precisa_mudar = true
					elif not agua_deve_ficar_vazia and not existe_tile:
						precisa_mudar = true
			if precisa_mudar:
				linha_encontrada = true
				for celula in celulas_originais:
					if celula.y == linha:
						if agua_deve_ficar_vazia:
							agua.erase_cell(celula)
						else:
							var dados = celulas_originais[celula]
							agua.set_cell(celula,dados["source_id"],dados["atlas_coords"],dados["alternative_tile"])
				await get_tree().create_timer(0.5).timeout
				break
		if not linha_encontrada:
			break
	processando_agua = false
	if agua_deve_ficar_vazia:
		remover_barreira()
	else:
		restaurar_barreira()

func remover_barreira():
	barreira_gato.visible = false
	barreira_gato.get_node("CollisionShape2D").set_deferred("disabled", true)

func restaurar_barreira():
	barreira_gato.visible = true
	barreira_gato.get_node("CollisionShape2D").set_deferred("disabled", false)

func _on_botão_botao_ativado():
	$AreaEscura.queue_free()
	$BarreiraRato.queue_free()
	$Lampada.play("lampada_acesa")
