extends Node2D

enum GameState { READY, RUNNING, DEAD }
var state := GameState.READY

@onready var player := $Player
@onready var spawner := $Spawner

func _ready():
	enter_ready()

func _process(delta):
	delta = min(delta, 0.05)

	if state == GameState.READY:
		if Input.is_action_just_pressed("jump"):
			enter_running()

	elif state == GameState.DEAD:
		if Input.is_action_just_pressed("jump"):
			restart()

func enter_ready():
	state = GameState.READY
	player.reset()
	spawner.stop()

func enter_running():
	state = GameState.RUNNING
	spawner.start()

func enter_dead():
	state = GameState.DEAD
	spawner.stop()

func restart():
	for child in spawner.get_children():
		child.queue_free()
	enter_ready()
