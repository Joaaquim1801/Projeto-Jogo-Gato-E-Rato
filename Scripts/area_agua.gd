class_name AreaAgua
extends Area2D

var gato_morreu = false

func _ready():
	collision_mask = 6
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "Gato" and not gato_morreu:
		gato_morreu = true
		body.morrer_na_agua()
	elif body.name == "Rato":
		body.entrar_na_agua()

func _on_body_exited(body):
	if body.name == "Rato":
		body.sair_da_agua()
