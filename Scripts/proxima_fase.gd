extends Area2D

var personagens_na_saida = []
var pode_avancar = true

func _on_body_entered(body):
	if not pode_avancar:
		return
	if body.name == "Gato" or body.name == "Rato":
		if not personagens_na_saida.has(body):
			personagens_na_saida.append(body)
		verificar_saida()


func _on_body_exited(body):
	if body.name == "Gato" or body.name == "Rato":
		personagens_na_saida.erase(body)
	verificar_saida()

func verificar_saida():
	if not pode_avancar:
		return
	var gato_chegou = false
	var rato_chegou = false
	for personagem in personagens_na_saida:
		if not is_instance_valid(personagem):
			continue
		if personagem.name == "Gato":
			gato_chegou = true
		elif personagem.name == "Rato":
			rato_chegou = true
	if gato_chegou and rato_chegou:
		pode_avancar = false
		get_tree().current_scene.proxima_fase()
