extends CharacterBody2D


const velocidade = 300.0
const pulo = -500.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("pular") and is_on_floor():
		velocity.y = pulo

	var direction := Input.get_axis("esquerda", "direita")
	if direction:
		velocity.x = direction * velocidade
	else:
		velocity.x = move_toward(velocity.x, 0, velocidade)

	move_and_slide()
