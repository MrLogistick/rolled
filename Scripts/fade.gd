extends Sprite2D

@onready var player: CharacterBody2D = %Player
var fade_speed = 4

func _ready() -> void:
	visible = true

func _process(delta: float) -> void:
	if Global.tutorial: await get_tree().create_timer(1.5).timeout
	player.begin = true
	if modulate.a > 0:
		modulate.a -= fade_speed * delta
	else:
		modulate.a = 0
