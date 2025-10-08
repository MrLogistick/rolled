extends Node2D

@onready var canvas_layer: CanvasLayer = %CanvasLayer
var distance_text

var distance: float = 0
var start_speed: float = 128
var game_speed: float = start_speed

func _ready() -> void:
	distance_text = canvas_layer.get_child(0)

func _process(_delta: float) -> void:
	_dist_counter(0.1)

func _dist_counter(delay: float):
	await get_tree().create_timer(delay).timeout
	distance += 0.1
	
	var score = round(distance * 100) / 100
	distance_text.text = str("%05.0f" % score) + " Meters"
