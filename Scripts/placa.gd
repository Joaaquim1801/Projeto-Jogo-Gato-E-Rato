extends Area2D

signal pressionada
signal liberada

var personagens_em_cima = []

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body):
	if body.name != "Gato" and body.name != "Rato":
		return
	
	if personagens_em_cima.has(body):
		return
	
	personagens_em_cima.append(body)
	
	if personagens_em_cima.size() == 1:
		pressionada.emit()


func _on_body_exited(body):
	personagens_em_cima.erase(body)
	
	if personagens_em_cima.is_empty():
		liberada.emit()
