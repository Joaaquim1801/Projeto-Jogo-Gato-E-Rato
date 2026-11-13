class_name FaseBase
extends Node2D

# Base de todas as fases: troca entre Gato e Rato.
@onready var gato = $Gato
@onready var rato = $Rato

# Define o Gato como o personagem inicial
var gato_esta_ativo = true

func _ready():
	atualizar_personagem_ativo()

func _process(_delta):
	if Input.is_action_just_pressed("trocarPersonagem"):
		gato_esta_ativo = !gato_esta_ativo
		atualizar_personagem_ativo()

func atualizar_personagem_ativo():
	# O personagem ativo recebe true, o inativo recebe false
	gato.is_active = gato_esta_ativo
	rato.is_active = !gato_esta_ativo
