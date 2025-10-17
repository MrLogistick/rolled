extends Node2D

@onready var canvas_layer: CanvasLayer = %CanvasLayer
var distance_text

var end = false
var distance: float = 0
@export var start_speed: float = 156
var game_speed: float = start_speed
@export var end_multiplier: float = 0.9
var retry = false
func _ready() -> void:
	distance_text = canvas_layer.get_child(0)

func _process(_delta: float) -> void:
	if end:
		game_speed *= end_multiplier
		
		if game_speed <= 0.1 && retry == true:
			get_tree().reload_current_scene()
			retry = false
	else:
		_dist_counter(0.1)

func _dist_counter(delay: float):
	await get_tree().create_timer(delay).timeout
	distance += 0.1
	
	var score = round(distance * 100) / 100
	distance_text.text = str("%05.0f" % score) + " Meters"
