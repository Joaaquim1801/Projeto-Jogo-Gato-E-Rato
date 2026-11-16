extends Node

const TELA_INICIAL = preload("res://Cenas/tela_inicial.tscn")
const FASES = [
	preload("res://Cenas/fase_1.tscn"),
	preload("res://Cenas/fase_2.tscn"),
	preload("res://Cenas/fase_3.tscn"),
	preload("res://Cenas/fase_4.tscn")
]
const MUSICA_INICIO = "res://SFX/Starry Valley.wav"
const MUSICA_JOGO = "res://SFX/Peaceful Pixel Haven.wav"

@onready var fase_atual_node = $FaseAtual
var numero_fase = 0
var musica: AudioStreamPlayer

func _ready():
	musica = AudioStreamPlayer.new()
	musica.name = "Musica"
	add_child(musica)
	# Repete a música sempre que ela terminar
	musica.finished.connect(musica.play)
	mostrar_tela_inicial()

func tocar_musica(caminho: String):
	var stream = load(caminho)
	if musica.stream == stream and musica.playing:
		return
	musica.stream = stream
	musica.play()

func mostrar_tela_inicial():
	tocar_musica(MUSICA_INICIO)
	var tela_inicial = TELA_INICIAL.instantiate()
	add_child(tela_inicial)
	tela_inicial.iniciar_jogo.connect(_on_iniciar_jogo)

func _on_iniciar_jogo():
	tocar_musica(MUSICA_JOGO)
	carregar_fase()

func carregar_fase():
	var nova_fase = FASES[numero_fase].instantiate()
	fase_atual_node.add_child(nova_fase)

func proxima_fase():
	if numero_fase < FASES.size() - 1:
		for filho in fase_atual_node.get_children():
			filho.queue_free()
		numero_fase += 1
		carregar_fase.call_deferred()
	else:
		print("Todas as fases concluídas")

func reiniciar_fase():
	for filho in fase_atual_node.get_children():
		filho.queue_free()

	carregar_fase.call_deferred()
