extends Camera2D

@onready var player: CharacterBody2D = %Player
@onready var manager: Node2D = %Manager

@export var MAX_DIST: float = 50
@export var CAM_SPEED: float = 20
@export var ACCELERATION: float = 10
@export var DECCELERATION: float = 0.6
var current_speed: float = 0.0

func _process(delta: float) -> void:
	position.y += current_speed
	clamp(current_speed, -CAM_SPEED, CAM_SPEED)
	
	if manager.end:
		current_speed *= manager.end_multiplier
		return
	
	var y_distance = player.position.y - position.y
	
	if y_distance > MAX_DIST:
		current_speed += ACCELERATION * delta
	elif y_distance < -MAX_DIST:
		current_speed -= ACCELERATION * delta
	else:
		current_speed *= DECCELERATION
