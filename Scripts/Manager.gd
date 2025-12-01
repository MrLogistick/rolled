extends Node2D
@onready var player: CharacterBody2D = %Player
@onready var cam: Camera2D = get_node("/root/HamishScene/Camera2D")

@onready var canvas_layer: CanvasLayer = %CanvasLayer
var distance_text
var air_text
var death_screen

var end_multiplier: float = 0.9
var start_speed: float = 164
var top_speed: float = 300
var start_elevation: float = 600

var prev_cam_pos: float = 0
var cam_pos: float = 0
var end = false
var paused = false
var pregame = true
var elevation
var game_speed
var retry = false

func _ready() -> void:
	elevation = start_elevation
	game_speed = start_speed
	
	distance_text = canvas_layer.get_child(0)
	air_text = canvas_layer.get_child(1)
	distance_text.visible = false
	air_text.visible = false

func _process(delta: float) -> void:
	if paused: return
	
	cam_pos = cam.position.y
	distance_text.text = str(int(round(elevation))) + " metres"
	
	var divy = float(player.air) * 0.1
	air_text.text = str(divy) + " PSI"
	
	if pregame: return
	
	if end:
		game_speed *= end_multiplier
		death_screen.get_child(1).text = "@ " + str(int(round(elevation))) + " metres"
		distance_text.visible = false
		air_text.visible = false
		
		if game_speed <= 0.1 && retry == true:
			get_tree().reload_current_scene()
			retry = false
	else:
		if elevation <= 0.0:
			elevation = 0.0
			game_speed *= end_multiplier
			return
		
		elevation -= game_speed / 50 * delta
		distance_text.visible = true
		air_text.visible = true
		
		if cam_pos != prev_cam_pos:
			var drop = (cam_pos - prev_cam_pos) / 50
			prev_cam_pos = cam_pos
			
			if drop > 0:
				elevation -= drop
		
		if !player.is_on_floor() && elevation > 10:
			game_speed += game_speed / 1000 * delta
		else:
			game_speed += game_speed / 50 * delta
