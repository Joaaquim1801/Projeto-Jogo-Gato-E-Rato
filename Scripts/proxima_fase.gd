extends Area2D

var personagens_na_saida = []
var pode_avancar = true



func _on_body_entered(body):
	if pode_avancar:
		if body.name == "Gato" or body.name == "Rato":
			if not personagens_na_saida.has(body):
					personagens_na_saida.append(body)
			verificar_saida()

func _on_body_exited(body):
	personagens_na_saida.erase(body)

func verificar_saida():
	var gato_chegou = false
	var rato_chegou = false
	for personagem in personagens_na_saida:
		if personagem.name == "Gato":
			gato_chegou = true
		elif personagem.name == "Rato":
			rato_chegou = true
	if gato_chegou and rato_chegou:
		pode_avancar = false
		get_tree().current_scene.proxima_fase()
