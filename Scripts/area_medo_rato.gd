class_name AreaMedoRato
extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body):
	if body.name == "Rato":
		body.proximo_da_escuridao = true
		body.atualizar_icone_medo()


func _on_body_exited(body):
	if body.name == "Rato":
		body.proximo_da_escuridao = false
		body.atualizar_icone_medo()
