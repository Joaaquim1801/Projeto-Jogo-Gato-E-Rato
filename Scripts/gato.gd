extends CharacterBody2D


const velocidade = 300.0
const pulo = -500.0
var is_active = false 
@onready var animacao = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if is_active:
		if Input.is_action_just_pressed("pular") and is_on_floor():
			velocity.y = pulo

		var direction := Input.get_axis("esquerda", "direita")
		if direction:
			velocity.x = direction * velocidade
		else:
			velocity.x = move_toward(velocity.x, 0, velocidade)
	else:
		# Se não estiver ativo, zera a velocidade horizontal com atrito
		velocity.x = move_toward(velocity.x, 0, velocidade)
	
	move_and_slide()
	
	atualizar_animacao()
	

func atualizar_animacao():
	# Verifica se está no ar
	if not is_on_floor():
		if velocity.y < 0:
			animacao.play("jumpingCat")
		else:
			animacao.play("fallingCat")
	else:
		
		if abs(velocity.x) > 1:
			animacao.play("runningCat")
		else:
			animacao.play("idleCat")
	
	# Vira o sprite conforme a direção
	if velocity.x != 0:
		animacao.flip_h = velocity.x < 0
