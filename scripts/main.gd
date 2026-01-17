extends Node2D

const SAFE_BOTTOM_MARGIN : int = 150
const MIN_SPIKE_SPACING : float = 400.0
const MAX_SPIKE_SPACING : float = 650.0
const DISTANCE_RATE : float = 0.05

enum GameState { READY, RUNNING, DEAD }
var state: GameState = GameState.READY

var distance : float = 0.0
var raw_travel_distance : float = 0.0

var distance_since_last_spike : float = 0.0
var target_spike_distance : float = 0.0

@export var base_speed : float = 300.0
@export var max_speed : float = 700.0
@export var speed_increase_per_1000 : float = 10.0

@onready var player : CharacterBody2D = $Player
@onready var spawner : Node2D = $Spawner

@onready var start: Button = $CanvasLayer/Start
@onready var restart: Button = $CanvasLayer/Restart
@onready var title_label := $CanvasLayer/TitleLabel
@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var ground: StaticBody2D = $Ground
@onready var ground_collision_shape: CollisionShape2D = $Ground/CollisionShape2D
@onready var ground_height : float = ground_collision_shape.shape.size.y

var is_dead = false

func _ready():
	
	position_ground()
	enter_ready()
	
func position_ground():
	var viewport_height : float = get_viewport_rect().size.y
	ground.position.y = viewport_height - ground_height / 2 - SAFE_BOTTOM_MARGIN

func get_ground_top_y() -> float:
	return ground.position.y - ground_height / 2
	
func get_current_speed() -> float:
	var extra := (raw_travel_distance / 1500) * speed_increase_per_1000
	return min(base_speed + extra, max_speed)

func _process(delta):
	delta = min(delta, 0.05)

	if state == GameState.RUNNING:
		update_spikes(delta)
		distance += get_current_speed() * delta * DISTANCE_RATE
		raw_travel_distance += get_current_speed() * delta
		score_label.text = "DISTANCE:" + str(int(distance))
		
		for spike in spawner.get_children():
			spike.position.x -= get_current_speed() * delta
			
func update_spikes(delta):
	var speed :float = get_current_speed()
	distance_since_last_spike += speed * delta

	# scale spacing slightly by speed to keep difficulty consistent
	var spacing_min : float = MIN_SPIKE_SPACING * (base_speed / speed)
	var spacing_max : float = MAX_SPIKE_SPACING * (base_speed / speed)
	
	spacing_min = clamp(spacing_min, 220.0, MIN_SPIKE_SPACING)
	spacing_max = clamp(spacing_max, 350.0, MAX_SPIKE_SPACING)

	if distance_since_last_spike >= target_spike_distance:
		spawner.spawn_spike()
		distance_since_last_spike = 0.0
		target_spike_distance = randf_range(spacing_min, spacing_max)

func enter_ready():
	state = GameState.READY
	distance = 0.0
	raw_travel_distance = 0.0
	distance_since_last_spike = 0.0
	score_label.text = "0"
	
	player.reset()
	clear_spikes()
	
	start.visible = true
	restart.visible = false
	title_label.visible = true
	score_label.hide()
	
	target_spike_distance = randf_range(MIN_SPIKE_SPACING,MAX_SPIKE_SPACING)
	
	
func enter_running():
	state = GameState.RUNNING
	spawner.ground_top_y = get_ground_top_y()
	start.visible = false
	restart.visible = false
	title_label.visible = false
	score_label.show()

func enter_dead():
	state = GameState.DEAD
	restart.visible = true
	
	
	is_dead = true

	# Web hook (safe on desktop)
	if OS.has_feature("web") and is_dead:
		JavaScriptBridge.eval("window.onGameScore && window.onGameScore(" + str(int(distance)) + ");")
		is_dead = false
		


func restart_game():
	enter_ready()
	
func clear_spikes():
	for child in spawner.get_children():
		child.queue_free()
		
func _on_start_pressed() -> void:
	enter_running()
	
func _on_restart_pressed() -> void:
	restart_game()
