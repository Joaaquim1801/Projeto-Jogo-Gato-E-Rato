extends FaseBase
var plataforma1baixo = true
var plataforma2baixo = false
var porta1 = false
var porta2 = true
var porta3 = true
var porta4 = true
@onready var cerca1 = $CercaVertical
@onready var cerca2 = $CercaVertical2
@onready var cerca3 = $CercaVertical3
@onready var cerca4 = $CercaVertical4
@onready var plataforma = $Plataforma
@onready var plataforma2 = $Plataforma2


func _on_botão_botao_ativado() -> void:
	if(!porta1):
		var destino = cerca1.position + Vector2(0, 200)
		var tween = create_tween()
		tween.tween_property(cerca1, "position", destino, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		$SomPortão.play()
		porta1 = true
	if(porta2):
		var destino = cerca2.position + Vector2(0, 200)
		var tween = create_tween()
		tween.tween_property(cerca2, "position", destino, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		$SomPortão.play()
		porta2 = false


func _on_botão_2_botao_ativado() -> void:
	if(porta3):
		var destino = cerca3.position + Vector2(0, 200)
		var tween = create_tween()
		tween.tween_property(cerca3, "position", destino, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		$SomPortão.play()
		porta3 = false
	if(plataforma1baixo):
		var tween = create_tween()
		tween.tween_property(plataforma, "position:y", plataforma.position.y - 200, 2.0)
		plataforma1baixo = false
	if(!plataforma2baixo):
		var tween = create_tween()
		tween.tween_property(plataforma2, "position:y", plataforma2.position.y + 250, 2.0)
		plataforma2baixo = true


func _on_alavanca_alavanca_ativada() -> void:
	if(porta4):
		var destino = cerca4.position + Vector2(0, -200)
		var tween = create_tween()
		tween.tween_property(cerca4, "position", destino, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	$SomPortão.play()
	if(!porta2):
		var destino = cerca2.position + Vector2(0, -200)
		var tween = create_tween()
		tween.tween_property(cerca2, "position", destino, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		$SomPortão.play()
		porta2 = true
	if(!plataforma1baixo):
		var tween = create_tween()
		tween.tween_property(plataforma, "position:y", plataforma.position.y + 200, 2.0)
		plataforma1baixo = true
	if(plataforma2baixo):
		var tween = create_tween()
		tween.tween_property(plataforma2, "position:y", plataforma2.position.y - 250, 2.0)
		plataforma2baixo = false
