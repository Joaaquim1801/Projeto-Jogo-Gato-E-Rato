extends Node

const FASES = [
	preload("res://Cenas/fase_1.tscn"),
	preload("res://Cenas/fase_2.tscn"),
	preload("res://Cenas/fase_3.tscn"),
	preload("res://Cenas/fase_4.tscn")
]
@onready var fase_atual_node = $FaseAtual
var numero_fase = 0

func _ready():
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
