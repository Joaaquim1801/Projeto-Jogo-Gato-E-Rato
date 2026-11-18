class_name FaseBase
extends Node2D

# Base de todas as fases: troca entre Gato e Rato.
@onready var gato = $Gato
@onready var rato = $Rato
@onready var botao_reiniciar = $CanvasLayer/BotaoReiniciar

var camera_personagens = {
	"Gato": 1,
	"Rato": 1
}

# Define o Gato como o personagem inicial
var gato_esta_ativo = true

# Mecânica de colar: Q coloca o Rato em cima do Gato
const DISTANCIA_COLAR = 100.0
var rato_colado = false

func _ready():
	# Roda a física da fase depois da dos personagens, para o Rato não ficar um frame atrasado
	process_physics_priority = 1
	atualizar_personagem_ativo()
	botao_reiniciar.pressed.connect(_on_botao_reiniciar_pressed)

func _process(_delta):
	if Input.is_action_just_pressed("colar"):
		if rato_colado:
			descolar_rato()
		else:
			colar_rato()
	# Enquanto colado, o Gato é quem controla
	if Input.is_action_just_pressed("trocarPersonagem") and not rato_colado:
		gato_esta_ativo = !gato_esta_ativo
		atualizar_personagem_ativo()

func atualizar_personagem_ativo():
	# O personagem ativo recebe true, o inativo recebe false
	gato.is_active = gato_esta_ativo
	rato.is_active = !gato_esta_ativo

	$Gato/Seta.visible = gato_esta_ativo
	$Rato/Seta.visible = !gato_esta_ativo

	# Ativa a câmera correspondente ao personagem selecionado
	var personagem_ativo = gato if gato_esta_ativo else rato
	trocar_camera(camera_personagens[personagem_ativo.name])

func _physics_process(_delta):
	if rato_colado:
		posicionar_rato_no_gato()

func colar_rato():
	var distancia = gato.retangulo_colisao().get_center().distance_to(rato.retangulo_colisao().get_center())
	if distancia > DISTANCIA_COLAR:
		return
	var personagem_interagindo = gato if gato_esta_ativo else rato
	personagem_interagindo.tocar_som()
	rato_colado = true
	rato.colado = true
	# Evita que o corpo do Rato empurre o Gato (e vice-versa)
	gato.add_collision_exception_with(rato)
	rato.add_collision_exception_with(gato)
	gato_esta_ativo = true
	atualizar_personagem_ativo()
	posicionar_rato_no_gato()
	rato.atualizar_estado_escuro()
	rato.atualizar_icone_medo()

func descolar_rato():
	rato.tocar_som()
	rato_colado = false
	rato.colado = false
	gato.remove_collision_exception_with(rato)
	rato.remove_collision_exception_with(gato)
	rato.atualizar_estado_escuro()
	rato.atualizar_icone_medo()

func posicionar_rato_no_gato():
	var corpo_gato = gato.retangulo_colisao()
	var corpo_rato = rato.retangulo_colisao()
	# Diferença entre a origem do Rato e a base da colisão dele
	var ajuste = rato.global_position - Vector2(corpo_rato.get_center().x, corpo_rato.end.y)
	rato.global_position = Vector2(corpo_gato.get_center().x, corpo_gato.position.y) + ajuste
	rato.animacao.flip_h = gato.animacao.flip_h


func trocar_camera(numero: int):
	var camera_desejada = $Cameras.get_node_or_null("Camera" + str(numero))

	if camera_desejada == null:
		print("Câmera não encontrada: Camera", numero)
		return

	for camera in $Cameras.get_children():
		camera.enabled = false

	camera_desejada.enabled = true
	camera_desejada.make_current()

	print("Câmera ativada: ", camera_desejada.name)


func registrar_camera(body, numero: int):
	camera_personagens[body.name] = numero

	if body.is_active:
		trocar_camera(numero)

func _on_botao_reiniciar_pressed():
	get_tree().current_scene.reiniciar_fase()
