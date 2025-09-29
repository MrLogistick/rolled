extends StaticBody2D

@onready var start_platform: Node2D = $StartPlatform
@onready var end_platform: Node2D = $EndPlatform
const GROUND = preload("res://Scenes/ground.tscn")

const SPAWNPOINT: Vector2 = Vector2(155, 95)
const PLATFORM_SIZE = 128
var speed = 60
var has_spawned = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position.x -= speed * delta
	
	var ep_position = end_platform.global_position
	# spawns a new platform when the edge of the old platform reaches the edge
	if ep_position.x < SPAWNPOINT.x && has_spawned == false:
		var ground = GROUND.instantiate()
		get_parent().add_child(ground)
		ground.position = Vector2(ep_position.x + PLATFORM_SIZE / 2, ep_position.y)
		has_spawned = true
	
	if ep_position.x < -SPAWNPOINT.x:
		queue_free()
