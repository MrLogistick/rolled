extends Label

@onready var player: CharacterBody2D = %Player
var prev_count: float = 0.0
var current_count: float

var flash_time: float = 0.1
var flash_elapsed: float = 0.0
@export var flash_colour: Color = Color.RED
@export var normal_colour: Color = Color.WHITE

func _process(delta: float) -> void:
	current_count = player.air
	flash_elapsed -= delta
	
	if current_count != prev_count || current_count <= player.DOUBLEJUMP_COST:
		prev_count = current_count
		flash_elapsed = flash_time
		modulate = flash_colour
	
	if flash_elapsed <= 0:
		modulate = normal_colour
