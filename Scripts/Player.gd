extends KinematicBody2D

const MAX_SPEED = 225
const FRICTION = 20
const ACCELERATION = 30
const GRAVITY = 50
const UP = Vector2(0, -1)
const JUMP_FORCE = 450

var velocity = Vector2.ZERO
var is_jumping = false

onready var jump_buffer = $JumpBuffer
onready var coyote_timer = $CoyoteTimer

func _physics_process(delta):
	if coyote_timer.is_stopped():
		 apply_gravity()
	handle_jumping()
	handle_movement()
	
func apply_gravity():
	if is_on_floor() and velocity.y > 0:
		is_jumping = false
		velocity.y = 0;
	else:
		velocity.y += GRAVITY
		
func handle_movement():
	var was_on_floor = is_on_floor()
	
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		velocity.x = move_toward(velocity.x, -MAX_SPEED, ACCELERATION)
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		velocity.x = move_toward(velocity.x, MAX_SPEED, ACCELERATION)
		
	else: velocity.x = move_toward(velocity.x, 0, FRICTION)
	
	move_and_slide(velocity, UP)
	if !is_on_floor() and was_on_floor and !is_jumping:
		coyote_timer.start()
	
func handle_jumping():
	if is_on_floor() and !jump_buffer.is_stopped():
			velocity.y -= JUMP_FORCE
			is_jumping = true
			jump_buffer.stop()
			
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or !coyote_timer.is_stopped():
			velocity.y = -JUMP_FORCE
			is_jumping = true
			coyote_timer.stop()
		else:
			jump_buffer.start()
