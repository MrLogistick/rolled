extends Node2D
@onready var player: CharacterBody2D = %Player

@onready var canvas_layer: CanvasLayer = %CanvasLayer
var distance_text
var death_screen

@export var end_multiplier: float = 0.9
@export var start_speed: float = 156
@export var start_elevation: float = 1200
@export var speed_to_distance_conversion: float = 1000

var end = false
var elevation
var game_speed
var retry = false

func _ready() -> void:
	elevation = start_elevation
	game_speed = start_speed
	
	distance_text = canvas_layer.get_child(0)

func _process(_delta: float) -> void:
	if end:
		game_speed *= end_multiplier
		death_screen.get_child(1).text = "@ " + str(int(round(elevation))) + " metres"
		
		if game_speed <= 0.1 && retry == true:
			get_tree().reload_current_scene()
			retry = false
	else:
		distance_text.text = str(int(round(elevation))) + " metres"
		
		elevation -= game_speed / speed_to_distance_conversion
		# game_speed += 0.01
