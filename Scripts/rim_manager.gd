extends AnimatedSprite2D

@onready var player: CharacterBody2D = %Player
var frame_count = sprite_frames.get_frame_count(animation)

var r: float = 0.0
var set_r: float = 1.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if player.air <= 0.01:
		visible = true
		# r += clamp(0.05 * delta, 0.0, 1.0)
		# modulate = Color(set_r, 1 - r, 1 - r, 1)
	else:
		visible = false
		# set_r = 1 - r
	
	var t = clamp(player.health / player.INITIAL_HEALTH, 0.0, 1.0)
	frame = int((1.0 - t) * (frame_count - 1))
