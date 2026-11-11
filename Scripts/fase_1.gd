extends Node2D

# Certifique-se de que os caminhos coincidem com a sua árvore de nós
@onready var gato = $Gato
@onready var rato = $Rato
@onready var cerca = $Cerca
@onready var cerca2 = $Cerca2

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

func _on_alavanca_alavanca_ativada():
	abrir_cerca()

func _on_botão_botao_ativado():
	abrir_cerca_dois()

func abrir_cerca():
	var destino = cerca.position + Vector2(200, 0)
	var tween = create_tween()
	tween.tween_property(cerca, "position", destino, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func abrir_cerca_dois():
	var destino = cerca2.position + Vector2(200, 0)
	var tween = create_tween()
	tween.tween_property(cerca2, "position", destino, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
