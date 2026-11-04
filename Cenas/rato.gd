extends CharacterBody2D

const velocidade = 300.0
const pulo = -400.0

# Variável que define se este personagem pode ser controlado
var is_active = false 

func _physics_process(delta):
	# A gravidade puxa o personagem independentemente de estar ativo ou não
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_active:
		# Lógica de controle apenas se estiver ativo
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
