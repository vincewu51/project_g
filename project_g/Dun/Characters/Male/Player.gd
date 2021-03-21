extends KinematicBody2D

const ACCELERATION = 50
const MAX_SPEED = 200
const FRICTION = 50
var velocity = Vector2.ZERO

func cartesian_to_isometric(cartesian):
	var screen_pos = Vector2.ZERO
	screen_pos.x = cartesian.x - cartesian.y
	screen_pos.y = (cartesian.x + cartesian.y) / 2
	return screen_pos

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	input_vector = cartesian_to_isometric(input_vector) 
	if input_vector != Vector2.ZERO:
		velocity += input_vector * ACCELERATION * delta
		velocity = velocity.clamped(MAX_SPEED * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	print(velocity)
	move_and_collide(velocity)
