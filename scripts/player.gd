extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -550.0
var PULO: float = 300

var pontos: int = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Add animation.
	if velocity.x >1 or velocity.x <-1:
		animated_sprite_2d.animation = "running"
	else:
		animated_sprite_2d.animation = "idle"
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
	if direction == 1.0:
		animated_sprite_2d.flip_h = false
	elif direction == -1.0:
				animated_sprite_2d.flip_h = true


# Forma n.2 de captar inputs: função _input. 
# Esta função é chamada sempre que um botão é pressionado.
# Nesse caso, é mais simples que o pulo seja feito aqui.
func _input(event):
	
	if event.is_action_pressed("ui_up") or event.is_action_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = -PULO
			pontos = pontos + 1
			%Pontos.text = str(pontos)
	
