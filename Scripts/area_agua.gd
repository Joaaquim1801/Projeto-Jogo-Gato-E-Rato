class_name AreaAgua
extends Area2D

var gato_morreu = false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Gato" and not gato_morreu:
		gato_morreu = true
		body.morrer_na_agua()
