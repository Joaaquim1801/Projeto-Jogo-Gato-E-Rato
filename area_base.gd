class_name AreaBase
extends Area2D

@export var numero_camera: int = 1

func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if body.name != "Gato" and body.name != "Rato":
		return

	print("Personagem detectado: ", body.name)

	var fase = get_parent()
	fase.registrar_camera(body, numero_camera)
