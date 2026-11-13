class_name Personagem
extends CharacterBody2D

# Base do Gato e do Rato. Cada um ajusta pulo e prefixo das animações no Inspector/script.
@export var velocidade = 300.0
@export var pulo = -500.0
# Sufixo das animações: "Cat" -> idleCat, runningCat, jumpingCat, fallingCat
@export var sufixo_animacao = "Cat"

var is_active = false
# Quando true, o personagem é carregado por outro e não se move sozinho
var colado = false

@onready var animacao = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if colado:
		velocity = Vector2.ZERO
		animacao.play("idle" + sufixo_animacao)
		return

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
	if not is_on_floor():
		animacao.play(("jumping" if velocity.y < 0 else "falling") + sufixo_animacao)
	elif abs(velocity.x) > 1:
		animacao.play("running" + sufixo_animacao)
	else:
		animacao.play("idle" + sufixo_animacao)
	# Vira o sprite conforme a direção
	if velocity.x != 0:
		animacao.flip_h = velocity.x < 0

# Centro e tamanho da colisão em coordenadas globais (o shape não fica na origem do nó)
func retangulo_colisao() -> Rect2:
	var forma = $CollisionShape2D
	var tamanho = forma.shape.size * forma.global_scale
	return Rect2(forma.global_position - tamanho / 2, tamanho)
