extends CharacterBody2D

const GRAVITY : float = 1800.0
const JUMP_FORCE : float = -700.0
const MAX_FALL_SPEED : float = 1200.0

var jump_count = 0

@onready var spawner: Node2D = $"../Spawner"

func _ready() -> void:
	reset()

func _physics_process(delta):
	# Clamp delta to avoid tab-switch exploits
	delta = min(delta, 0.05)

	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.y = min(velocity.y, MAX_FALL_SPEED)

	# Jump input (tap or key)
	if is_on_floor():
		jump_count = 0
	if Input.is_action_just_pressed("jump") and jump_count <= 2:
			velocity.y = JUMP_FORCE
			jump_count += 1

	move_and_slide()

func reset():
	var viewport_height = get_viewport_rect().size.y
	position = Vector2(120, viewport_height - 500)
	velocity = Vector2.ZERO
	set_physics_process(true)

func die():
	set_physics_process(false)
	velocity = Vector2.ZERO
	get_parent().enter_dead()
