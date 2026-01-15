extends Node2D

@export var spike_scene: PackedScene
var timer : float = 0.0
var interval : float = 1.4
var active : bool = false
var ground_top_y := 0.0


func start():
	active = true
	timer = 0.0

func stop():
	active = false

func _process(delta):
	if not active:
		return
	delta = min(delta, 0.05)
	timer += delta

	if timer >= interval:
		timer = 0
		spawn_spike()

func spawn_spike():
	var spike = spike_scene.instantiate()
	var spike_height = 0  # known size
	spike.position = Vector2(get_viewport_rect().size.x + 40, ground_top_y - spike_height)
	add_child(spike)
