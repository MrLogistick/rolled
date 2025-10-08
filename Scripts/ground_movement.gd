extends StaticBody2D

@onready var end_platform: Node2D = $FloorSprite/EndPlatform
var spawn_node
var manager

# Steep: 71.5 Shallow 65.5
const PLATFORM_SIZE: float = 65.5
var spawnpoint: Vector2
var speed: float = 0
var has_spawned = false
var initial: bool = true
var initial_number: int

func _ready() -> void:
	if initial_number <= 0:
		initial = false

func _process(delta: float) -> void:
	if spawnpoint == Vector2.ZERO:
		print("'spawnpoint' has not been set.")
		return
	
	global_position += -transform.x * manager.game_speed * delta
	
	var ep_position = end_platform.global_position
	# spawns a new platform when the edge of the old platform reaches the edge
	if ep_position.x < spawnpoint.x && has_spawned == false:
		spawn_node.spawn_ground(Vector2(ep_position + transform.x * PLATFORM_SIZE / 2), initial)
		has_spawned = true
		
	
	# destroys platform once out of range
	if ep_position.x < -spawnpoint.x:
		queue_free()
