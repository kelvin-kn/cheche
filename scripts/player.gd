extends CharacterBody2D

const GRAVITY : float = 1800.0
const JUMP_FORCE : float = -650.0
const MAX_FALL_SPEED : float = 1200.0

func _physics_process(delta):
	# Clamp delta to avoid tab-switch exploits
	delta = min(delta, 0.05)

	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.y = min(velocity.y, MAX_FALL_SPEED)

	# Jump input (tap or key)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE

	move_and_slide()
