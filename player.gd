extends CharacterBody2D

@export var speed := 90

var direction := Vector2.ZERO
var last_direction := "down"

@onready var anim := $AnimatedSprite2D
@onready var footstep_player := $Footstep/AudioStreamPlayer
@onready var footstep_timer := $FootstepTimer


func _physics_process(delta):

	direction = Vector2.ZERO

	# Movimiento
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1

	# Si hay movimiento
	if direction != Vector2.ZERO:
		velocity = direction.normalized() * speed
		update_animation(direction)

		# Activar el timer de pasos si está parado
		if footstep_timer.is_stopped():
			footstep_timer.start()

	# Si NO se mueve
	else:
		velocity = Vector2.ZERO

		anim.play("idle_" + last_direction)

		# Parar sonido y timer
		footstep_timer.stop()
		footstep_player.stop()

	move_and_slide()



# Animaciones según dirección
func update_animation(dir: Vector2):

	# Movimientos horizontales
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			anim.play("walk_right")
			last_direction = "right"
		else:
			anim.play("walk_left")
			last_direction = "left"

	# Movimientos verticales
	else:
		if dir.y > 0:
			anim.play("walk_down")
			last_direction = "down"
		else:
			anim.play("walk_up")
			last_direction = "up"



# Reproduce un paso cada vez que el timer termina
func _on_footstep_timer_timeout():
	footstep_player.play()
