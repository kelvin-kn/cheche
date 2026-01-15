extends Node2D

const SAFE_BOTTOM_MARGIN : int = 150

enum GameState { READY, RUNNING, DEAD }
var state: GameState = GameState.READY

var distance : int = 0
var world_speed : float = 280.0  # must match spike speed
var rate : float = 0.1

@onready var player : CharacterBody2D = $Player
@onready var spawner : Node2D = $Spawner

@onready var start: Button = $CanvasLayer/Start
@onready var restart: Button = $CanvasLayer/Restart
@onready var title_label := $CanvasLayer/TitleLabel
@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var ground: StaticBody2D = $Ground
@onready var ground_collision_shape: CollisionShape2D = $Ground/CollisionShape2D
@onready var ground_height : float = ground_collision_shape.shape.size.y

func _ready():
	position_ground()
	enter_ready()
	
func position_ground():
	var viewport_height : float = get_viewport_rect().size.y
	ground.position.y = viewport_height - ground_height / 2 - SAFE_BOTTOM_MARGIN

func get_ground_top_y() -> float:
	return ground.position.y - ground_height / 2

func _process(delta):
	delta = min(delta, 0.05)
	
	if state == GameState.RUNNING:
		distance += world_speed * delta * rate
		world_speed += 1 * delta
		score_label.text = "DISTANCE" + str(int(distance))
		
func enter_ready():
	state = GameState.READY
	distance = 0
	score_label.text = "0"
	
	player.reset()
	spawner.stop()
	clear_spikes()
	
	start.visible = true
	restart.visible = false
	title_label.visible = true
	score_label.hide()
	
func enter_running():
	state = GameState.RUNNING
	spawner.ground_top_y = get_ground_top_y()
	start.visible = false
	restart.visible = false
	title_label.visible = false
	score_label.show()
	spawner.start()

func enter_dead():
	state = GameState.DEAD

	spawner.stop()
	restart.visible = true

	# Web hook (safe on desktop)
	if OS.has_feature("web"):
		JavaScriptBridge.eval("window.onGameScore && window.onGameScore(" + str(int(distance)) + ");")
		
func restart_game():
	enter_ready()
	
func clear_spikes():
	for child in spawner.get_children():
		child.queue_free()
		
func _on_start_pressed() -> void:
	enter_running()
	
func _on_restart_pressed() -> void:
	restart_game()
