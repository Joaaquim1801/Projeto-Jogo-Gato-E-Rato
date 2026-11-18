extends Control

signal intro_finalizada

@onready var texto_label: Label = $TextoIntro

func _ready():
	# Começa com o texto totalmente invisível
	texto_label.modulate.a = 0.0
	
	# Duração total de 7 segundos:
	# 1.5s fade-in + 4.0s visível + 1.5s fade-out = 7.0s
	var tween = create_tween()
	tween.tween_property(texto_label, "modulate:a", 1.0, 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_interval(4.0)
	tween.tween_property(texto_label, "modulate:a", 0.0, 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(_on_tween_finished)

func _on_tween_finished():
	intro_finalizada.emit()
	queue_free()
