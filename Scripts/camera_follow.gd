extends Camera2D

@onready var player: CharacterBody2D = %Player
@onready var manager: Node2D = %Manager

@export var smoothen: float = 5.0
@export var max_distance: float = 40.0
@export var target_offset: float = 10.0
var previous_pos: float

func _process(delta: float) -> void:
	if smoothen > 0.0: position.y = lerp(position.y, previous_pos, smoothen * delta)
	var distance = player.position.y - position.y
	
	if manager.pregame:
		return
	
	if abs(distance) > max_distance:
		previous_pos = player.position.y + target_offset
	if player.is_on_floor():
		previous_pos = player.last_grounded + target_offset
	
	if manager.end || manager.elevation <= 0.0:
		var diff = previous_pos - position.y
		if diff >= 0.0:
			diff *= manager.end_multiplier
		else:
			diff = 0.0
		previous_pos = diff
