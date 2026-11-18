extends Node2D

var rato_perto_cano1 = null
var rato_perto_cano2 = null


func _ready():
	$Cano1.body_entered.connect(_on_cano1_body_entered)
	$Cano1.body_exited.connect(_on_cano1_body_exited)

	$Cano2.body_entered.connect(_on_cano2_body_entered)
	$Cano2.body_exited.connect(_on_cano2_body_exited)


func _process(_delta):
	if Input.is_action_just_pressed("interagir"):

		if rato_perto_cano1 != null:
			teleportar_rato(rato_perto_cano1, $Cano2/SpawnCano2.global_position)

		elif rato_perto_cano2 != null:
			teleportar_rato(rato_perto_cano2, $Cano1/SpawnCano1.global_position)


func _on_cano1_body_entered(body):
	if body.name == "Rato":
		rato_perto_cano1 = body


func _on_cano1_body_exited(body):
	if body == rato_perto_cano1:
		rato_perto_cano1 = null


func _on_cano2_body_entered(body):
	if body.name == "Rato":
		rato_perto_cano2 = body


func _on_cano2_body_exited(body):
	if body == rato_perto_cano2:
		rato_perto_cano2 = null


func teleportar_rato(rato, destino):
	rato.global_position = destino
	rato.velocity = Vector2.ZERO
	print("Rato teleportado!")
