extends KinematicBody2D

var velocity = Vector2.ZERO
const MAX_SPEED = 225
const FRICTION = 20
const ACCELERATION = 30
const GRAVITY = 50
const UP = Vector2(0, -1)


func _physics_process(delta):
	apply_gravity()
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		velocity.x = move_toward(velocity.x, -MAX_SPEED, ACCELERATION)
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		velocity.x = move_toward(velocity.x, MAX_SPEED, ACCELERATION)
		
	else: velocity.x = move_toward(velocity.x, 0, FRICTION)
	move_and_slide(velocity, UP)
	
func apply_gravity():
	if not is_on_floor():
		velocity.y += GRAVITY
	else:
		velocity.y = 0;
	
