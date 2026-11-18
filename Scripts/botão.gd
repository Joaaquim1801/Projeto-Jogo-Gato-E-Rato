extends Area2D

signal botao_ativado
var personagens_perto = []
var ativado = false



func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(_delta):
	if personagens_perto.size() > 0 and Input.is_action_just_pressed("interagir"):
		ativar_botao()

func _on_body_entered(body):
	if body.name == "Gato" or body.name == "Rato":
		if not personagens_perto.has(body):
			personagens_perto.append(body)

func _on_body_exited(body):
	personagens_perto.erase(body)

func ativar_botao():
	if get_tree().current_scene.numero_fase != 5 and ativado:
		return
	ativado = true
	tocar_som_personagem()
	botao_ativado.emit()
	$AnimatedSprite2D.play("ativarBotao")
	$AudioStreamPlayer.playing = true

func tocar_som_personagem():
	for personagem in personagens_perto:
		if personagem.is_active:
			personagem.tocar_som()
			return
	if personagens_perto.size() > 0:
		personagens_perto[0].tocar_som()
