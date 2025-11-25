extends CharacterBody2D

@export var speed := 90

var direction := Vector2.ZERO
var last_direction := "down"
@onready var anim := $AnimatedSprite2D

func _physics_process(delta):
	direction = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1

	
	if direction != Vector2.ZERO:
		velocity = direction.normalized() * speed
		update_animation(direction)
	else:
		velocity = Vector2.ZERO
		anim.play("idle_" + last_direction)

	move_and_slide()

func update_animation(dir: Vector2):
	if abs(dir.x) > abs(dir.y):
		
		if dir.x > 0:
			anim.play("walk_right")
			last_direction = "right"
		else:
			anim.play("walk_left")
			last_direction = "left"
	else:
		
		if dir.y > 0:
			anim.play("walk_down")
			last_direction = "down"
		else:
			anim.play("walk_up")
			last_direction = "up"
