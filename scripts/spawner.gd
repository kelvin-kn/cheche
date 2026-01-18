extends Node2D

@export var spike_scene: PackedScene

var active : bool = false
var ground_top_y : float = 0.0

func spawn_spike():
	var spike = spike_scene.instantiate()
	var spike_height = 4  #ground distance
	spike.position = Vector2(get_viewport_rect().size.x + 40, ground_top_y - spike_height)
	add_child(spike)
