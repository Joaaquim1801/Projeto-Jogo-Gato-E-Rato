extends Control

signal iniciar_jogo

@onready var btn_jogar: Button = $BtnJogar

func _ready():
	btn_jogar.pressed.connect(_on_btn_jogar_pressed)
	# Remove o contorno de foco em volta do botão
	btn_jogar.focus_mode = Control.FOCUS_NONE
	btn_jogar.add_theme_stylebox_override("focus", StyleBoxEmpty.new())

func _on_btn_jogar_pressed():
	btn_jogar.disabled = true
	iniciar_jogo.emit()
	queue_free()
