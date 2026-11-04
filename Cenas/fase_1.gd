extends Node

# Certifique-se de que os caminhos coincidem com a sua árvore de nós
@onready var gato = $Gato
@onready var rato = $Rato

# Define o Gato como o personagem inicial
var gato_esta_ativo = true

func _ready():
	# Configura o estado logo ao iniciar o jogo
	atualizar_personagem_ativo()

func _process(delta):
	# Lê o input para realizar a troca
	if Input.is_action_just_pressed("trocarPersonagem"):
		gato_esta_ativo = !gato_esta_ativo
		atualizar_personagem_ativo()

func atualizar_personagem_ativo():
	# O personagem ativo recebe true, o inativo recebe false
	gato.is_active = gato_esta_ativo
	rato.is_active = !gato_esta_ativo
