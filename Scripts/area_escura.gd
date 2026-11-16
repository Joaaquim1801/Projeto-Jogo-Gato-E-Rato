class_name AreaEscura
extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body):
	if body.name == "Rato":
		body.dentro_da_area_escura = true
		body.atualizar_estado_escuro()


func _on_body_exited(body):
	if body.name == "Rato":
		body.dentro_da_area_escura = false
		body.atualizar_estado_escuro()
