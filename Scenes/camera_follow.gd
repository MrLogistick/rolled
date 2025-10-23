extends Camera2D

@onready var player: CharacterBody2D = %Player
@onready var manager: Node2D = %Manager

@export var smoothen: float
@export var max_distance: float = 40.0
var previous_pos: float

func _process(delta: float) -> void:
	position.y = lerp(position.y, previous_pos, smoothen * delta)
	var distance = player.position.y - position.y
	
	if abs(distance) > max_distance:
		previous_pos = player.position.y
	if player.is_on_floor():
		previous_pos = player.last_grounded
	
	if player && manager.end:
		smoothen += manager.end_multiplier
	else:
		smoothen = 5.0
